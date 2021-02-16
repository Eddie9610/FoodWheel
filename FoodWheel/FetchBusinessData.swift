//
//  FetchBusinessData.swift
//  FoodWheel
//
//  Created by Pokming Eddie Sheung on 2021-02-11.
//

import Foundation
import SwiftUI

public class DataFetcher: ObservableObject {
    @Published var businessesList : [Venue] = []
    
    init(){
        retrieveVenues(latitude: 49.2827, longitude: 123.1207, category: "restaurants", limit: 3, sortBy: "asc", locale: "eb_US")
    }
    func retrieveVenues(latitude: Double,
                        longitude: Double,
                        category: String,
                        limit: Int,
                        sortBy: String,
                        locale: String) {
        let apikey = "_vNRydF3V5Ca5nNfqokIE4U9nfO4kcCro1OVmFUM9vCpXcWFidCk4QXIt5htUsnCk8BUG24_i2C5x-vbq5I31SLf6rsC-6UEtyEKvqjV8JofSQ_69u8pVuMJv78hYHYx"
        
        let baseURL = "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=\(category)&limit=\(limit)&sort_by=\(sortBy)&locale=\(locale)"
        let url = URL(string: baseURL)
        // requestng
        var request = URLRequest(url: url!)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        //initialize
        URLSession.shared.dataTask(with: request){ (data,response, error) in
            do {
                
                // read data as JSON
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                // main dictionary
                guard let resp = json as? NSDictionary else {return}
                
                // businesses
                guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else {return}
                                
                // accessing each bussiness
                self.businessesList.removeAll()
                for business in businesses{
                    var venue = Venue()
                    venue.name =  business.value(forKey: "name") as? String
                    venue.id = business.value(forKey: "id") as? String
                    venue.rating = business.value(forKey: "rating") as? Float
                    venue.price = business.value(forKey: "price") as? String
                    venue.is_closed = business.value(forKey: "is_closed") as? Bool
                    venue.distance = business.value(forKey: "distance") as? Double
                    let address = business.value(forKeyPath: "location.display_address") as? [String]
                    venue.address = address?.joined(separator: "\n")
                    self.businessesList.append(venue)
                }

            }catch {
                print("Caught error")
            }
        }.resume()
    }
}


