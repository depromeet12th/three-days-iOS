//
//  HabitCreateView.swift
//  three-days-iOS
//
//  Created by 최정인 on 2023/07/11.
//

import SwiftUI

struct HabitCreateView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm = HabitViewModel()
    
    @State var isAlarmOn:Bool = false
    @State var showingDatePicker: Bool = false
    @State var notificationTime:Date = Date()
    @State var showingEmojiPicker: Bool = false
    @State var weekdays:[Bool] = Array(repeating: false, count: 7)
    
    @State var selectedHour = 0
    @State var selectedMinute = 0
    
    let weekdaysString:[String] = ["월", "화", "수", "목", "금", "토", "일"]
    let colorArray:[String] = ["GREEN", "BLUE", "PINK"]
    
    var body: some View {
        ScrollView {
            /// 습관명
            habitTitle
            
            /// 습관 요일
            habitDays
            
            selfNagging
        }
        
        ZStack(alignment: .topLeading) {
            
            VStack(alignment: .leading) {
                
                
                
                /// 셀프 잔소리 On / Off
                Group {
                    
                }
                
                /// 색상
                Group {
                    VStack(alignment: .leading) {
                        Text("색상")
                        
                        HStack {
                            ForEach(0..<3, id: \.self) { idx in
                                Button(action: {
                                    vm.habit.color = colorArray[idx]
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(Color("\(colorArray[idx].lowercased())50"))
                                            .frame(width: 40)
                                        
                                        if vm.habit.color == colorArray[idx] {
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
            
            if showingEmojiPicker {
                CustomEmojiPicker(isShowing: $showingEmojiPicker, emojiPath: $vm.habit.emojiPath)
            }
        }
        .padding()
        .font(.custom("SUIT-Medium", size: 14))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Text("습관을 만들어볼까요?").font(.custom("SUIT-Bold", size: 20)),
                            trailing: DismissButton())
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

// MARK: 습관명
extension HabitCreateView {
    var habitTitle: some View {
        VStack(alignment: .leading) {
            Text("습관명")
            
            HStack {
                // 이모지 picker
                Button(action: {
                    showingEmojiPicker.toggle()
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color("gray100"))
                            .frame(width: 45, height: 45)
                            .cornerRadius(10)
                        
                        Text(vm.habit.emojiPath)
                            .font(.system(size: 25))
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                
                // 습관 title
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color("gray100"))
                        .frame(width: 282, height: 45)
                        .cornerRadius(10)
                    
                    HStack {
                        TextField("어떤 습관을 원하시나요?", text: $vm.habit.title)
                            .frame(width: 210, height: 45)
                            .padding(EdgeInsets(top: 13, leading: 16, bottom: 13, trailing: 8))
                            .onChange(of: vm.habit.title) { habitTitle in
                                if vm.habit.title.count >= 15 { // 습관명 길이가 15자 이상이 되면,
                                    vm.habit.title = String(habitTitle.prefix(15))
                                }
                            }
                        
                        Text("\(vm.habit.title.count)/15")
                            .font(.system(size: 12))
                    }
                }
            }
        }
    }
}

// MARK: 습관 요일
extension HabitCreateView {
    var habitDays: some View {
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
}

// MARK: 셀프 잔소리
extension HabitCreateView {
    var selfNagging: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("셀프 잔소리")
                
                Spacer()

                Toggle(isOn: self.$isAlarmOn) {
                    Text("셀프 잔소리")
                }
                .labelsHidden()
            }
            .padding()
            
            if isAlarmOn {
                // DatePicker
                Button(action: {
                    showingDatePicker.toggle()
                }) {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color("gray100"))
                            .frame(width: 335, height: 45)
                            .cornerRadius(10)
                        
                        HStack {
                            HourPicker(selectedHour: $selectedHour)
                            Text(":")
                            MinutePicker(selectedMinute: $selectedMinute)
                        }
                        .padding()
//                                    Text(DateUtil.getCurrentDate(date: notificationTime, format: "HH:mm"))
//                                        .padding()
                    }
                }
                
                
                
//                            if showingDatePicker {
//                                DatePicker("", selection: $notificationTime, displayedComponents: .hourAndMinute)
//                                    .labelsHidden()
//                                    .onAppear {
//                                        UIDatePicker.appearance().minuteInterval = 30
//                                    }
//                            }
                // 한마디
//                        TextField("습관을 잘 실천하기 위해서 본인에게 자극의 한마디를 써볼까요?", text: $vm.habit.notification.contents)
//                            .frame(width: 335, height: 78)
//                            .background(Color("gray100"))
//                            .cornerRadius(10)
                
                // 한마디
                ZStack {
                    Rectangle()
                        .fill(Color("gray100"))
                        .frame(width: 335, height: 78)
                        .cornerRadius(10)
                    
                    TextField("", text: $vm.habit.notification.contents)
                }
            }
            
        }
    }
}
 

struct HabitCreateView_Previews: PreviewProvider {
    static var previews: some View {
        HabitCreateView()
    }
}
