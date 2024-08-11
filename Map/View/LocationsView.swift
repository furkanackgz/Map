//
//  LocationsView.swift
//  Map
//
//  Created by Furkan Açıkgöz on 4.08.2024.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @State private var showLocationsHeaderList: Bool = false
    @State private var position: MapCameraPosition = .automatic
    
    @EnvironmentObject var locationsService: LocationsService
    
    var body: some View {
        ZStack {
            Map(position: $position)
                .ignoresSafeArea()
            
            VStack {
                header
                Spacer()
            }
        }
        .task {
            position = .region(locationsService.getInitialRegion())
        }
    }
}

// MARK: Components
private extension LocationsView {
    var header: some View {
        VStack {
            headerTitle
            if showLocationsHeaderList {
                LocationsHeaderList(showLocationsHeaderList: $showLocationsHeaderList,
                                    position: $position)
            }
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.3), radius: 20)
        .frame(alignment: .top)
        .padding()
    }
    
    var headerTitle: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                showLocationsHeaderList.toggle()
            }
        }, label: {
            Text("\(locationsService.getCurrentLocationName())")
                .foregroundStyle(Color.primary)
                .font(.title2)
                .fontWeight(.black)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .animation(.none, value: locationsService.currentLocation)
                .overlay(alignment: .leading, content: {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .padding()
                        .foregroundStyle(Color.primary)
                        .rotationEffect(showLocationsHeaderList ? .degrees(180) : .zero)
                })
        })
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsService())
}
