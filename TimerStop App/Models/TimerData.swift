
//
//  TimerData.swift
//  TimerStop App
//
//  Created by Pokming Sheung on 2020-07-21.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import Foundation
import SwiftUI
import UserNotifications

class TimerData : ObservableObject {
    @Published var timerMode: TimerMode = .initial
    
    @Published var minutesLeft = UserDefaults.standard.integer(forKey: "MinTimer")
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "SecTimer")
    
    var timer = Timer()
    
    func start(){
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            if self.secondsLeft == 0 && self.minutesLeft == 0 {
                self.Notify()
                self.reset()
            }
            else if self.secondsLeft == 0 && self.minutesLeft != 0{
                self.minutesLeft -= 1
                self.secondsLeft = 59
            }
            else {
                self.secondsLeft -= 1
            }
        })
    }
    
    func reset(){
        self.timerMode = .initial
        self.secondsLeft = UserDefaults.standard.integer(forKey: "SecTimer")
        self.minutesLeft = UserDefaults.standard.integer(forKey: "MinTimer")
        timer.invalidate()
    }
    func pause(){
        self.timerMode = .paused
        timer.invalidate()
    }
    func seTimerMin(min : Int){
        let defaults = UserDefaults.standard
        defaults.set(min, forKey: "MinTimer")
        minutesLeft = min
    }
    func setTimerSec(sec : Int){
        let defaults = UserDefaults.standard
        defaults.set(sec, forKey: "SecTimer")
        secondsLeft = sec
    }
    
    func timerConvert(times : Int) ->String {
        let time = "\(times)"
        let timeStr : String = time.count > 1 ? time : "0" + time
        return timeStr
    }
    
    func Notify(){
        
        let content = UNMutableNotificationContent()
        content.title = "Notification"
        content.body = "It's Time !!! Timer is completed !!!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
    }
}
