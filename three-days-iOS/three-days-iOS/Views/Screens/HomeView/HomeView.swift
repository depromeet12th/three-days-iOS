//
//  HomeView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/18.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm = HabitViewModel()
    
    var body: some View {
        NavigationView {
            /// 날짜 및 마이페이지 이동
            HStack {
                Text(DateUtil.getCurrentDate(format: "M월 d일 EEEE"))
                    .font(.custom("SUIT-Bold", size: 20))
                
                Spacer()
                
                // TODO: 마이페이지로 이동 (EmptyView -> MyPageView)
                NavigationLink(destination: EmptyView()) {
                    Image(systemName: "person.circle")
                        .foregroundColor(Color("gray500"))
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
            .offset(x: 0, y: -350)
            .padding()
            
            ScrollView {
                if vm.habits.isEmpty {
                    // TODO: 습관 생성 페이지로 이동 (EmptyView -> HabitCreateView)
                    NavigationLink(destination: EmptyView()) {
                        
                    }
                } else {
//                    ForEach(vm.habits) { habit in
//
//                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
