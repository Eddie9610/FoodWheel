//
//  SwiftUIView.swift
//  TimerStop App
//
//  Created by Pokming Sheung on 2020-07-24.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        
        Button(action: {
            print("Test!!!")
        }) {
            HStack{
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                Text("Play")
                    .foregroundColor(.white)
            }
            .frame(width:(UIScreen.main.bounds.width / 2 - 55 ))
            .background(Color.red)
        .clipShape(Capsule())
        .shadow(radius: 6)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
