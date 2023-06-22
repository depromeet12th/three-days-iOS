//
//  MemberService.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/22.
//

import Foundation
import Combine
import KeychainAccess

struct MemberService {
    private let loginURL = "\(Config.apiURL)/api/v1/members"
    private var cancellables = Set<AnyCancellable>()
    
    /// 멤버 추가
    mutating func login(certificationSubject: String, socialToken: String, completion: @escaping (Result<Member, Error>) -> Void) {
        let url = URL(string: loginURL)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let body = ["certificationSubject": certificationSubject, "socialToken": socialToken]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        print(request)
        
        NetworkAgent.executeRequest(request, responseType: Member.self)
            .sink(receiveCompletion: { sinkCompletion in
                switch sinkCompletion {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { response in
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
}
