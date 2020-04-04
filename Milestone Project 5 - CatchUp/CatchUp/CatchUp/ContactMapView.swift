//
//  ContactMapView.swift
//  CatchUp
//
//  Created by RAJ RAVAL on 02/04/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import SwiftUI
import MapKit

struct ContactMapView: UIViewRepresentable {
    
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: ContactMapView
        
        init(_ parent: ContactMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            <#code#>
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // More to come
    }
    
}
