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
            
            /// 습관 만들기 및 습관 목록
            ScrollView {
                Text("왜 안나와 ??")
                
                if vm.habits.isEmpty {
                    NavigationLink(destination: HabitCreateView()) {
                        ZStack {
                            HStack {
                                ZStack {
                                    Rectangle()
                                        .fill(Color("gray200"))
                                        .frame(width: 55, height: 55)
                                        .cornerRadius(15)
                                    
                                    Image(systemName: "plus")
                                        .foregroundColor(Color("gray500"))
                                }
                                
                                Text("습관 만들기")
                            }
                            
                            Rectangle()
                                .fill(Color("gray500"))
                                .frame(width: 335, height: 140)
                                .cornerRadius(20)
                        }
                    }
                } else {
                    Text("Habits will appear !!")
                    // TODO: viewModel에 있는 habits array를 뿌려서 보여주기
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
