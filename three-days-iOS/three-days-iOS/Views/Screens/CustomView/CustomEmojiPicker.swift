//
//  CustomEmojiPicker.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/07/18.
//

import SwiftUI

struct CustomEmojiPicker: View {
    let faceEmojiList: [String] = ["😀", "😆", "😂", "☺️", "😇", "🙂"]
    let foodEmojiList: [String] = ["🍖", "🍋", "🍕"]
    let animalEmojiList: [String] = ["🐰", "🐺", "🐷"]
    let symbolEmojiList: [String] = ["❤️"] // symbol + objects
    let activityEmojiList: [String] = ["🎾"]
    
    @Binding var isShowing: Bool
    @State var emojiSection: Int = 0 // 0...4까지 이모지 섹션
    let emojiCategory: [String] = ["face", "food", "animal", "symbol", "activity"]
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 배경
            Color("bk")
                .opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    isShowing.toggle()
                }
            
            emojiSelectionView
                .transition(.move(edge: .bottom))
                .background(Color("gray100"))
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .frame(height: 439)
                
        }
    }
}

extension CustomEmojiPicker {
    var emojiSelectionView: some View {
        ScrollView {
            VStack {
                HStack {
                    ForEach(0..<5, id: \.self) { idx in
                        Button(action: {
                            emojiSection = idx
                        }) {
                            ZStack {
                                Rectangle()
                                    
                                if idx == emojiSection {
                                    Image("ic_emoji_\(emojiCategory[idx])_pressed")
                                } else {
                                    Image("ic_emoji_\(emojiCategory[idx])")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CustomEmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomEmojiPicker(isShowing: .constant(true))
    }
}
