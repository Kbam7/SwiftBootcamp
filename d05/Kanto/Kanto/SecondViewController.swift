//
//  SecondViewController.swift
//  Kanto
//
//  Created by Kyle BAMPING on 2017/10/10.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var modeControl: UISegmentedControl!

	var locationManager = CLLocationManager()
	var currentLoc : CLLocation = CLLocation(latitude: 0, longitude: 0)

	var artworks = [Artwork]()

	@IBAction func getMyLocation(_ sender: UIButton) {
		centerMapOnLocation(location: self.currentLoc)
	}

	@IBAction func modeControlChangeValue(_ sender: Any) {
		if modeControl.selectedSegmentIndex == 0 { // Standard
			mapView.mapType = .standard
		}
		if modeControl.selectedSegmentIndex == 1 { // Satelite
			mapView.mapType = .satellite
		}
		if modeControl.selectedSegmentIndex == 2 { // Hybrid
			mapView.mapType = .hybrid
		}
	}

	func loadInitialData() {
		do {
			if let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json") {
				let data = try Data(contentsOf: URL(fileURLWithPath: fileName))
				let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
				if let jsonObject = jsonObject as? [String: AnyObject], let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
					for artworkJSON in jsonData {
						if let artworkJSON = artworkJSON.array, let artwork = Artwork.fromJSON(json: artworkJSON) {
							artworks.append(artwork)
						}
					}
				}
			}
		} catch {
			print("----ERRROR-----\(error.localizedDescription)")
		}
	}

	// Helper function to center on location
	let regionRadius: CLLocationDistance = 1000 // distance in meters
	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
		mapView.setRegion(coordinateRegion, animated: true)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		/*### MapView Setup ###*/

		mapView.delegate = self
		// set initial location in Honolulu
		let initialLocation = CLLocation(latitude: -26.2049337, longitude: 28.0379703)
		centerMapOnLocation(location: initialLocation)
		// show artwork on map
		let artwork = Artwork(title: "WeThinkCode_",
		                      locationName: "Revolutionary code school",
		                      discipline: "Sculpture",
		                      coordinate: initialLocation.coordinate)
		
		mapView.addAnnotation(artwork)

		//loadInitialData()
		//mapView.addAnnotations(artworks)

		/*### LocationManger Setup ###*/
		
		locationManager.requestWhenInUseAuthorization()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		locationManager.distanceFilter = 10
		locationManager.startUpdatingLocation()

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*### MapView Functions ###*/
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if let annotation = annotation as? Artwork {
			let identifier = "pin"
			var view: MKPinAnnotationView
			if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
				dequeuedView.annotation = annotation
				view = dequeuedView
			} else {
				view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
				view.canShowCallout = true
				view.calloutOffset = CGPoint(x: -5, y: 5)
				view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
			}
			return view
		}
		return nil
	}

	/*### LocationManager Functions ###*/
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print("--- Updated locations ---")
		for loc in locations {
			print(loc.description)
		}

		let location = locations.last! as CLLocation

		self.currentLoc = location

	}

}

