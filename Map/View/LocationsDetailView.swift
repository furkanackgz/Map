//
//  LocationsDetailView.swift
//  Map
//
//  Created by Furkan Açıkgöz on 25.08.2024.
//

import SwiftUI
import MapKit

struct LocationsDetailView: View {
    
    @Binding var presentSheet: Bool
    var location: Location
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    imageSection(geometry)
                    
                    VStack(spacing: 16) {
                        titleSection
                        Divider()
                        descriptionSection
                        Divider()
                        mapSection
                    }
                    .padding()
                }
            }
            .overlay(alignment: .topLeading) {
                closeButton
            }
            .scrollBounceBehavior(.basedOnSize)
            .ignoresSafeArea()
        }
    }
}

// MARK: Components
private extension LocationsDetailView {
    func imageSection(_ geometry: GeometryProxy) -> some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: geometry.size.width)
                    .clipped()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: geometry.size.width)
        .shadow(color: .black.opacity(0.3),
                radius: 20, x: 0, y: 10)
    }
    
    var titleSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .foregroundStyle(.secondary)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .tint(.blue)
                    .font(.headline)
            }
        }
    }
    
    var mapSection: some View {
        let span: MKCoordinateSpan = .init(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region: MKCoordinateRegion = .init(center: location.coordinates, span: span)
        let position: MapCameraPosition = .region(region)
        
        return Map(initialPosition: position)
                .aspectRatio(1, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .disabled(true)
    }
    
    var closeButton: some View {
        Button(action: {
            presentSheet = false
        }, label: {
            Image(systemName: "xmark")
                .frame(width: 50, height: 50)
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(24)
                .font(.title3)
                .foregroundStyle(Color.primary)
                .shadow(radius: 4)
        })
    }
}

#Preview {
    LocationsDetailView(presentSheet: .constant(false),
                        location: LocationsDataService.locations.first!)
}
