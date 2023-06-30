//
//  MemberViewModel.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/10.
//

import Foundation

class MemberViewModel: ObservableObject {
    @Published var loginResult: Result<Member, Error>? = nil
    var memberService = MemberService()
    
    /// 로그인
    func login(certificationSubject: String, socialToken: String) {
        memberService.login(certificationSubject: certificationSubject, socialToken: socialToken) { result in
            self.loginResult = result
        }
    }
    
    /// Token 저장
    func setTokens(accessToken: String, refreshToken: String) {
        memberService.setTokenToKeychain(accessToken: accessToken, refreshToken: refreshToken)
    }
    
    /// Token 가져오기
    func getTokens() {
        
    }
    
}
