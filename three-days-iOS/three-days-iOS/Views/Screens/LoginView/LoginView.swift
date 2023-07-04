//
//  LoginView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/24.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import AuthenticationServices

struct LoginView: View {
    @ObservedObject var vm = MemberViewModel()
    
    @State private var presentationAnchor: ASPresentationAnchor?
    @State private var isLoginnedIn: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                // MARK: Logo
                Text("작심삼일이라면,\n짝심삼일과 함께")
                    .multilineTextAlignment(.center)
                    .font(.custom("SUIT-SemiBold", size: 26))
                
                Image("Main-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                    .padding(EdgeInsets(top: 24, leading: 0, bottom: 129, trailing: 0))
                
                
                // MARK: Social Login Button
                Button(action: {
                    if (UserApi.isKakaoTalkLoginAvailable()) { // 카카오톡이 설치되어 있는지 확인
                        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in // 카카오톡으로 로그인
                            if let error = error {
                                if let sdkError = error as? KakaoSDKCommon.SdkError,
                                   case .ClientFailed(let reason, _) = sdkError,
                                   reason == .Cancelled {
                                    // 사용자가 로그인을 취소한 경우 처리할 로직
                                    print("사용자가 카카오 로그인을 취소했습니다.")
                                } else {
                                    // 다른 로그인 오류 처리
                                    print("카카오 로그인 중 오류가 발생했습니다: \(error.localizedDescription)")
                                }
                            }
                            else {
                                print("OAUTHTOKEN : \(String(describing: oauthToken))")
                                self.vm.login(certificationSubject: "KAKAO", socialToken: oauthToken!.accessToken)
                            }
                        }
                    } else {
                        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in // 카카오 계정으로 로그인
                            if let error = error {
                                if let sdkError = error as? KakaoSDKCommon.SdkError,
                                   case .ClientFailed(let reason, _) = sdkError,
                                   reason == .Cancelled {
                                    // 사용자가 로그인을 취소한 경우 처리할 로직
                                    print("사용자가 카카오 로그인을 취소했습니다.")
                                } else {
                                    // 다른 로그인 오류 처리
                                    print("카카오 로그인 중 오류가 발생했습니다: \(error.localizedDescription)")
                                }
                            }
                            else {
                                print("OAUTHTOKEN : \(String(describing: oauthToken))")
                                self.vm.login(certificationSubject: "KAKAO", socialToken: oauthToken!.accessToken)
                            }
                        }
                    }
                }) {
                    HStack {
                        Image("Kakao-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                        Text("카카오로 계속하기")
                    }
                }
                .buttonStyle(BasicButtonStyle(backgroundColor: Color("kakaoYellow"), fontColor: .black, customFont: "SUIT-Bold"))
                .onReceive(vm.loginResult.publisher) { result in
                    switch result {
                    case .success(let member): // 로그인 성공
                        self.vm.setTokens(accessToken: member.token.accessToken, refreshToken: member.token.refreshToken)
                        self.isLoginnedIn.toggle()
                    case .failure(let error): // 로그인 실패
                        print("Failed to Kakao Login: \(error)")
                    }
                }
                
                
                // MARK: Apple Login
                Button(action: {
                    self.AppleSignIn()
                }) {
                    HStack {
                        Image("Apple-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)

                        Text("Apple로 계속하기")
                    }
                }
                .buttonStyle(BasicButtonStyle(customFont: "SUIT-Bold"))
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                
                NavigationLink(destination: LoginCompleteView(), isActive: $isLoginnedIn) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }
    
    func AppleSignIn() {
        let appleSignInRequest = ASAuthorizationAppleIDProvider().createRequest()
        appleSignInRequest.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [appleSignInRequest])
        authorizationController.delegate = AppDelegate.shared
        authorizationController.presentationContextProvider = AppDelegate.shared
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let anchor = presentationAnchor else {
            return ASPresentationAnchor()
        }
        return anchor
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
