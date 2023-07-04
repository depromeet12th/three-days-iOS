//
//  MemberService.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/22.
//

import Foundation
import Combine
import KeychainAccess
import FirebaseMessaging

struct MemberService {
    private var cancellables = Set<AnyCancellable>()
    
    /// 멤버 추가
    mutating func login(certificationSubject: String, socialToken: String, completion: @escaping (Result<Member, Error>) -> Void) {
        let loginURL = "\(Config.apiURL)/api/v1/members"
        let url = URL(string: loginURL)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let body = ["certificationSubject": certificationSubject, "socialToken": socialToken]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        print("======= REQUEST : \(request) =======")
        print("Request Body: \(body)")
        
        NetworkAgent.executeRequest(request, responseType: Member.self)
            .sink(receiveCompletion: { sinkCompletion in
                switch sinkCompletion { // 네트워크 실패
                case .finished:
                    break
                case .failure(let error):
                    print("NETWORK FAILED: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }, receiveValue: { response in // 네트워크 성공
                completion(.success(response))
            })
            .store(in: &cancellables)
    }
    
    /// 키체인에 token 값 저장
    func setTokenToKeychain(accessToken: String, refreshToken: String) {
        let keychain = Keychain(service: "\(Config.bundleID)")
        
        do {
            try keychain.set(accessToken, key: "accessToken")
            try keychain.set(refreshToken, key: "refreshToken")
        } catch {
            print("Failed to save tokens to Keychain: \(error)")
        }
    }
    
    /// 저장된 token 값 키체인에서 가져오기
    func getTokenFromKeychain() -> (accessToken: String?, refreshToken: String?) {
        let keychain = Keychain(service: "\(Config.bundleID)")
        
        do {
            let accessToken = try keychain.get("accessToken")
            let refreshToken = try keychain.get("refreshToken")
            return (accessToken, refreshToken)
        } catch {
            print("Failed to get tokens from Keychain: \(error)")
            return (nil, nil)
        }
    }
    
    ///
    func checkLoginStatus() -> Bool {
        let tokens = self.getTokenFromKeychain()
        if tokens.accessToken != nil {
            return true
        }
        return false
    }
    
    /// FCM 토큰 등록
    mutating func registerFCMToken(fcmToken: String, identificationKey: String, completion: @escaping (Result<FCM, Error>) -> Void) {
        let fcmURL = "\(Config.apiURL)/api/v1/clients"
        let url = URL(string: fcmURL)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let body = ["fcmToken": fcmToken, "identificationKey": identificationKey]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        print("======= REQUEST : \(request) =======")
        print("Request Body: \(body)")
        
        NetworkAgent.executeRequest(request, responseType: FCM.self)
            .sink(receiveCompletion: { sinkCompletion in
                switch sinkCompletion { // 네트워크 실패
                case .finished:
                    break
                case .failure(let error):
                    print("NETWORK FAILED: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }, receiveValue: { response in // 네트워크 성공
                completion(.success(response))
            })
            .store(in: &cancellables)
    }
    
}
