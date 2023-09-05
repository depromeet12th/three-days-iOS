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
