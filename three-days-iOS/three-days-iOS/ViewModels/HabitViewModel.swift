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
}
