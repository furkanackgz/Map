//
//  LocationsService.swift
//  Map
//
//  Created by Furkan Açıkgöz on 4.08.2024.
//

import Foundation

class LocationsService: ObservableObject {
    
    @Published var locations: [Location]
    
    init() {
        locations = LocationsDataService.locations
    }
    
}
