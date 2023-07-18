//
//  CustomImojiPicker.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/07/18.
//

import SwiftUI

struct CustomImojiPicker: View {
    let faceImojiList: [String] = ["😀", "😆", "😂", "☺️", "😇", "🙂"]
    let foodImojiList: [String] = ["🍖", "🍋", "🍕"]
    let animalImojiList: [String] = ["🐰", "🐺", "🐷"]
    let symbolImojiList: [String] = ["❤️"] // symbol + objects
    let activityImojiList: [String] = ["🎾"]
    
    @Binding var isShowing: Bool
    var imojiSection: Int = 0 // 0...4까지 이모지 섹션
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 배경
            Color("bk")
                .opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    isShowing.toggle()
                }
            
            imjoiSelectionView
                .transition(.move(edge: .bottom))
                .background(Color("gray100"))
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .frame(height: 439)
                
        }
    }
}

extension CustomImojiPicker {
    var imjoiSelectionView: some View {
        ScrollView {
            HStack {
                
            }
        }
    }
}

struct CustomImojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomImojiPicker(isShowing: .constant(true))
    }
}
