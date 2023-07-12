//
//  Mate.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/07/12.
//

import Foundation

struct Mate: Codable {
    var id: Int
    var habitId: Int
    var memberId: Int
    var title: String
    var createAt: String
    var level: Int
    var reward: Int
    var rewardHistory: [RewardHistory]
    var levelUpAt: String
    var characterType: String
    var levelUpSection: [Int]
    var bubble: String
    var status: String
    var deleted: Bool
    
    init() {
        id = 0
        habitId = 0
        memberId = 0
        title = ""
        createAt = ""
        level = 0
        reward = 0
        rewardHistory = []
        levelUpAt = ""
        characterType = ""
        levelUpSection = []
        bubble = ""
        status = ""
        deleted = false
    }
}

struct RewardHistory: Codable {
    let createAt: Date
    
    init() {
        createAt = Date()
    }
}
