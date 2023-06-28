//
//  LoginView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/05/24.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

struct LoginView: View {
    @ObservedObject var vm = ViewModel()
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
                            print("OAUTHTOKEN : \(String(describing: oauthToken))")
                            print("ERROR : \(String(describing: error))")
                            vm.login(certificationSubject: "KAKAO", socialToken: oauthToken!.accessToken)
                        }
                    } else {
                        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in // 카카오 계정으로 로그인
                            print("OAUTHTOKEN : \(String(describing: oauthToken))")
                            print("ERROR : \(String(describing: error))")
                            vm.login(certificationSubject: "KAKAO", socialToken: oauthToken!.accessToken)
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
                        vm.setTokens(accessToken: member.token.accessToken, refreshToken: member.token.refreshToken)
                        isLoginnedIn.toggle()
                    case .failure(let error): // 로그인 실패
                        print("Failed to Kakao Login: \(error)")
                    }
                }
                
                
                // MARK: the new one !!
                SignInWithAppleButton(onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                }, onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        print("Authorization Successful! 🎉")
                        switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            let userIdentifier = appleIDCredential.user
                            let fullName = appleIDCredential.fullName
                            let email = appleIDCredential.email
                            let identifyToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                            let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                            vm.login(certificationSubject: "APPLE", socialToken: identifyToken!)
                            
                        default:
                            break
                        }
                    case .failure(let error):
                        print("Authorization Failed: \(error.localizedDescription)")
                    }
                })
                .frame(width: 320, height: 56)
                .font(.custom("SUIT-SemiBold", size: 16))
                .cornerRadius(15)
                
                
                
//                Button(action: {
//                    // MARK: Test 임시
////                    let appleIDProvider = ASAuthorizationAppleIDProvider()
////                    let request = appleIDProvider.createRequest()
////                    request.requestedScopes = [.fullName, .email]
////
////                    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
////
//
//
//                    // MARK: 기존 코드 ... 작동 안됨
//                    SignInWithAppleButton(onRequest: { request in // 애플 로그인
//                        request.requestedScopes = [.fullName, .email]
//                    }, onCompletion: { result in
//                        switch result { // 성공
//                        case .success(let authResults):
//                            print("=== Apple Login Success ===")
//                            switch authResults.credential {
//                            case let appleIDCredential as ASAuthorizationAppleIDCredential: // 계정 정보 가져오기
//                                let userIndentifier = appleIDCredential.user
//                                let fullName = appleIDCredential.fullName
//                                let email = appleIDCredential.email
//                                let identifyToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
//                                let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
//                                vm.login(certificationSubject: "APPLE", socialToken: identifyToken!)
//
//                            default:
//                                break
//                            }
//
//                        case .failure(let error): // 실패
//                            print(error.localizedDescription)
//                        }
//                    })
//                }) {
//                    HStack {
//                        Image("Apple-logo")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 24)
//
//                        Text("Apple로 계속하기")
//                    }
//                }
//                .buttonStyle(BasicButtonStyle(customFont: "SUIT-Bold"))
//                .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
//
                NavigationLink(destination: LoginCompleteView(), isActive: $isLoginnedIn) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
