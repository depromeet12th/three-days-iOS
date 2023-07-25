//
//  Habit.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/30.
//

import Foundation

struct Habit: Codable {
    var id: Int
    var memberId: Int
    var title: String
    var emojiPath: String
    var color: String
    var dayOfWeeks: [String]
    var notification: Notification
    let reward: Int
    let status: String
    let createAt: Date
    let archiveAt: Date
    let totalAchievementCount: Int
    let todayHabitAchievementId: Int
    let sequence: Int
    let mate: Mate
    
    init() {
        id = 0
        memberId = 0
        title = ""
        emojiPath = "😀"
        color = "GREEN"
        dayOfWeeks = []
        notification = Notification()
        reward = 0
        status = ""
        createAt = Date()
        archiveAt = Date()
        totalAchievementCount = 0
        todayHabitAchievementId = 0
        sequence = 0
        mate = Mate()
    }
}

struct Notification: Codable {
    var notificationTime: String
    var contents: String
    
    init() {
        notificationTime = ""
        contents = ""
    }
}

//import Foundation
//
//struct Habit: Codable {
//    let id: Int
//    let memberId: Int
//    let title: String
//    let imojiPath: String
//    let dayOfWeeks: [String]
//    let reward: Int
//    let color: String
//    let status: String
//    let createAt: Date
//    let archiveAt: Date
//    let totalAchievementCount: Int
//    let todayHabitAchievementId: Int
//    let sequence: Int
//    let mate: Mate
//
//    struct Mate: Codable {
//        let id: Int
//        let habitId: Int
//        let memberId: Int
//        let title: String
//        let createAt: Date
//        let level: Int
//        let reward: Int
//        let rewardHistory: [RewardHistory]
//        let levelUpAt: Date
//        let characterType: String
//        let levelUpSection: [Int]
//        let bubble: String
//        let status: String
//        let deleted: Bool
//    }
//
//    struct RewardHistory: Codable {
//        let createAt: Date
//    }
//}
//
//// POST 요청
//let habit = Habit(id: 1, memberId: 1, title: "물마셔", imojiPath: "😀", dayOfWeeks: ["MONDAY", "TUESDAY"], reward: 0, color: "GREEN", status: "ACTIVE", createAt: Date(), archiveAt: Date(), totalAchievementCount: 0, todayHabitAchievementId: 0, sequence: 0, mate: Habit.Mate(id: 1, habitId: 1, memberId: 1, title: "짝꿍이", createAt: Date(), level: 1, reward: 0, rewardHistory: [], levelUpAt: Date(), characterType: "CARROT", levelUpSection: [1, 4, 8, 14, 22], bubble: "5252! 믿고 있었다구~ 오늘도 파이팅", status: "ACTIVE", deleted: false))
//
//let encoder = JSONEncoder()
//encoder.dateEncodingStrategy = .iso8601
//
//do {
//    let jsonData = try encoder.encode(habit)
//    let jsonString = String(data: jsonData, encoding: .utf8)
//    print(jsonString ?? "")
//} catch {
//    print("Error encoding habit: \(error)")
//}
//
//// GET 응답
//let jsonString = """
//{
//    "id": 1,
//    "memberId": 1,
//    "title": "물마셔",
//    "imojiPath": "😀",
//    "dayOfWeeks": ["MONDAY", "TUESDAY"],
//    "reward": 0,
//    "color": "GREEN",
//    "status": "ACTIVE",
//    "createAt": "2023-07-12T12:00:00Z",
//    "archiveAt": "2023-07-12T12:00:00Z",
//    "totalAchievementCount": 0,
//    "todayHabitAchievementId": 0,
//    "sequence": 0,
//    "mate": {
//        "id": 1,
//        "habitId": 1,
//        "memberId": 1,
//        "title": "짝꿍이",
//        "createAt": "2023-07-12T12:00:00Z",
//        "level": 1,
//        "reward": 0,
//        "rewardHistory": [],
//        "levelUpAt": "2023-07-12T12:00:00Z",
//        "characterType": "CARROT",
//        "levelUpSection": [1, 4, 8, 14, 22],
//        "bubble": "5252! 믿고 있었다구~ 오늘도 파이팅",
//        "status": "ACTIVE",
//        "deleted": false
//    }
//}
//""".data(using: .utf8)!
//
//let decoder = JSONDecoder()
//decoder.dateDecodingStrategy = .iso8601
//
//do {
//    let decodedHabit = try decoder.decode(Habit.self, from: jsonString)
//    print(decodedHabit)
//} catch {
//    print("Error decoding habit: \(error)")
//}
//
//


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
