//
//  HabitViewModel.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/30.
//

import Foundation
import Combine


class HabitViewModel: ObservableObject {
    @Published var habits = [Habit]()
    @Published var habit = Habit()
    
    var habitService = HabitService()
    
    /// 습관 생성
    func createHabit(newHabit: Habit) {
        
    }
}
