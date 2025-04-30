//
//  mapViewController.swift
//  LocalExplorerApp
//
//  Created by Nahum Shigute on 4/28/25.
//

import UIKit
import MapKit
import CoreData

class mapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var photos: [Photo] = []
    
    var locationManager: CLLocationManager!

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var sgmtMapType: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func findMeBtn(_ sender: Any) {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        var span = MKCoordinateSpan()
        span.latitudeDelta = 0.2
        span.longitudeDelta = 0.2
        let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapView.setRegion(viewRegion, animated: true)
        let mp = MapPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        mp.title = "You"
        mp.subtitle = "Are here"
        
        mapView.addAnnotation(mp)
        
    }
    
    
    private func processAddressResponse(_ photo: Photo, withPlacemark placemarks: [CLPlacemark]?, error: Error?) {
         if let error = error {
             print("GeoCoder Error: \(error)")
             
         } else {
             var bestMatch: CLLocation?
             if let placemarks = placemarks, placemarks.count > 0 {
                 bestMatch = placemarks.first?.location
             }
             if let coordinate = bestMatch?.coordinate {
                 let mp = MapPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
                 mp.title = photo.photoName
                 mapView.addAnnotation(mp)
             }
             else {
                 print("Didnt find any Matching locations")
             }
         }
     }

    
    
    @IBAction func mapTypeChanged(_ sender: Any) {
        switch sgmtMapType.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default: break
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
