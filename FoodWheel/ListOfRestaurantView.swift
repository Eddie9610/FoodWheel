//
//  ListOfRestaurantView.swift
//  FoodWheel
//
//  Created by Pokming Eddie Sheung on 2020-10-01.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import SwiftUI
import Combine
import CoreLocation

struct ListOfRestaurantView: View {
    @ObservedObject var fetcher = DataFetcher()
    
    var body: some View {
        ForEach(fetcher.businessesList, id: \.id){ venue in
            HStack{
                Text("\(venue.name!)")
                }
                
            }
    }
}

struct ListOfRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfRestaurantView()
    }
}
