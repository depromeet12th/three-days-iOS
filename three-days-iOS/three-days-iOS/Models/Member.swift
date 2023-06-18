//
//  Member.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/24.
//

import Foundation

//struct Member: Decodable {
//    let id: Int64
//    let name: String
//    let resource: String
//    let notificationConsent: Bool
//    let certificationSubject: String
//    let token: Token
//}
//
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


//Decodable {
//    var id: Int
//    var accountId: String
//    var nickname: String
//    var userRole: String
//    var accessToken: String
//    var refreshToken: String
//
//    static func from(_ authorization: Authorization) -> Auth {
//        return Auth(
//            id: Int(truncatingIfNeeded: authorization.id),
//            accountId: authorization.accountId ?? "",
//            nickname: authorization.nickname ?? "",
//            userRole: authorization.userRole ?? "",
//            accessToken: authorization.accessToken ?? "",
//            refreshToken: authorization.refreshToken ?? ""
//        )
//    }
//}
//
///// 토큰 데이터
//struct Token: Decodable {
//    var accessToken: String
//    var refreshToken: String
//}


//
//{
//  "data": {
//    "id": 0, // 회원 ID
//    "name": "admin", // 회원명
//    "certificationSubject": "KAKAO", // 인증서버 종류
//    "status": "REGULAR", // 회원 Status
//    "notificationConsent": false, // 알람 수신 여부
//    "resource": {}
//  },
//  "message": "성공",
//  "code": "success"
//}


//    {
//      "data": {
//        "id": 0,
//        "name": "admin",
//        "resource": "{}",
//        "notificationConsent": true,
//        "certificationSubject": "KAKAO",
//        "token": {
//          "accessToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJtZW1iZXJJZCI6MSwiaWF0IjoxNjY5Nzc4NjQwLCJleHAiOjE2NzAwNTEwNzN9.qRYwNldwTJCBdcRa13zm9At-NKTnqM6K8FQzsnUHcPY",
//          "refreshToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzM4NCJ9.eyJtZW1iZXJJZCI6MSwiaWF0IjoxNjcwNTc4MzAzLCJleHAiOjE2NzI3MjU3ODZ9._eQlJYPHHaruePkVFvA6vD8zy2qj9dNLjtI0rCCQ5jLBia5Xiz5QouSRdtawHkUF"
//        }
//      },
//      "message": "새로 생성되었습니다.",
//      "code": "resource.created"
//    }
