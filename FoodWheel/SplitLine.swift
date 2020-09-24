//
//  SplitLine.swift
//  FoodWheel
//
//  Created by Pokming Eddie Sheung on 2020-09-20.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import SwiftUI

struct SplitLine: View {
    var body: some View {
        VStack {
            ZStack{
                Path{ path in
                    path.move(to: CGPoint(x: 149.5, y: 0))
                    path.addLine(to: CGPoint(x: 149.5, y: 150))
                    path.addLine(to: CGPoint(x: 150.5, y: 150))
                    path.addLine(to: CGPoint(x: 150.5, y: 0))
                }
                .blur(radius: 3.0)
            }.frame(width: 300, height: 300, alignment: .center)
        }
        
    }
}

struct SplitLine_Previews: PreviewProvider {
    static var previews: some View {
        SplitLine()
    }
}
