//
//  three_days_iOSApp.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/19.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import FirebaseCore
import AuthenticationServices

@main
struct three_days_iOSApp: App {
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: Config.kakaoAppKey)
        
        // Firebase 초기화
        FirebaseApp.configure()
        
        // Apple 로그인 초기화
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("Authorized")
                DispatchQueue.main.async {
                    // ??
                }
                
            case .revoked:
                print("Revoked")
                
            case .notFound:
                print("Not Found")
                
            default:
                break
            }
            
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
