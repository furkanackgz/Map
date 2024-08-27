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
    @State private var locations = [Location]()
    @State private var position: MapCameraPosition = .automatic
    @State private var currentLocation: Location?
    @State private var presentSheet: Bool = false
    
    @EnvironmentObject var locationsService: LocationsService
    
    var body: some View {
        ZStack {
            mapView
            
            VStack {
                header
                Spacer()
                locationInfoView
            }
        }
        .sheet(isPresented: $presentSheet, content: {
            if let currentLocation {
                LocationsDetailView(presentSheet: $presentSheet,
                                    location: currentLocation)
            }
        })
        .task {
            locations = locationsService.getAllLocations()
            position = .region(locationsService.getInitialRegion(from: locations))
            currentLocation = locations.first
        }
    }
}

// MARK: Components
private extension LocationsView {
    var mapView: some View {
        Map(position: $position, interactionModes: .all, content: {
            ForEach(locations) { location in
                annotation(for: location)
            }
        })
        .ignoresSafeArea()
    }
    
    var header: some View {
        VStack {
            headerTitle
            if showLocationsHeaderList,
               let currentLocation = Binding($currentLocation){
                LocationsHeaderList(locations: $locations,
                                    showLocationsHeaderList: $showLocationsHeaderList,
                                    position: $position,
                                    currentLocation: currentLocation)
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
            Text("\(locationsService.getName(from: currentLocation))")
                .foregroundStyle(Color.primary)
                .font(.title2)
                .fontWeight(.black)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .animation(.none, value: currentLocation)
                .overlay(alignment: .leading, content: {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .padding()
                        .foregroundStyle(Color.primary)
                        .rotationEffect(showLocationsHeaderList ? .degrees(180) : .zero)
                })
        })
    }
    
    func annotation(for location: Location) -> Annotation<some View, some View> {
        Annotation(location.name, coordinate: location.coordinates) {
            if let currentLocation = Binding($currentLocation) {
                LocationsAnnotationView(position: $position,
                                        currentLocation: currentLocation,
                                        location: location)
                .scaleEffect(location == currentLocation.wrappedValue ? 1 : 0.7)
                .zIndex(location == currentLocation.wrappedValue ? 1 : 0)
            }
        }
    }
    
    var locationInfoView: some View {
        ForEach(locations) { location in
            if let currentLocation = Binding($currentLocation),
               currentLocation.wrappedValue == location {
                LocationsInfoView(locations: $locations,
                                  position: $position,
                                  currentLocation: currentLocation,
                                  presentSheet: $presentSheet)
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsService())
}
