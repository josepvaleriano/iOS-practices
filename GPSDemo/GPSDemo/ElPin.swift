//
//  ElPin.swift
//  GPSDemo
//
//  Created by Infraestructura on 22/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import Foundation
import MapKit

class ElPin: NSObject, MKAnnotation{
    var title : String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init( title : String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
    
    
}