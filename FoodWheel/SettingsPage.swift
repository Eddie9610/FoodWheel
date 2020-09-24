//
//  SettingsPage.swift
//  FoodWheel
//
//  Created by Pokming Eddie Sheung on 2020-09-20.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import SwiftUI
import Combine

struct SettingsPage: View {
    
    @ObservedObject var settings: UserSettings
    @ObservedObject var value = NumbersOnly()
    @State var distance: Float = 10
    var body: some View {
        VStack{
            GeometryReader{ f in
                Text("Settings")
                    .fontWeight(.bold)
                    .padding(.leading, f.size.width / 25)
                    .font(.system(size: 55))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .frame(width: f.size.width,height: 70, alignment: .topLeading)
                VStack {
                    HStack {
                            TextField("Number of restaurants: ", text: $value.value, onCommit: {
                                UIApplication.shared.endEditing()
                            })
                                .keyboardType(.asciiCapableNumberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button("Apply"){
                                if value.value.isEmpty {
                                    settings.PiecesOfCircle = 3
                                }
                                else {
                                    settings.PiecesOfCircle = Int(value.value)!
                                }
                                UIApplication.shared.endEditing()
                                value.value = ""
                            }
                            .frame(width: 80, height: 30, alignment: .center)
                        }
                    .padding(.top, f.size.height / 8)
                    
                    HStack {
                        Text("5")
                        Slider(value: Binding(
                                get: {
                                    distance
                                },
                                set: { (newValue) in
                                    distance = newValue
                                    changeDistance(settings: settings, value: distance)
                                }
                        ), in: 5...50, step: 1)
                        Text("50")
                    }
                    Text("\(Int(distance))")
                    List{
                        
                    }
                }
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
