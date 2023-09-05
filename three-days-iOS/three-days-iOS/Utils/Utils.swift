//
//  Utils.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/18.
//

import Foundation
import UIKit
import SwiftUI
import Combine



struct HourPicker: View {
    @Binding var selectedHour: Int
    
    var body: some View {
        Picker("", selection: $selectedHour) {
            ForEach(0..<24, id: \.self) { hour in
                Text(String(format: "%02d", hour))
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 80)
    }
}

struct MinutePicker: View {
    @Binding var selectedMinute: Int
    
    var body: some View {
        Picker("", selection: $selectedMinute) {
            ForEach(0..<2, id: \.self) { minute in
                Text(String(format: "%02d", minute * 30))
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 80)
    }
}



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

/// 현재 날짜 가져오기 (원하는 형식에 맞게)
class DateUtil {
    static func getCurrentDate(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}

/// deviceID 가져오기
func getDeviceID() -> String? {
    if let uuid = UIDevice.current.identifierForVendor?.uuidString {
        return uuid
    }
    return nil
}

// 원하는 모서리만 round 시킬 수 있도록 확장
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension UserDefaults {
    static let isLogginedKey = "isLoggined"
}

// 
func sizeFitToScreen(_ size: CGFloat) -> CGFloat {
    return 0
}

class EmojiList {
    let faceEmojiList: [String] = ["😀", "😆", "😂", "☺️", "😇", "🙂", "😉", "😌", "😍", "😜", "😎", "🥳", "😞", "☹️", "🥺", "😡", "😳", "🤔", "🤭", "🙄", "😪", "🤖", "🤤", "😐", "🥴", "😈", "💩", "👻", "☠️", "👽"]
    let foodEmojiList: [String] = ["🍖", "🍋", "🍕", "☕", "🍟", "🍛", "🥦", "🍎", "🧋", "🍤", "🍇", "🥞", "🍠", "🥐", "🍌", "🌭", "🥪", "🍑", "🍵", "🥓", "🍏", "🍔", "🍷", "🍉", "🧇", "🍅", "🍊", "🌮", "🍣", "🥙"]
    let animalEmojiList: [String] = ["🐰", "🐺", "🐷", "🐧", "🐼", "🐙", "🐭", "🐵", "🦁", "🐨", "🐴", "🐹", "🐤", "🐸", "🦊", "🐬", "🐶", "🐱", "🐮", "🐔", "🐗", "🐻", "🐜", "🦄", "🐯", "🌲", "🍀", "🌸", "🌷", "☘️", "🌱", "🌹", "🌳", "⚡️", "🌙", "☀️", "💧", "☁️", "⭐️", "🔥", "💥", "🌏", "🐝"]
    let objectEmojiList: [String] = ["❤️", "🤍", "💚", "💙", "🤎", "💛", "💜", "🧡", "🖤", "❣️", "💖", "🚫", "♨️", "💯", "💢", "⭕️", "❌", "⚠️", "🎶", "🛍", "🎉", "🔫", "💸", "🔍", "💊", "🤖", "📙", "📝", "🎀", "👟", "🚿", "🪥", "✏️", "⏰", "📌", "🎙", "👙", "💧", "💣", "💎", "🧸", "🎁", "💻", "🧨", "📗", "🚬", "📕", "📘", "💡"] // symbol + objects
    let activityEmojiList: [String] = ["🎾", "⚽️", "🥎", "🏉", "🎳", "🏀", "⚾️", "🏈", "🏐", "⛳️", "🥊", "🏸", "🎽", "🩱", "🥋", "⛱️", "🏆", "🎮", "🎬", "🎯", "🏓", "🎲", "🎱", "♟️", "🎣", "🎹", "🎨", "🥁", "🎻", "🎸", "🧶", "🎤", "🧩", "🧗", "🚴", "🧘", "🚗", "🚀", "✈️", "🚲", "⛵", "🛸", "🚨", "🏖", "🏝", "🪐", "🏠", "⛺"]
}
