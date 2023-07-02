//
//  CustomAlertView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/30.
//

import SwiftUI

struct CustomAlertView: View {
    let title: String
    let message: String?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(title: "삭제하시궛어요?", message: nil)
    }
}
