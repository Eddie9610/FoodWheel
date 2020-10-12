//
//  model.swift
//  FoodWheel
//
//  Created by Pokming Eddie Sheung on 2020-09-20.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import Foundation
import SwiftUI

class UserSettings: ObservableObject {
    @Published var PiecesOfCircle = 3
    @Published var Distance: Int = 10
    @Published var animationAmount: Int = 0
    @Published var ArcUIColorArray : [Color] = [Color]()
    //@Published var location?
    

}

