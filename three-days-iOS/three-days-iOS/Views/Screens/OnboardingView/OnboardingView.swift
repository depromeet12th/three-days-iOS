//
//  OnboardingView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/23.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingActive: Bool
    @Binding var onboardingIndex: Int
    
    private let titleArray: [String] = ["3일부터 차근차근 시작해봐요", "짝짝짝! 3일 연속 실천했나요?", "짝꿍과 함께 해볼까요?"]
    private let descriptionArray: [String] = ["작심삼일을 하며 좌절했던 과거는 안녕,\n작심삼일을 모아모아 작심백일까지!", "3일 연속 실천시 박수를 드려요.\n박수를 하나하나 모아볼까요?", "습관에 짝꿍을 연결하고 박수를 모아\n짝꿍을 레벨업 시켜보세요!"]
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: Onboarding Indicator
                HStack {
                    ForEach(0..<onboardingIndex, id:\.self) { _ in
                        Rectangle()
                            .fill(Color("gray500"))
                            .cornerRadius(4)
                            .frame(height: 4)
                        
                        Spacer()
                    }
                    ForEach(onboardingIndex..<3, id:\.self) { _ in
                        Rectangle()
                            .fill(Color("gray200"))
                            .cornerRadius(4)
                            .frame(height: 4)
                        
                        Spacer()
                    }
                }
                .frame(width: 300)
                
                Spacer()
                    .frame(height: 70)
                
                
                // MARK: Page Title
                Text(titleArray[onboardingIndex - 1])
                    .font(.custom("SUIT-Bold", size: 20))
                
                Spacer()
                    .frame(height: 12)
                
                Text(descriptionArray[onboardingIndex - 1])
                    .multilineTextAlignment(.center)
                    .font(.custom("SUIT-Medium", size: 14))
                    .lineSpacing(5)
                    .foregroundColor(Color("gray500"))
                
                // MARK: Page Image
                Image("Onboarding-logo-\(onboardingIndex)")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                    .frame(height: 90)
                
                // MARK: Next Button
                if onboardingIndex < 3 {
                    Button(action: {
                        onboardingIndex += 1
                    }) {
                        Text("다음")
                    }
                    .buttonStyle(BasicButtonStyle())
                } else {
                    NavigationLink(destination: LoginView()) {
                        Text("시작하기")
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        isOnboardingActive.toggle()
                    })
                    .buttonStyle(BasicButtonStyle())
                }
            }
        }
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isOnboardingActive: .constant(true),
                       onboardingIndex: .constant(1))
    }
}
