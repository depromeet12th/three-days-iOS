//
//  Utils.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/18.
//

import Foundation
import Combine

/// Result 확장
extension Result {
    func publisher() -> AnyPublisher<Success, Failure> {
        switch self {
        case .success(let value):
            return Just(value)
                .setFailureType(to: Failure.self)
                .eraseToAnyPublisher()
            
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}