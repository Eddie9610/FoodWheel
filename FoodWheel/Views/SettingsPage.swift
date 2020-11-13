//
//  SettingsPage.swift
//  FoodWheel
//
//  Created by Pokming Eddie Sheung on 2020-09-20.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct SettingsPage: View {
    @ObservedObject var settings: UserSettings
    @ObservedObject var value = NumbersOnly()
    @State var distance: Float = 10
    var body: some View {
            GeometryReader{ f in
                NavigationView {
                    List{
                        HStack {
                                TextField("Number of choices: Max 15", text: $value.value, onCommit: {
                                    UIApplication.shared.endEditing()
                                })
                                    .keyboardType(.asciiCapableNumberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Button("Apply"){
                                    if value.value.isEmpty {
                                        settings.PiecesOfCircle = 3
                                    }
                                    else if Int(value.value)! < 2 {
                                        settings.PiecesOfCircle = 3
                                    }
                                    else if Int(value.value)! > 15{
                                        settings.PiecesOfCircle = 15
                                    }
                                    else {
                                        settings.PiecesOfCircle = Int(value.value)!
                                    }
                                    UIApplication.shared.endEditing()
                                    value.value = ""
                                    settings.clearArray()
                                    if(settings.ArcUIColorArray.isEmpty){
                                        settings.ColorArrayRandom(num: settings.PiecesOfCircle)
                                    }
                                    
                                }
                                .frame(width: 80, height: 30, alignment: .center)
                            Text("\(settings.ArcUIColorArray.count)")
                            }
                        .padding(.vertical, 10)
                        
                        HStack {
                            Text("5")
                            Slider(value: Binding(
                                    get: {
                                        distance
                                    },
                                    set: { (newValue) in
                                        distance = newValue
                                    }
                            ), in: 5...50, step: 1)
                            Text("50")
                            Text("(\(Int(distance)) KM)")
                        }
                    }.navigationBarTitle(Text("Settings"), displayMode: .large)
                    .navigationBarItems(trailing:
                        HStack{
                            Button(action: {
                                // Save action
                                changeDistance(settings: settings, value: distance)
                                settings.clearArray()
                                settings.ColorArrayRandom(num: settings.PiecesOfCircle)
                            }){
                                Text("Save")
                                    .font(.subheadline)
                                Image(systemName: "play.fill")
                                    .foregroundColor(.pink)
                                    .font(.largeTitle)
                                
                            }
                    })
                }
            }
    }
    func changeDistance(settings: UserSettings, value: Float) {
        settings.Distance = Int(value)
    }
    

}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage(settings: UserSettings())
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
