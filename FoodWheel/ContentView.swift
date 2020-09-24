//
//  ContentView.swift
//  FoodWheel
//
//  Created by Pokming Sheung on 2020-09-15.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var settings = UserSettings()
    var body: some View {
        HStack{
            TabView(selection: .constant(1)) {
                Wheel(settings: settings ,numOfDegree: RotateLine(num: settings.PiecesOfCircle))
                    .frame(width: 350, height: 600, alignment: .top)
                    .tabItem {Image(systemName: "timelapse")
                        Text("\( settings.animationAmount)")}.tag(1)
                
                SettingsPage(settings: settings).tabItem {Image(systemName: "list.bullet")
                    Text("Settings") }.tag(2)
            }
        }
    }
    
    func RotateLine(num: Int) -> [Double] {
        if num == 0 {
            return []
        }
        var temp: [Double] = []
        for i in 0...num-1 {
            temp.append(Double(i)*Double((360/num)))
        }
        return temp
        }
    }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
