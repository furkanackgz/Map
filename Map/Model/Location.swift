//
//  Location.swift
//  Map
//
//  Created by Furkan Açıkgöz on 4.08.2024.
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    var id: String {
        name + cityName
    }
}
