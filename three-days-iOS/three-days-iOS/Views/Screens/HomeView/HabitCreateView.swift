//
//  HabitCreateView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/07/11.
//

import SwiftUI

struct HabitCreateView: View {
    @ObservedObject var vm = HabitViewModel()
    @State var isAlarmOn:Bool = false
    @State var weekdays:[Bool] = Array(repeating: false, count: 7)
    let weekdaysString:[String] = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        VStack(alignment: .leading) {
            /// 습관명
            Group {
                VStack(alignment: .leading) {
                    Text("습관명")
                    
                    HStack {
                        // 이모지 picker
                        Button(action: {
                            
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color("gray100"))
                                    .frame(width: 45, height: 45)
                                    .cornerRadius(10)
                                
                                Text(vm.habit.imojiPath)
                                    .font(.system(size: 25))
                            }
                        }
                        
                        // 습관 title
                        ZStack {
                            TextField("어떤 습관을 원하시나요?", text: $vm.habit.title)
                                .frame(width: 282, height: 45)
                                .background(Color("gray100"))
                                .cornerRadius(10)
                        }
                    }
                }
            }
            
            /// 습관 요일
            Group {
                VStack(alignment: .leading) {
                    HStack {
                        Text("실천 요일")
                        Text("(최소 3일 이상)")
                            .font(.system(size: 11))
                    }
                    
                    HStack {
                        ForEach(0...6, id: \.self) { idx in
                            Button(action: {
                                weekdays[idx].toggle()
                            }) {
                                ZStack {
                                    Rectangle()
                                        .fill(weekdays[idx] ? Color("gray400") : Color("gray300"))
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(10)
                                    
                                    Text("\(weekdaysString[idx])")
                                        .foregroundColor(weekdays[idx] ? Color(.white) : Color("gray400"))
                                }
                            }
                        }
                    }
                }
            }
            
            /// 셀프 잔소리 On / Off
            Group {
                VStack(alignment: .leading) {
                    Toggle(isOn: self.$isAlarmOn) {
                        Text("셀프 잔소리")
                    }
                    
                    if isAlarmOn {
                        // ??
                        
                        // 한마디
                        TextField("습관을 잘 실천하기 위해서 본인에게 자극의 한마디를 써볼까요?", text: $vm.habit.notification.contents)
                            .frame(width: 335, height: 78)
                            .background(Color("gray100"))
                            .cornerRadius(10)
                    }
                    
                }
            }
            
            /// 색상
            Group {
                VStack(alignment: .leading) {
                    Text("색상")
                    
                    HStack {
                        // 초 파 분
                        Button(action: {
                            vm.habit.color = "GREEN"
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("green50"))
                                    .frame(width: 40)
                                
                                if vm.habit.color == "GREEN" {
                                    Image("ic_check_mono")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24)
                                }
                            }
                        }
                        
                        Button(action: {
                            vm.habit.color = "BLUE"
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("blue50"))
                                    .frame(width: 40)
                                
                                if vm.habit.color == "BLUE" {
                                    Image("ic_check_mono")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24)
                                }
                            }
                        }
                        
                        Button(action: {
                            vm.habit.color = "PINK"
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("pink50"))
                                    .frame(width: 40)
                                
                                if vm.habit.color == "PINK" {
                                    Image("ic_check_mono")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24)
                                }
                            }
                        }
                    }
                }
            }
            
            /// 습관 만들기 Button
            Button(action: {
                if isActiveButton() { // 습관 칸을 모두 채웠을 시에만 활성화
//                    vm.createHabit(newHabit: Habit)
                }
            }) {
                ZStack {
                    Rectangle()
                        .fill(isActiveButton() ? Color("blue50") : Color("gray300"))
                        .frame(width: 335, height: 56)
                        .cornerRadius(15)
                    
                    Text("습관 만들기")
                        .foregroundColor(isActiveButton() ? Color(.white) : Color("gray400"))
                }
            }
        }
        .font(.custom("SUIT-Medium", size: 14))
    }
    
    // 만들기 버튼을 활성화 시킬 수 있는 조건들을 검사하는 함수
    func isActiveButton() -> Bool {
        if vm.habit.title != "" && self.weekdays.filter({ $0 == true }).count >= 3 { // 습관명 작성 및 습관 요일 3개 이상일 시,
            if isAlarmOn { // 셀프 잔소리 ON
                if vm.habit.notification.contents != "" {
                    return true
                } else {
                    return false
                }
            } else { // 셀프 잔소리 OFF
                return true
            }
        }
        return false
    }
}

struct HabitCreateView_Previews: PreviewProvider {
    static var previews: some View {
        HabitCreateView()
    }
}
