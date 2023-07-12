//
//  BasicButtonStyle.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/23.
//

import SwiftUI

struct BasicButtonStyle: ButtonStyle {
    var backgroundColor = Color("mainColor")
    var fontColor: Color = .white
    var customFont: String = "SUIT-SemiBold"
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 320, height: 56)
            .background(backgroundColor)
            .cornerRadius(15)
            .font(.custom(customFont, size: 16))
            .foregroundColor(fontColor)
    }
}
