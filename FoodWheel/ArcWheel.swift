//
//  ArcWheel.swift
//  FoodWheel
//
//  Created by Pokming Eddie Sheung on 2020-09-20.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import SwiftUI



struct ArcWheel: View {
    var AngleNum: Double
    var height: Double = 150
    
    var body: some View {
        ZStack{
            Path { path in
                path.move(to: CGPoint(x: 150, y: 150))
                path.addArc(center: CGPoint(x: 150.0, y: 150.0), radius: 150, startAngle: .init(degrees: -90), endAngle: .init(degrees: AngleNum - 90), clockwise: false)
            }
            .foregroundColor(Color(UIColor.random))
            .blur(radius: 0.3)
        }
        .frame(width: 300, height: 300, alignment: .center)

    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
}

struct ArcWheel_Previews: PreviewProvider {
    static var previews: some View {
        ArcWheel(AngleNum: 45)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
