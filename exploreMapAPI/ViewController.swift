//
//  ViewController.swift
//  exploreMapAPI
//
//  Created by Header-Develop on 2/26/2560 BE.
//  Copyright © 2560 Header-Devs. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMapOUTLET: MKMapView!
    @IBOutlet weak var lblNotificationOUTLET: UILabel!
    var initialLabelOrigin: CGPoint?

    let myGeocoder: CLGeocoder = CLGeocoder()

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let newAnnotationView = MKPinAnnotationView()
        newAnnotationView.animatesDrop = true
        newAnnotationView.pinTintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        newAnnotationView.canShowCallout = true
        
        
        return newAnnotationView
        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

        let centerOfMap = myMapOUTLET.centerCoordinate
        let location = CLLocation(latitude: centerOfMap.latitude, longitude: centerOfMap.longitude)
        myGeocoder.reverseGeocodeLocation(location, completionHandler: {
            (placemarks, error) in

            let place = placemarks?.first
            let message = "Map is centered in \(place?.ocean ?? place?.locality ?? place?.inlandWater ?? "Some place")"

            self.showNotification(message: message)

        })

    }

    func showNotification(message: String) {

        lblNotificationOUTLET.frame.origin.y = view.frame.height
        lblNotificationOUTLET.alpha = 1
        lblNotificationOUTLET.text = message

        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: {

            self.lblNotificationOUTLET.frame.origin.y = (self.initialLabelOrigin?.y)!

        }, completion: { (isFinished: Bool) in

            UIView.animate(withDuration: 1, animations: {

                self.lblNotificationOUTLET.alpha = 0

            })

        })


    }


    @IBAction func tapOnMap(_ sender: UITapGestureRecognizer) {

        if sender.state == .ended {

            let touchLocationAsPoint: CGPoint = sender.location(in: view)
            let touchLocationAsCoodinate: CLLocationCoordinate2D = myMapOUTLET.convert(touchLocationAsPoint, toCoordinateFrom: view)

            let newLocation = CLLocation(latitude: touchLocationAsCoodinate.latitude, longitude: touchLocationAsCoodinate.longitude)

            myGeocoder.reverseGeocodeLocation(newLocation, completionHandler: { (placemarks, error) in

                let locality = placemarks?[0].locality ?? "Somewhere"

                let country = placemarks?[0].country ?? "Some country"

                let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = touchLocationAsCoodinate
                newAnnotation.title = locality
                newAnnotation.subtitle = country

                self.myMapOUTLET.addAnnotation(newAnnotation)


            })

            UIView.animate(withDuration: 1.5, animations: {

                self.myMapOUTLET.centerCoordinate = touchLocationAsCoodinate

            })
        }

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        initialLabelOrigin = lblNotificationOUTLET.frame.origin
        lblNotificationOUTLET.alpha = 0

        let watKhwang = CLLocation(latitude: 16.137093, longitude: 100.302658)

        let annotationInWatKhwang = MKPointAnnotation()
        annotationInWatKhwang.coordinate = watKhwang.coordinate
        annotationInWatKhwang.title = "Wat Khwang"
        annotationInWatKhwang.subtitle = "Thailand"

        myMapOUTLET.addAnnotation(annotationInWatKhwang)
        myMapOUTLET.centerCoordinate = annotationInWatKhwang.coordinate


    }


}
