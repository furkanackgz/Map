//
//  LocationsInfoView.swift
//  Map
//
//  Created by Furkan Açıkgöz on 11.08.2024.
//

import SwiftUI
import MapKit

struct LocationsInfoView: View {
    
    @EnvironmentObject var locationsService: LocationsService
    @Binding var locations: [Location]
    @Binding var position: MapCameraPosition
    @Binding var currentLocation: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.ultraThinMaterial)
                .offset(y: 70)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
        .shadow(color: .black.opacity(0.3), radius: 20)
        .transition(
            .asymmetric(
                insertion: .move(edge: .trailing).animation(.easeInOut),
                removal: .move(edge: .leading).animation(.easeInOut)
            )
        )
    }
}

// MARK: Components
private extension LocationsInfoView {
    var imageSection: some View {
        Image(currentLocation.imageNames.first ?? "")
            .resizable()
            .frame(width: 125, height: 125)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .padding(6)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 9))
    }
    
    var titleSection: some View {
        VStack(alignment: .leading) {
            Text(currentLocation.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(currentLocation.cityName)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var learnMoreButton: some View {
        Button(action: {
            
        }, label: {
            Text("Learn More")
                .frame(width: 125, height: 30)
        })
        .buttonStyle(BorderedProminentButtonStyle())
        
    }
    
    var nextButton: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                position = .region(locationsService.getNextRegion(from: currentLocation,
                                                                  and: locations))
                currentLocation = locationsService.getNextLocation(from: currentLocation,
                                                                   and: locations)
            }
        }, label: {
            Text("Next")
                .frame(width: 125, height: 30)
        })
        .buttonStyle(BorderedButtonStyle())
    }
}

#Preview {
    LocationsInfoView(locations: .constant([Location]()),
                      position: .constant(.automatic),
                      currentLocation: .constant(LocationsDataService.locations.first!))
}
