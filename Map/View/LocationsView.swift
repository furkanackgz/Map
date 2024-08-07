//
//  LocationsView.swift
//  Map
//
//  Created by Furkan Açıkgöz on 4.08.2024.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject var locationsService: LocationsService
    
    var body: some View {
        ZStack {
            Map(initialPosition: .region(locationsService.currentRegion))
                .ignoresSafeArea()
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsService())
}
