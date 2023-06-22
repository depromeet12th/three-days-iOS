//
//  Member.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/24.
//

import Foundation

struct Member: Decodable {
    var id: Int64
    var name: String
    var certificationSubject: String
    var notificationConsent: Bool
    var token: Token
}

struct Token: Decodable {
    var accessToken: String
    var refreshToken: String
}
