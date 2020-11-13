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
    var count: Int = 0
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .foregroundColor(.yellow)
                if numOfDegree.isEmpty {
                    
                }
                else{
                    ForEach(numOfDegree , id: \.self) { numOfDegree in
                        ArcWheel(settings: settings, AngleNum: 360.0 / Double(settings.PiecesOfCircle), index: Int( numOfDegree / (360.0 / Double(settings.PiecesOfCircle))))
                            .rotationEffect(.degrees(Double(numOfDegree)))
                        Text("\(numOfDegree / (360.0 / Double(settings.PiecesOfCircle)))")
                            .rotationEffect(.degrees(Double(numOfDegree)))
                        SplitLine()
                            .rotationEffect(.degrees(Double(numOfDegree)))
                    }
                }
            }
            .frame(width: 300, height: 300, alignment: .bottomLeading)
            .rotationEffect(.degrees(Double(settings.animationAmount)))
            Button("rotate"){
                //settings.animationAmount += Int.random(in: 300..<2000)
                withAnimation(.spring(response: 4, dampingFraction: 0.8, blendDuration: 2)){
                    settings.animationAmount += Int.random(in: 300..<2000)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5){
                    settings.animationAmount = settings.animationAmount % 360
                }
            }
            .padding(.top, 30)
        }
    }
        

}

struct Wheel_Previews: PreviewProvider {
    static var previews: some View {
        Wheel(settings: UserSettings(),numOfDegree: [0, 120, 240])
    }
}
