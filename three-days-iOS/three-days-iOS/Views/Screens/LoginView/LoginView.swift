//
//  LoginView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // MARK: Logo
            Text("작심삼일이라면,\n짝심삼일과 함께")
                .multilineTextAlignment(.center)
                .font(.custom("SUIT-SemiBold", size: 26))
            
            Image("Main-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 160)
                .padding(EdgeInsets(top: 24, leading: 0, bottom: 129, trailing: 0))
            
            
            // MARK: Social Login Button
            Button(action: {
                
            }) {
                HStack {
                    Image("Kakao-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                    Text("카카오로 계속하기")
                }
            }
            .buttonStyle(BasicButtonStyle(backgroundColor: Color("kakaoYellow"), fontColor: .black, customFont: "SUIT-Bold"))
            
            
            Button(action: {
                
            }) {
                HStack {
                    Image("Apple-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                    
                    Text("Apple로 계속하기")
                }
            }
            .buttonStyle(BasicButtonStyle(customFont: "SUIT-Bold"))
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
