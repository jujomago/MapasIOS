//
//  ViewController.swift
//  UbicacionesRestaurantes
//
//  Created by Wendy Cayani on 10/11/15.
//  Copyright © 2015 SinapSysIT. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var labelTitulo: UILabel!
    
    var myRoute : MKRoute?
    
  
    var origen:CLLocationCoordinate2D?
    var destino:CLLocationCoordinate2D?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // ponemos la posicion inicial del mapa coord de Tarija
        
        let location=CLLocationCoordinate2D(latitude: -21.520634923092178, longitude: -64.72964286804199)
        let span=MKCoordinateSpanMake(0.05, 0.05);
        let region=MKCoordinateRegion(center: location, span: span)
        mapView.delegate=self
        
        mapView.setRegion(region, animated: true);
        
        // anotaciones
        
        
        let currentLocation=Restaurant(titulo:"CURRENT_LOCATION",subtitle: "CURRENT LOCATION FAKE")
        currentLocation.color=MKPinAnnotationView.redPinColor()
        currentLocation.coordinate=CLLocationCoordinate2D(latitude: -21.535223, longitude:  -64.731602)
        
        mapView.addAnnotation(currentLocation)
        mapView.centerCoordinate=currentLocation.coordinate
        
        
       
        
        
        
        let rest1=Restaurant(titulo: "XOXO", subtitle: "Restaurante Bar XOXO")
        rest1.coordinate=CLLocationCoordinate2D(latitude: -21.534402895632454, longitude: -64.73455466330051)
        //rest11.color=MKPinAnnotationView.redPinColor()
        
        
        let rest2=Restaurant(titulo: "GattoPardo", subtitle: "Restaurante Taberna Gatto Pardo")
        rest2.coordinate=CLLocationCoordinate2D(latitude: -21.533578, longitude: -64.73384)

        let rest3=Restaurant(titulo: "Marquez", subtitle: "Restaurante El Marquez")
        rest3.coordinate=CLLocationCoordinate2D(latitude: -21.533505, longitude: -64.734142)

        let rest4=Restaurant(titulo: "Encuentro", subtitle: "Restaurant Salteñeria Punto de Encuentro")
        rest4.coordinate=CLLocationCoordinate2D(latitude: -21.532202, longitude: -64.729452)

        let rest5=Restaurant(titulo: "Guadalquivir", subtitle: "Restaurant Familiar Guadalquivir")
        rest5.coordinate=CLLocationCoordinate2D(latitude: -21.534383, longitude: -64.725039)
        
        let rest6=Restaurant(titulo: "Mediterraneo", subtitle: "Restaurante Mediterraneo")
        rest6.coordinate=CLLocationCoordinate2D(latitude: -21.534923,  longitude: -64.732500)
        
        let restorants_pins:[Restaurant]=[rest1,rest2,rest3,rest4,rest5,rest6]
        
        
        for resto in restorants_pins{
          mapView.addAnnotation(resto)
        }

        
        
        
        let directionsRequest = MKDirectionsRequest()
        let puntoA = MKPlacemark(coordinate: CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude), addressDictionary: nil)
        let puntoB = MKPlacemark(coordinate: CLLocationCoordinate2DMake(rest6.coordinate.latitude, rest6.coordinate.longitude), addressDictionary: nil)
        
        directionsRequest.source=MKMapItem(placemark: puntoA)
        directionsRequest.destination=MKMapItem(placemark: puntoB)
        directionsRequest.transportType = MKDirectionsTransportType.Automobile
        
        let directions = MKDirections(request: directionsRequest)
        directions.calculateDirectionsWithCompletionHandler({
            (response: MKDirectionsResponse?, error: NSError?) in
            print("response:")
            print(response)
            print("error:")
            print(error)
            if error == nil {
                self.myRoute = response!.routes[0] as? MKRoute
                self.mapView.addOverlay((self.myRoute?.polyline)!)
            }
        })
        
        
         origen=currentLocation.coordinate
         destino=rest3.coordinate
        
    }
    

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
        
        let resTemp:Restaurant = annotation as! Restaurant
        
        pinAnnotationView.pinTintColor=resTemp.color
        pinAnnotationView.canShowCallout = true
        pinAnnotationView.animatesDrop = true
        
        return pinAnnotationView
    }
    
    
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print("selected")
        
        let tempanotation:Restaurant=view.annotation as! Restaurant
        labelTitulo.text=tempanotation.subtitle
        
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        //var myLineRenderer = MKPolylineRenderer(polyline: (myRoute?.polyline)!)
       
        var myLineRenderer = MKPolylineRenderer(overlay: overlay)
        myLineRenderer.strokeColor = UIColor.redColor()
        myLineRenderer.lineWidth = 3
        return myLineRenderer
    }
    

    
    @IBAction func encontrarRuta(sender: AnyObject) {
        
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        
        points.append(origen!)
        points.append(destino!)
        
        var polyline = MKPolyline(coordinates: &points, count: points.count)
        mapView.addOverlay(polyline)

    }
    

}

