//
//  Config.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/02.
//

import Foundation

struct Config {
    static let apiURL = Bundle.main.object(forInfoDictionaryKey: "API_URL")!
    static let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as! String
}
