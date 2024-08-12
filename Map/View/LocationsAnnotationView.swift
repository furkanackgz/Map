//
//  LocationsAnnotationView.swift
//  Map
//
//  Created by Furkan Açıkgöz on 12.08.2024.
//

import SwiftUI
import MapKit.MKMapCamera

struct LocationsAnnotationView: View {
    
    @EnvironmentObject var locationsService: LocationsService
    @Binding var position: MapCameraPosition
    @Binding var currentLocation: Location
    
    var location: Location
    
    var body: some View {
        VStack {
            Image("\(location.imageNames.first ?? "")")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(3)
                .background(
                    Circle()
                        .fill(Color.red)
                )
            
            Image(systemName: "triangle.fill")
                .resizable()
                .rotationEffect(.degrees(180))
                .offset(y: -9)
                .foregroundStyle(.red)
                .frame(width: 12, height: 12)
        }
        .offset(y: -20)
        .shadow(radius: 10)
        .onTapGesture {
            withAnimation(.easeInOut) {
                currentLocation = location
                position = .region(locationsService.getRegion(from: currentLocation))
            }
        }
    }
}

#Preview {
    LocationsAnnotationView(position: .constant(.automatic),
                            currentLocation: .constant(LocationsDataService.locations.first!),
                            location: LocationsDataService.locations.first!)
}
