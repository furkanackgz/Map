//
//  LocationsView.swift
//  Map
//
//  Created by Furkan Açıkgöz on 4.08.2024.
//

import SwiftUI

struct LocationsView: View {
    
    @EnvironmentObject var locationsService: LocationsService
    
    var body: some View {
        List {
            ForEach(locationsService.locations) {
                Text($0.name)
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsService())
}
