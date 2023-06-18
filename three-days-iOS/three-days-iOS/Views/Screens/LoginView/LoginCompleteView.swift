//
//  LoginCompleteView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/25.
//

import SwiftUI

struct LoginCompleteView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Group {
                    Image("Login-img")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160)
                    
                    Spacer()
                        .frame(height: 24)
                    
                    Text("회원가입 완료!")
                        .font(.custom("SUIT-Bold", size: 20))
                }
                
                NavigationLink(destination: HomeView()) {
                    Text("확인")
                }
                .buttonStyle(BasicButtonStyle())
                .padding(EdgeInsets(top: 271, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .navigationBarHidden(true)
    }
}

struct LoginCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        LoginCompleteView()
    }
}
