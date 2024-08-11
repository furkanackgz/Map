//
//  LocationsService.swift
//  Map
//
//  Created by Furkan Açıkgöz on 4.08.2024.
//

import Foundation
import MapKit

class LocationsService: ObservableObject {
    
    private(set) var locations: [Location]
    private(set) var currentLocation: Location?
    
    init() {
        locations = LocationsDataService.locations
        defer {
            currentLocation = locations.first
        }
    }
}

// MARK: Methods
extension LocationsService {
    func getCurrentLocationName() -> String {
        if let currentLocation {
            return "\(currentLocation.name), \(currentLocation.cityName)"
        } else {
            return ""
        }
    }
    
    func getInitialRegion() -> MKCoordinateRegion {
        .init(center: currentLocation?.coordinates ?? .init(latitude: 41.8902, longitude: 12.4922),
              span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }
    
    func getRegion(from location: Location) -> MKCoordinateRegion {
        currentLocation = location
        return MKCoordinateRegion(center: location.coordinates, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }
}
