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

@main
struct three_days_iOSApp: App {
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: Config.kakaoAppKey)
        // Firebase 초기화
        FirebaseApp.configure()
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
