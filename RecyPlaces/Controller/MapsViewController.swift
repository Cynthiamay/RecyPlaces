//
//  MapsViewController.swift
//  RecyPlaces
//
//  Created by cynthia watanabe on 07/11/22.
//

import Foundation
import UIKit
import MapKit

protocol MapsViewControllerDelegate {
    func mapsViewControllerDidSelectAnnotation(mapItem: MKMapItem)
}

class MapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    var delegate: MapsViewControllerDelegate!
    var locationManager: CLLocationManager!
    var place: Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false
        setupViewConfiguration()

        self.locationManager = CLLocationManager()
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        mapView.delegate = self
        self.mapView.showsUserLocation = true
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        let annotationView = views.first!
        
        if let annotation = annotationView.annotation {
            if annotation is MKUserLocation {

                var region = MKCoordinateRegion()
                region.center = self.mapView.userLocation.coordinate
                region.span.latitudeDelta = 0.025
                region.span.longitudeDelta = 0.025
                
                self.mapView.setRegion(region, animated: true)
                
                populateNearByPlaces()

            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let annotation = view.annotation as! PlaceAnnotation
        self.delegate.mapsViewControllerDidSelectAnnotation(mapItem: annotation.mapItem)
    }
    
    func populateNearByPlaces() {
        
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.place.title
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response else {
                return
            }
            
            for item in response.mapItems {
                
                let annotation = PlaceAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotation.mapItem = item
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
}

extension MapsViewController: ViewConfiguration {
    func buildViewHierarchy() {
        self.view.addSubview(mapView)
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    func configureViews() {
    }
}
