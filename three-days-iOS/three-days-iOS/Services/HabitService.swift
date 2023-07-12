//
//  HabitService.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/30.
//

import Foundation
import Combine

struct HabitService {
    private var cancellables = Set<AnyCancellable>()
    private let habitURL = "\(Config.apiURL)/api/v1/habits"
    
    
//    {
//      "title": "물마셔..",
//      "imojiPath": "",
//      "color": "GREEN",
//      "dayOfWeeks": [
//        "MONDAY",
//        "TUESDAY",
//        "FRIDAY"
//      ],
//      "notification": {
//        "notificationTime": "07:07:42.44742044",
//        "contents": "알림짝짝"
//      }
//    }
    
    /// 습관 생성하기
    mutating func createHabit(newHabit: Habit, completion: @escaping (Result<Habit, Error>) -> Void) {
        let url = URL(string: habitURL)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
     
        request.httpBody = try? JSONSerialization.data(withJSONObject: newHabit)
        print("======= REQUEST : \(request) =======")
        print("Request Body: \(String(describing: request.httpBody))")
        
        NetworkAgent.executeRequest(request, responseType: Habit.self)
            .sink(receiveCompletion: { sinkCompletion in
                switch sinkCompletion { // 네트워크 실패
                case .finished:
                    break
                case .failure(let error):
                    print("💥 NETWORK FAILED: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }, receiveValue: { response in // 네트워크 성공
                completion(.success(response))
            })
            .store(in: &cancellables)
    }
    
    /// 습관 목록 가져오기
    
    /// 습관 상세 정보 조회
    
    /// 습관 수정
    
    /// 습관 삭제
}
