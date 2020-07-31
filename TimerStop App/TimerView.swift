//
//  TimerView.swift
//  TimerStop App
//
//  Created by Pokming Sheung on 2020-07-21.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import SwiftUI
import UserNotifications

struct TimerView: View {
    
    
    @ObservedObject var timerData = TimerData()
        
    @State var SeletedTimerNumMin = 0
    
    @State var SeletedTimerNumSec = 0
    
    let SeletedMin = Array(0...60)
    
    let SeletedSec = Array(0...59)
    
    let last = Config.colors.count - 1

    var body: some View {
        NavigationView{
            VStack {
                Text(" \(self.timerData.timerConvert(times: timerData.minutesLeft) ) : \(self.timerData.timerConvert(times: timerData.secondsLeft) ) ")
                    .font(.system(size: 80))
                    .foregroundColor(.black)
                    .padding(.top, 180)
                    .frame(minWidth: 150, maxWidth: .infinity)
                Image(systemName: timerData.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Config.colors[pageIndex == 0 ? last : pageIndex / 2 ])
                    .frame(width:160,height: 160)
                    .onTapGesture(perform: {
                        if self.timerData.timerMode == .initial{
                            self.timerData.seTimerMin(min: self.SeletedMin[self.SeletedTimerNumMin])
                            self.timerData.setTimerSec(sec: self.SeletedSec[self.SeletedTimerNumSec])
                        }
                        self.timerData.timerMode == .running ? self.timerData.pause() : self.timerData.start()
                    })
                    .shadow(radius: 2)
                if timerData.timerMode == .paused{
                    Image(systemName: "gobackward")
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50, height: 50)
                        .padding(.top, 40)
                    .onTapGesture(perform: {
                        self.timerData.reset()
                    })
                }
                
               if timerData.timerMode == .initial {
                    HStack {
                        VStack {
                            Picker(selection: $SeletedTimerNumMin, label: Text("Min")) {
                                ForEach(0 ..< SeletedMin.count){
                                    Text("\(self.SeletedMin[$0]) min")
                                }
                            }
                            .labelsHidden()
                            .frame(minWidth: 150, maxWidth: .infinity)
                            .clipped()
                        }
                        VStack {
                            Picker(selection: $SeletedTimerNumSec, label: Text("Sec")) {
                                ForEach(0 ..< SeletedSec.count){
                                    Text("\(self.SeletedSec[$0]) s")
                                }
                            }
                            .labelsHidden()
                            .frame(minWidth: 150, maxWidth: .infinity)
                            .clipped()
                        }
                        
                    }
                }
                Spacer()
            }.background(Config.colors[pageIndex]).edgesIgnoringSafeArea(.all)
            
            //.frame(minWidth: 150, maxWidth: .infinity)
        }.onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { (_, _) in }
        })
    }
    
}



struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
