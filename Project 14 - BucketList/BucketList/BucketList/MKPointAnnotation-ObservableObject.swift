//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by RAJ RAVAL on 11/03/20.
//  Copyright © 2020 Buck. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown Value"
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown Value"
        }
        set {
            subtitle = newValue
        }
    }
    
}
