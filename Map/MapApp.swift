//
//  MapApp.swift
//  Map
//
//  Created by Furkan Açıkgöz on 4.08.2024.
//

import SwiftUI

@main
struct MapApp: App {
    
    @StateObject private var locationsService = LocationsService()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(locationsService)
        }
    }
}
