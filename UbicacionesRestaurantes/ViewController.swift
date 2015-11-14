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
        let span=MKCoordinateSpanMake(0.010, 0.010)
        let region=MKCoordinateRegion(center: location, span: span)
        mapView.delegate=self
        
        mapView.setRegion(region, animated: true);
        
        
        
        // -------- anotacion fake de la posicion actual, podria sacar la posicion real pero no funcionarian para trazar las rutas a los restaurantes de tarija si estan en otro departamento
        
        let currentLocation=Restaurant(titulo:"CURRENT_LOCATION",subtitle: "CURRENT LOCATION FAKE")
        currentLocation.color=MKPinAnnotationView.redPinColor()
        currentLocation.coordinate=CLLocationCoordinate2D(latitude: -21.535223, longitude:  -64.731602)
        
        mapView.addAnnotation(currentLocation)
        mapView.centerCoordinate=currentLocation.coordinate
        
        
        // ####### el punto inicial para trazar la linea o ruta siempre va ser la posicion actual, en este caso la posicion fake
        origen=currentLocation.coordinate
        
        
        colocarRestaurantes()
       
        
        
        
 

        // ##################  MKDirections no funciona en Bolivia :(
        
        /*
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
        */
        
      
        
    }
    
    func colocarRestaurantes(){
        
        let rest1=Restaurant(titulo: "XOXO", subtitle: "Restaurante Bar XOXO")
        rest1.coordinate=CLLocationCoordinate2D(latitude: -21.534402895632454, longitude: -64.73455466330051)
        
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
        
        let rest7=Restaurant(titulo: "Pizza Pazza", subtitle: "Resturante Pizza Pazza Maconco")
        rest7.coordinate=CLLocationCoordinate2D(latitude: -21.54013, longitude: -64.72033)
        
        let rest8=Restaurant(titulo: "Floresta Don Ñato", subtitle: "Resturante la Floresta Don Ñato")
        rest8.coordinate=CLLocationCoordinate2D(latitude: -21.54128, longitude: -64.73720)
        
        let rest9=Restaurant(titulo: "Candelero", subtitle: "Resturante el Candelero")
        rest9.coordinate=CLLocationCoordinate2D(latitude: -21.53724, longitude: -64.72498)
        
        let rest10=Restaurant(titulo: "Chura Casa", subtitle: "Resturante Chura Casa")
        rest10.coordinate=CLLocationCoordinate2D(latitude: -21.53241, longitude: -64.73744)
        
        
        let restorants_pins:[Restaurant]=[rest1,rest2,rest3,rest4,rest5,rest6,rest7,rest8,rest9,rest10]
        
        
        for resto in restorants_pins{
            mapView.addAnnotation(resto)
        }
    
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
       
        let tempanotation:Restaurant=view.annotation as! Restaurant
        labelTitulo.text=tempanotation.subtitle
        if(tempanotation.title != "CURRENT_LOCATION"){
        
            destino=tempanotation.coordinate

        }
        
    
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        
        // ########## ESTE CODIGO ERA PARA LA RUTA PERO NO FUNCIONA EN BOLIVIA ##########
        //var myLineRenderer = MKPolylineRenderer(polyline: (myRoute?.polyline)!)
       
        
        let myLineRenderer = MKPolylineRenderer(overlay: overlay)
        myLineRenderer.strokeColor = getRandomColor()
        myLineRenderer.lineWidth = 3
        return myLineRenderer
    }
    
    
    func getRandomColor()->UIColor{
        let randomRed:CGFloat=CGFloat(drand48())
        
        let randomGreen:CGFloat=CGFloat(drand48())

        let randomBlue:CGFloat=CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    

    
    @IBAction func encontrarRuta(sender: AnyObject) {
        
        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        
        if(destino==nil){
            let alertController = UIAlertController(title: "Mensaje", message:
                "Debes Seleccionar un Pin VERDE en el Mapa!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }else{
            
            points.append(origen!)
            points.append(destino!)
            
            let polyline = MKPolyline(coordinates: &points, count: points.count)
            mapView.addOverlay(polyline)

        }
       
    }
    

}

