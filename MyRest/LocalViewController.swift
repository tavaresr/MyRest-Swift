//
//  LocalViewController.swift
//  MyRest
//
//  Created by Ricardo Tavares.
//  Copyright (c) 2015 Ricardo Tavares. All rights reserved.
//

import UIKit
import MapKit

class LocalViewController:UIViewController, MKMapViewDelegate{
    
    //Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    /*
    * ViewDidLoad method
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Menu settings
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //Coordenadas do ISEP
        let latitude:CLLocationDegrees = 41.178475
        let longitude:CLLocationDegrees = -8.607944
        
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let localizacao:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let regiao:MKCoordinateRegion = MKCoordinateRegionMake(localizacao, span)
        
        self.mapView.setRegion(regiao, animated: true)
        
        let pointAnnotation = MKPointAnnotation()
        
        pointAnnotation.coordinate = localizacao
        
        pointAnnotation.title = "MyRest"
        
        pointAnnotation.subtitle = "O melhor restaurante do Porto!"
        
        self.mapView.addAnnotation(pointAnnotation)
    }
}
