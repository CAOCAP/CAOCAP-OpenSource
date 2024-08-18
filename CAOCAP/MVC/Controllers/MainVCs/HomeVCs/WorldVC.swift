//
//  WorldVC.swift
//  CAOCAP
//
//  Created by Azzam AL-Rashed on 23/04/2024.
//

import UIKit
import MapKit
//import CoreLocation //TODO: add user location


class WorldVC: UIViewController, Storyboarded {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(),
                                            latitudinalMeters: 1, longitudinalMeters: 1)
        // Do any additional setup after loading the view.
    }

}
