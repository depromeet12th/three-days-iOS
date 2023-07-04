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
    
    /// Apple 로그인
    ///
    ///
    ///
    //let userIndentifier = appleIDCredential.user
//    let fullName = appleIDCredential.fullName
//    let email = appleIDCredential.email
//    let identifyToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
//    let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
    
    /// {
//    "certificationSubject":"APPLE",
//    "socialToken":"eyJraWQiOiJXNldjT0tCIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJodHRwczovL2FwcGxlaWQuYXBwbGUuY29tIiwiYXVkIjoiY29tLmRlcHJvbWVldC50aHJlZURheXMuYXBwbGVMb2dpbiIsImV4cCI6MTY4NjU4MjAyMywiaWF0IjoxNjg2NDk1NjIzLCJzdWIiOiIwMDAyMjIuMDc4ZjUxMTA2OGZmNDYyZGFkMjU0MzVkODczZDAwNDAuMDQxNyIsIm5vbmNlIjoibm9uY2UiLCJjX2hhc2giOiJLS3lVWUF2c1dhalQ4TEY2THRiODR3IiwiZW1haWwiOiJzcG15d2R4N2t5QHByaXZhdGVyZWxheS5hcHBsZWlkLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImlzX3ByaXZhdGVfZW1haWwiOiJ0cnVlIiwiYXV0aF90aW1lIjoxNjg2NDk1NjIzLCJub25jZV9zdXBwb3J0ZWQiOnRydWV9.cHSbvxgrK_WMHoMKf1Rb50tON7f4jBVYZEPrgK_n3u7eFC7nuNkMqKL_5Z3JBw-7WOaErl7ZB2C9YaQIs8NygfCl4WUSXcM-rXK9Z8aSMiPiQ295WdIZMjW4PmbEcTQuf3CxyFAOtS02r82QKplaGDo-YeZ2QCuhacXmkkBZVmkVDGyKHG16FrpP7W6PVi4ptoukldXiV6M6WO2_jtbKnjjryx85C_HqOboY_Dj9sqD5xhomwiPAWwZVJVVjOwFLWNhKtcgMSQOgYN7R15vvvwGqa_pl3AnglltpQGL6pARs7ZCEmpa7QYGEq2JSELycwU6OWQqWZY9a6y3YOQR2oQ",
//    "code":"cf6101fee05a147b9b0f3d24b382b6e34.0.rsss.gRmR0tZMPlqkZyle3h3TQw",
//      "nonce":"nonce",
//      "user": {
//        "email":"apple proxy email",
//        "name":
//          {
//            "firstName":"JONGJUN",
//            "lastName":"KIM"
//          }
//      }
//   }
//
//    mutating func appleLogin(certificationSubject: String, socialToken: String, code: String, nonce: String, email: String, firstName: String, lastName: String, completion: @escaping (Result<Member, Error>) -> Void) {
//        let loginURL = "\(Config.apiURL)/api/v1/members/apple"
//        let url = URL(string: loginURL)!
//        var request = URLRequest(url: url)
//
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        let name = ["firstName": firstName, "lastName": lastName]
//        let user = ["email": email, "name": name]
//        let body: [String: Any] = [
//            "certificationSubject": certificationSubject,
//            "socialToken": socialToken,
//            "code": code,
//            "nonce": nonce,
//            "user": user
//        ]
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//        print("======= REQUEST : \(request) =======")
//        print("Request Body: \(body)")
//
//        NetworkAgent.executeRequest(request, responseType: Member.self)
//            .sink(receiveCompletion: { sinkCompletion in
//                switch sinkCompletion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print("NETWORK FAILED: \(error.localizedDescription)")
//                    completion(.failure(error))
//                }
//            }, receiveValue: { response in
//                completion(.success(response))
//            })
//            .store(in: &cancellables)
//    }
//
//
    mutating func appleLogin(certificationSubject: String, socialToken: String, code: String, completion: @escaping (Result<Member, Error>) -> Void) {
        let loginURL = "\(Config.apiURL)/api/v1/members/apple"
        let url = URL(string: loginURL)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let name = ["firstName": "Jungin", "lastName": "Choi"]
        let user = ["email": "wjddls980912@naver.com", "name": name] as [String : Any]
        let body: [String: Any] = [
            "certificationSubject": certificationSubject,
            "socialToken": "eyJraWQiOiJmaDZCczhDIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJodHRwczovL2FwcGxlaWQuYXBwbGUuY29tIiwiYXVkIjoiY29tLmRlcHJvbWVldC50aHJlZURheXMuYXBwbGVMb2dpbiIsImV4cCI6MTY4ODU1OTQxNSwiaWF0IjoxNjg4NDczMDE1LCJzdWIiOiIwMDAyMjIuMDc4ZjUxMTA2OGZmNDYyZGFkMjU0MzVkODczZDAwNDAuMDQxNyIsIm5vbmNlIjoibm9uY2UiLCJjX2hhc2giOiJKQ09BSXVvb00wS25UNnhXNEZqVVVRIiwiZW1haWwiOiJzcG15d2R4N2t5QHByaXZhdGVyZWxheS5hcHBsZWlkLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjoidHJ1ZSIsImlzX3ByaXZhdGVfZW1haWwiOiJ0cnVlIiwiYXV0aF90aW1lIjoxNjg4NDczMDE1LCJub25jZV9zdXBwb3J0ZWQiOnRydWV9.JeQJQp17NweDZFTXTSKMePHrKUMVUlDaZjRXWbNTl5r5hJoUaavFFJwP_e2GGQbEtIm9LgvGN8chdYpZfMpEhtGqPInEIANl9X1ooS0nv9qpQ4OloO1AYC9Kul0S41rectEgHE8XkIvbgPTsDRNuh7xBDJzMu0GJ3Tir9Nz20iwZeaVxJBIm4Cf4Z9ehjIZ1e7P6taDkaG1ACn94RPOe3K_sRYV_zj4-5KLSCM7Bs8nDBJnEkBzW9CNysT_DVyg2YJ68Civ7Cp6I2zXjJLfve8MEOhnDMC1n9YCAKpJKVSh1oCzCoJATUTkzjlfMO3BV25RZRWrhyuhlgn9CQPDGEQ",
            "code": "c5844abdcec8b4feeb2a86ce4870e6851.0.rsss.qJHDmUk0t4vy40ARwiCjgg",
            "nonce": "nonce",
            "user": user
        ]
        
        
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
