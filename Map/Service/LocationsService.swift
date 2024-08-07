//
//  LocationsService.swift
//  Map
//
//  Created by Furkan Açıkgöz on 4.08.2024.
//

import Foundation
import MapKit

class LocationsService: ObservableObject {
    
    private var locations: [Location]
    private var currentLocation: Location? {
        didSet {
            if let currentLocation {
                setCurrentRegion(to: currentLocation)
            }
        }
    }
    @Published var currentRegion: MKCoordinateRegion = .init()
    
    init() {
        locations = LocationsDataService.locations
        defer {
            currentLocation = locations.first
        }
    }
}

private extension LocationsService {
    func setCurrentRegion(to location: Location) {
        currentRegion = .init(center: location.coordinates,
                              span: .init(latitudeDelta: 0.1,
                                          longitudeDelta: 0.1))
    }
}
