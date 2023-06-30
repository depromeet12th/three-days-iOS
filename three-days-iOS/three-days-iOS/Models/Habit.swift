//
//  Habit.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/30.
//

import Foundation

struct Habit: Codable {
    var title: String
    var imojiPath: String
    var color: String
    var dayOfWeeks: [String]
    var notification: Notification
}

struct Notification: Codable {
    var notificationTime: String
    var contents: String
}

//{
//  "title": "물마셔..",
//  "imojiPath": "😀",
//  "color": "GREEN",
//  "dayOfWeeks": [
//    "MONDAY",
//    "TUESDAY",
//    "FRIDAY"
//  ],
//  "notification": {
//    "notificationTime": "07:07:42.44742044",
//    "contents": "알림짝짝"
//  }
//}

//{
//  "data": [
//    {
//      "id": 0,
//      "memberId": 0,
//      "title": "물무",
//      "imojiPath": "😀",
//      "dayOfWeeks": [
//        "MONDAY",
//        "TUESDAY",
//        "FRIDAY"
//      ],
//      "reward": 0,
//      "color": "GREEN",
//      "status": "ACTIVE",
//      "createAt": "2023-04-20T07:07:42.682509815",
//      "archiveAt": "2023-04-20T07:07:42.682511515",
//      "totalAchievementCount": 0,
//      "todayHabitAchievementId": 0,
//      "sequence": 0,
//      "mate": {
//        "id": 0,
//        "habitId": 0,
//        "memberId": 0,
//        "title": "짝꿍이",
//        "createAt": "2023-04-20T07:07:42.682530016",
//        "level": 0,
//        "reward": 0,
//        "rewardHistory": [
//          {
//            "createAt": "2023-04-20T07:07:42.682518415"
//          }
//        ],
//        "levelUpAt": "2023-04-20T07:07:42.682531816",
//        "characterType": "CARROT",
//        "levelUpSection": [
//          1,
//          4,
//          8,
//          14,
//          22
//        ],
//        "bubble": "5252! 믿고 있었다구~ 오늘도 파이팅",
//        "status": "ACTIVE",
//        "deleted": false
//      }
//    }
//  ],
//  "message": "성공",
//  "code": "success"
//}
