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
            VStack {
                /// 날짜 및 마이페이지 이동
                HStack {
                    Text(DateUtil.getCurrentDate(date: Date(), format: "M월 d일 EEEE"))
                        .font(.custom("SUIT-Bold", size: 20))
                    
                    Spacer()
                    
                    // TODO: 마이페이지로 이동 (EmptyView -> MyPageView)
                    NavigationLink(destination: EmptyView()) {
                        Image("ic_hamburger")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding()
                
                /// 습관 만들기 및 습관 목록
                ScrollView {
                    if vm.habits.isEmpty {
                        NavigationLink(destination: HabitCreateView()) {
                            ZStack {
                                Rectangle()
                                    .fill(Color("gray100"))
                                    .frame(width: 335, height: 140)
                                    .cornerRadius(20)
                                
                                HStack {
                                    Image("ic_add_default")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 29)
                                    
                                    
                                    Text("습관 만들기")
                                        .font(.custom("SUIT-SemiBold", size: 14))
                                        .foregroundColor(Color("gray600"))
                                }
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
        }
        .navigationBarHidden(true)
        .background(Color("bg"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
