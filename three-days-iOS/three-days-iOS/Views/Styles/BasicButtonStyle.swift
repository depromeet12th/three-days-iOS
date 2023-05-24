//
//  BasicButtonStyle.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/23.
//

import SwiftUI

struct BasicButtonStyle: ButtonStyle {
    let backgroundColor = Color("mainColor")
    let fontColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 320, height: 56)
            .background(backgroundColor)
            .cornerRadius(15)
            .font(.custom("SUIT-SemiBold", size: 16))
            .foregroundColor(fontColor)
    }
}
