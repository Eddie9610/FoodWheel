//
//  ListOfRestaurantView.swift
//  FoodWheel
//
//  Created by Pokming Eddie Sheung on 2020-10-01.
//  Copyright © 2020 Pokming Sheung. All rights reserved.
//

import SwiftUI
import MapKit

struct ListOfRestaurantView: View {
    @ObservedObject var locationManager = LocationManager()
    @State private var search: String = ""
    @ObservedObject var landmarkClass: landmarks
    //@State var landmarks: [Landmark]
    
    private func getNearByLandmarks() {

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        if locationManager.location != nil {
            request.region = MKCoordinateRegion(center: locationManager.location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        }
        else {
            print("no location")
        }
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarkClass.landmarkdata = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
                
            }
            
        }
        
    }
    var body: some View {
        VStack{
            TextField("Search", text: $search, onEditingChanged: { _ in })
            {
                // commit
                self.getNearByLandmarks()
            }.textFieldStyle(RoundedBorderTextFieldStyle())

            List{
                ForEach(self.landmarkClass.landmarkdata, id: \.id){ landmarks in
                    Text(landmarks.name)
                        .fontWeight(.black)
                    Text(landmarks.title)
                }
            }.animation(nil)
            .cornerRadius(10)
            .frame(height: 540, alignment: .leading)
        }
    }
}

struct ListOfRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfRestaurantView(landmarkClass: landmarks())
    }
}
