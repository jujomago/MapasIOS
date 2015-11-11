//
//  ViewController.swift
//  UbicacionesRestaurantes
//
//  Created by Wendy Cayani on 10/11/15.
//  Copyright © 2015 SinapSysIT. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    let regionRadius:CLLocationDistance=2500
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ponemos la posicion inicial del mapa coord de Tarija
        
        let location=CLLocationCoordinate2D(latitude: -21.520634923092178, longitude: -64.72964286804199)
        let span=MKCoordinateSpanMake(0.12, 0.12);
        let region=MKCoordinateRegion(center: location, span: span)
        
        
        // anotaciones
        
        
        let restaurant1:[String:Any]=["latitud":-21.534402895632454,"longitud":-64.73455466330051,"titulo":"XOXO Restobar","subtitulo":"Restaurante Bar XOXO"];
        
        let restaurant2:[String:Any]=["latitud": -21.533578,"longitud":-64.73384,"titulo":"GattoPardo","subtitulo":"Restaurante Taberna Gatto Pardo"];
        
        let restaurant3:[String:Any]=["latitud": -21.533505,"longitud":-64.734142,"titulo":"Marquez","subtitulo":"Restaurante El Marquez"];
        
        let restaurant4:[String:Any]=["latitud": -21.532202,"longitud": -64.729452,"titulo":"Punto de Encuentro","subtitulo":"Restaurant Salteñeria Punto de Encuentro"];
        
         let restaurant5:[String:Any]=["latitud":-21.534383,"longitud": -64.725039,"titulo":"Restaurant Guadalquivir","subtitulo":"Restaurant Familiar Guadalquivir"];
        
        let restaurantes=[restaurant1,restaurant2,restaurant3,restaurant4,restaurant5]
        
        
        for resto in restaurantes{
     
            
            var anotation=MKPointAnnotation()
            
            let locationTemp=CLLocationCoordinate2D(latitude: resto["latitud"] as! Double,longitude: resto["longitud"] as! Double)
            
            anotation.coordinate = locationTemp
            anotation.title = resto["titulo"] as! String
            anotation.subtitle = resto["subtitulo"] as! String
            mapView.addAnnotation(anotation)
            
        }

        mapView.setRegion(region, animated: true);
        
        

        
    
        //mapView.addAnnotation(anotation)
        
        
     //   let initialLocation=CLLocation(latitude: -21.5387136, longitude: -64.7154436)
        
       // centerMapOnLocation(initialLocation)
        
    }
    
    func centerMapOnLocation(location:CLLocation){
        
        let coordinateRegion=MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius*2.0, regionRadius*2)
        
        
        mapView.setRegion(coordinateRegion, animated: true)
    
    }


}

