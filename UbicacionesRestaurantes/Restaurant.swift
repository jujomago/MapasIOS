//
//  Restaurant.swift
//  UbicacionesRestaurantes
//
//  Created by Wendy Cayani on 12/11/15.
//  Copyright © 2015 SinapSysIT. All rights reserved.
//

import UIKit
import MapKit


class Restaurant:  NSObject,MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    var title: String?
    var subtitle:String?
    
    
    var custom_image: Bool = true
    var color:UIColor = MKPinAnnotationView.greenPinColor()
    
    
    init(titulo:String,subtitle:String,coordinate:CLLocationCoordinate2D) {
        self.title=titulo
        self.subtitle=subtitle
        self.coordinate=coordinate
    }
    init(titulo:String,subtitle:String) {
        self.title=titulo
        self.subtitle=subtitle
    }
    
    
}