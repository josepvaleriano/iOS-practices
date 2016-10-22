//
//  ViewController.swift
//  GPSDemo
//
//  Created by Infraestructura on 22/10/16.
//  Copyright © 2016 Valeriano Lopez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var txtLat: UITextField!
    
    @IBOutlet weak var txtLon: UITextField!
    
    @IBOutlet weak var mapMiMapa: MKMapView!
    
    var localizador : CLLocationManager?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.localizador = CLLocationManager()
        self.localizador?.desiredAccuracy = kCLLocationAccuracyBest
        self.localizador?.delegate = self
        //preguntar si tiene autorizacion
        let autorizado  = CLLocationManager.authorizationStatus()
        if autorizado == CLAuthorizationStatus.NotDetermined {
            self.localizador?.requestWhenInUseAuthorization()
        }
        
        self.localizador?.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        self.localizador?.stopUpdatingLocation()
        let ac = UIAlertController(title: "Error", message: "Noting list gps", preferredStyle: .Alert)
        let ab = UIAlertAction(title: "Unhability gps so do noting ..", style: .Default, handler: nil)
        ac.addAction(ab)
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let ubicacion = locations.last! as CLLocation
        self.txtLat.text = "\(ubicacion.coordinate.latitude)"
        self.txtLon.text = "\(ubicacion.coordinate.longitude)"
        //TODO: determinar si se dejan de tomar lecturas
        self.ColocarMapa(ubicacion )
    }
    
    func ColocarMapa(ubicacion : CLLocation ){
        //////
        let locFija = CLLocationCoordinate2D(latitude: 18.23, longitude: -99.3)
        
        
        ///////
        let laCoordenada = locFija //ubicacion.coordinate
        let region = MKCoordinateRegionMakeWithDistance(laCoordenada, 9000, 9000) // radio 1 km
        self.mapMiMapa.setRegion(region, animated: true)
        // por que sigue leyendo coodenadas cuando se abre la aplicacion
        let losPines = self.mapMiMapa.annotations
        self.mapMiMapa.removeAnnotations(losPines)
        let elPin = ElPin(title: "You are here", subtitle: "Near 1 mi", coordinate: laCoordenada)
        self.mapMiMapa.addAnnotation(elPin)
        self.localizador?.stopUpdatingLocation()
    }
}







