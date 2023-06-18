//
//  LoginRepository.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/11.
//

import Foundation
import Combine
import KeychainAccess

struct MemberRepository {
    private let loginURL = "\(Config.apiURL)/api/v1/members"
    private let logoutURL = "\(Config.apiURL)/api/v1/members/logout"
    
    private var cancellables = Set<AnyCancellable>()
    
    /// 멤버 추가
    mutating func login(certificationSubject: String, socialToken: String, completion: @escaping (Result<Member, Error>) -> Void) {
        let urlString = "\(loginURL)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let body = ["certificationSubject": certificationSubject, "socialToken": socialToken]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        print(request)
        
        APIService.executeRequest(request, responseType: Member.self)
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
    
    /// token들을 키체인에 저장하는 함수
    func saveTokenToKeychain(accessToken: String, refreshToken: String) {
        let keychain = Keychain(service: "com.depromeet.three-days-iOS")
        
        do {
            try keychain.set(accessToken, key: "accessToken")
            try keychain.set(refreshToken, key: "refreshToken")
        } catch {
            print("Failed to save tokens to Keychain: \(error)")
        }
    }
    
    /// 키체인에서 저장된 token 값 가져오는 함수
    func retrieveTokenFromKeychain() -> (accessToken: String?, refreshToken: String?) {
        let keychain = Keychain(service: "com.depromeet.three-days-iOS")
        
        do {
            let accessToken = try keychain.get("accessToken")
            let refreshToken = try keychain.get("refreshToken")
            
            return (accessToken, refreshToken)
        } catch {
            print("Failed to retrieve tokens from Keycahin: \(error)")
            return (nil, nil)
        }
    }
    
    /// 저장된 토큰 검사 후, 자동 로그인 설정
    func checkLoginStatus() -> Bool {
        let tokens = self.retrieveTokenFromKeychain()
        if let accessToken = tokens.accessToken {
            return true
        } else {
            return false
        }
    }
}
