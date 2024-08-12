//
//  LocationsService.swift
//  Map
//
//  Created by Furkan Açıkgöz on 4.08.2024.
//

import Foundation
import MapKit

class LocationsService: ObservableObject {
    
    private let spanDelta = 0.05
    
    func getAllLocations() -> [Location] {
        LocationsDataService.locations
    }
    
    func getInitialRegion(from locations: [Location]) -> MKCoordinateRegion {
        .init(center: locations.first?.coordinates ?? .init(latitude: 41.8902, longitude: 12.4922),
              span: .init(latitudeDelta: spanDelta, longitudeDelta: spanDelta))
    }
    
    func getName(from location: Location?) -> String {
        if let location {
            return "\(location.name), \(location.cityName)"
        } else {
            return ""
        }
    }
    
    func getRegion(from location: Location) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: location.coordinates, span: .init(latitudeDelta: spanDelta,
                                                                            longitudeDelta: spanDelta))
    }
    
    func getNextRegion(from location: Location, and locations: [Location]) -> MKCoordinateRegion {
        guard let currentLocationIndex = locations.firstIndex(of: location) else {
            return getRegion(from: location)
        }
        let nextLocationIndex = currentLocationIndex + 1
        guard locations.indices.contains(nextLocationIndex) else {
            return getRegion(from: locations.first ?? location)
        }
        return getRegion(from: locations[nextLocationIndex])
    }
    
    func getNextLocation(from location: Location, and locations: [Location]) -> Location {
        guard let currentLocationIndex = locations.firstIndex(of: location) else { return location }
        let nextLocationIndex = currentLocationIndex + 1
        guard locations.indices.contains(nextLocationIndex) else { return locations.first ?? location }
        return locations[nextLocationIndex]
    }
}
