//
//  CustomEmojiPicker.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/07/18.
//

import SwiftUI

struct CustomEmojiPicker: View {
    @Binding var isShowing: Bool
    @Binding var emojiPath: String
    @State var emojiSection: Int = 0 // 0...4까지 이모지 섹션
    @State var nowEmojiSection: [String] = EmojiList().faceEmojiList
    let emojiCategory: [String] = ["face", "food", "animal", "object", "activity"]
    
    
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
                // Emoji Category 선택 버튼
                HStack {
                    ForEach(0..<5, id: \.self) { idx in
                        Button(action: {
                            emojiSection = idx
                            
                            if idx == 0 {
                                nowEmojiSection = EmojiList().faceEmojiList
                            } else if idx == 1 {
                                nowEmojiSection = EmojiList().foodEmojiList
                            } else if idx == 2 {
                                nowEmojiSection = EmojiList().animalEmojiList
                            } else if idx == 3 {
                                nowEmojiSection = EmojiList().objectEmojiList
                            } else {
                                nowEmojiSection = EmojiList().activityEmojiList
                            }
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(idx == emojiSection ? Color("gray100") : Color("gray200"))
                                    .frame(width: 43, height: 34)
                                    .cornerRadius(10)
                                    
                                if idx == emojiSection {
                                    Image("ic_emoji_\(emojiCategory[idx])_pressed")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                } else {
                                    Image("ic_emoji_\(emojiCategory[idx])")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                
                
                // Emoji 선택
                VStack {
                    ForEach(0..<nowEmojiSection.count/6 + min(nowEmojiSection.count%6, 1), id: \.self) { i in
                        Text("\(i)")
                        HStack {
                            ForEach(0..<6, id: \.self) { j in
                                    Button(action: {
                                        emojiPath = nowEmojiSection[i*6 + j]
                                    }) {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 30, height: 30)
                                            
                                            Text(nowEmojiSection[i*6 + j])
                                            
                                            Text("\(i*6 + j)")
                                        }
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
        CustomEmojiPicker(isShowing: .constant(true), emojiPath: .constant("🥹"))
    }
}
