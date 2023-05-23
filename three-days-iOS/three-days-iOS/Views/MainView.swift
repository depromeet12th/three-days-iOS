//
//  ContentView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/19.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isFirstLaunching") var isFirstLaunching: Bool = true
    @State var isOnboardingActive: Bool = true
    @State var onboardingIndex: Int = 1
    
    var body: some View {
        if isFirstLaunching && self.onboardingIndex <= 3  {
            OnboardingView(isOnboardingActive: $isOnboardingActive, onboardingIndex: $onboardingIndex)
        }
        else {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
