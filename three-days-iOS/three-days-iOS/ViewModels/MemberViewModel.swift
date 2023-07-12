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
            case .success(let member):
                UserDefaults.standard.set(true, forKey: UserDefaults.isLogginedKey)
                self.memberService.setTokenToKeychain(accessToken: member.token.accessToken, refreshToken: member.token.accessToken)
            case .failure(_):
                UserDefaults.standard.set(false, forKey: UserDefaults.isLogginedKey)
            }
            UserDefaults.standard.synchronize()
            
            self.member = result
            self.isLoggined = UserDefaults.standard.bool(forKey: UserDefaults.isLogginedKey)
        }
    }
    
    /// 애플 로그인
    func appleLogin(certificationSubject: String, socialToken: String, code: String, firstName: String, lastName: String, email: String, nonce: String) {
        print("Apple Login ... - in MemberViewModel")
        memberService.appleLogin(certificationSubject: certificationSubject, socialToken: socialToken, code: code, firstName: firstName, lastName: lastName, email: email, nonce: nonce) { result in
            switch result {
            case .success(let member):
                print("MemberViewModel Apple Login Success")
                UserDefaults.standard.set(true, forKey: UserDefaults.isLogginedKey)
                self.memberService.setTokenToKeychain(accessToken: member.token.accessToken, refreshToken: member.token.refreshToken)
            case .failure(_):
                print("MemberViewModel Apple Login Failure")
                UserDefaults.standard.set(false, forKey: UserDefaults.isLogginedKey)
            }
            UserDefaults.standard.synchronize()
            
            self.member = result
            self.isLoggined = UserDefaults.standard.bool(forKey: UserDefaults.isLogginedKey)
        }
    }
}
