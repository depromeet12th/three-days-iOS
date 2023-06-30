//
//  HomeView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/18.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            
            HStack {
                Text(DateUtil.getCurrentDate(format: "M월 d일 EEEE"))
                
                // 알림페이지 ?? 공지사항 페이지 ?? 마이페이지 ??
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
