//
//  Wheel.swift
//  FoodWheel
//
//  Created by Pokming Eddie Sheung on 2020-09-16.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//


import SwiftUI

struct Wheel: View {
    @ObservedObject var settings : UserSettings
    let numOfDegree : [Double]
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .foregroundColor(.yellow)
                if numOfDegree.isEmpty {
                    
                }
                else{
                    ForEach(numOfDegree , id: \.self) { numOfDegree in
                        ArcWheel(AngleNum: 360.0 / Double(settings.PiecesOfCircle))
                            .rotationEffect(.degrees(Double(numOfDegree)))
                        SplitLine()
                            .rotationEffect(.degrees(Double(numOfDegree)))
                    }
                }
            }
            .frame(width: 300, height: 300, alignment: .bottomLeading)
            .rotationEffect(.degrees(settings.animationAmount))
            .animation(.spring(response: 4, dampingFraction: 0.8, blendDuration: 2))

            Button("rotate"){
                settings.animationAmount += Double.random(in: 300..<2000)
            }
            .padding(.top, 30)
        }
    }
    
}

struct Wheel_Previews: PreviewProvider {
    static var previews: some View {
        Wheel(settings: UserSettings(),numOfDegree: [0])
    }
}
