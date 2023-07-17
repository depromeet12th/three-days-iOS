//
//  DismissButton.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/07/17.
//

import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) var dismiss
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            if let action = action { action() }
        }) {
            Image("ic_close")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton()
    }
}
