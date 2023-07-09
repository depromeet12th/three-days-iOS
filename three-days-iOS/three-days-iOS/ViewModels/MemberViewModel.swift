//
//  MemberViewModel.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/06/10.
//

import Foundation

class MemberViewModel: ObservableObject {
    @Published var member: Result<Member, Error>? = nil
    @Published var isLoggined: Bool = false
    var memberService = MemberService()
    
    /// 카카오 로그인
    func kakaoLogin(certificationSubject: String, socialToken: String) {
        memberService.kakaoLogin(certificationSubject: certificationSubject, socialToken: socialToken) { result in
            switch result {
            case .success(_):
                self.isLoggined = true
            case .failure(_):
                self.isLoggined = false
            }
            self.member = result
        }
    }
    
    /// 애플 로그인
    func appleLogin(certificationSubject: String, socialToken: String, code: String, firstName: String, lastName: String, email: String, nonce: String) {
        memberService.appleLogin(certificationSubject: certificationSubject, socialToken: socialToken, code: code, firstName: firstName, lastName: lastName, email: email, nonce: nonce) { result in
            switch result {
            case .success(_):
                self.isLoggined = true
            case .failure(_):
                self.isLoggined = false
            }
            self.member = result
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
