//
//  ViewController.swift
//  exploreMapAPI
//
//  Created by Header-Develop on 2/26/2560 BE.
//  Copyright © 2560 Header-Devs. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var myMapOUTLET: MKMapView!

    @IBAction func tapOnMap(_ sender: UITapGestureRecognizer) {

        if sender.state == .ended {

            let touchLocationAsPoint: CGPoint = sender.location(in: view)
            let touchLocationAsCoodinate: CLLocationCoordinate2D = myMapOUTLET.convert(touchLocationAsPoint, toCoordinateFrom: view)

            UIView.animate(withDuration: 1.5, animations: {

                self.myMapOUTLET.centerCoordinate = touchLocationAsCoodinate

            })

        }

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let watKhwang = CLLocation(latitude: 16.137093, longitude: 100.302658)

        let annotationInWatKhwang = MKPointAnnotation()
        annotationInWatKhwang.coordinate = watKhwang.coordinate
        annotationInWatKhwang.title = "Wat Khwang"
        annotationInWatKhwang.subtitle = "Thailand"

        myMapOUTLET.addAnnotation(annotationInWatKhwang)
        myMapOUTLET.centerCoordinate = annotationInWatKhwang.coordinate

    }


}
