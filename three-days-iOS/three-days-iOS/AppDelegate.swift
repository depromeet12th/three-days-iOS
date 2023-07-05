//
//  AppDelegate.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/07/03.
//

import Foundation
import UIKit
import Firebase
import FirebaseMessaging
import AuthenticationServices

// Firebase 연결
class AppDelegate: UIResponder, UIApplicationDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    static let shared = AppDelegate()
    
    private override init() {}
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let anchor = UIApplication.shared.windows.first else {
            return ASPresentationAnchor()
        }
        return anchor
    }
    
    // Apple 로그인 성공 시,
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        let loginViewModel = LoginView().vm
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            print("Authorization Successful! 🎉")
    
            let userIndentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let identifyToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
            let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
            
            print("userIndentifier: \(userIndentifier)")
            print("fullName: \(fullName?.givenName ?? "")  \(fullName?.familyName ?? "")")
            print("email: \(email ?? "")")
            print("identifyToken: \(identifyToken ?? "")")
            print("authorizationCode: \(authorizationCode ?? "")")
            
            // TODO: 첫 로그인 시도 시, UserDefaults에 fullName · email 저장하기
            loginViewModel.appleLogin(certificationSubject: "APPLE", socialToken: identifyToken ?? "", code: authorizationCode ?? "", firstName: fullName?.givenName ?? "", lastName: fullName?.familyName ?? "", email: email ?? "")
        }
    }
    
    // Apple 로그인 실패 시,
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorization Failed: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        var memberService = MemberService()
        FirebaseApp.configure()
        
        // FCM 토큰 등록 로직 추가
        if let token = Messaging.messaging().fcmToken {
            memberService.registerFCMToken(fcmToken: token, identificationKey: getDeviceID()!) { result in
                
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // FCM 토큰 등록
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // 푸시 알림 수신 처리
    }
    
    
    /// 사용자 데이터 초기화
    func resetUserData() {
        
    }
}
