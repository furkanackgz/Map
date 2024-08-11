//
//  LocationsHeaderList.swift
//  Map
//
//  Created by Furkan Açıkgöz on 11.08.2024.
//

import SwiftUI
import MapKit

struct LocationsHeaderList: View {
    
    @EnvironmentObject var locationsService: LocationsService
    
    @Binding var showLocationsHeaderList: Bool
    @Binding var position: MapCameraPosition
    
    var body: some View {
        List {
            ForEach(locationsService.locations) { location in
                listRow(location)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

// MARK: Components
private extension LocationsHeaderList {
    func listRow(_ location: Location) -> some View {
        Button(action: {
            withAnimation(.easeInOut) {
                position = .region(locationsService.getRegion(from: location))
            }
            showLocationsHeaderList.toggle()
        }, label: {
            HStack {
                Image(location.imageNames.first ?? "")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                
                VStack(alignment: .leading) {
                    Text("\(location.name)")
                        .font(.headline)
                    Text("\(location.cityName)")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        })
    }
}

#Preview {
    LocationsHeaderList(showLocationsHeaderList: .constant(false),
                        position: .constant(.automatic))
        .environmentObject(LocationsService())
}
