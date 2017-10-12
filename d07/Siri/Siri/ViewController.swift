//
//  ViewController.swift
//  Siri
//
//  Created by Kyle BAMPING on 2017/10/11.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit
import RecastAI
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var responseLabel: UILabel!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var searchButton: UIButton!

	// NOTE:: set initial location in device simulator to WeThinkCode_ (-26.2049337,28.0379703)

	// ChatBot API
	var bot : RecastAIClient?

	// Location Manager
	var locationManager = CLLocationManager()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.bot = RecastAIClient(token : "7fb65f39e304208683e8028a80a3a4e8")

		/*### LocationManger Setup ###*/
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		locationManager.distanceFilter = 10

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func makeRequest(_ sender: UIButton) {
		print("Found '\(self.textField.text!)'")
		if !((self.textField.text?.isEmpty)!) { // text input not empty

			self.bot?.textRequest(self.textField.text!, successHandler: { (response) in
				print("Sent '\(self.textField.text)'\n----RESPONSE----")
				print(response)

				// Clear text field on success
				self.textField.text = ""

				// Get location from RecastAI bot
				var coords : String = ""
				if let location = response.get(entity: "location") {
					if let locName = location["formatted"] {
						OperationQueue.main.addOperation({
							self.locationLabel.text = String(describing: locName)
						})
					}
					if let latStr = location["lat"], let lngStr = location["lng"] {
						print("---letStr-lngStr\n\(latStr), \(lngStr)")
						coords += String(describing: latStr)
						coords += "," + String(describing: lngStr)
						self.getWeatherFor(coords: coords)
					}
				} else {
					print("-----NO LOCATION FOUND, USING CURRENT LOCATION-----")
					OperationQueue.main.addOperation({
						self.locationLabel.text = "Current Location"
					})
					self.locationManager.requestWhenInUseAuthorization()
					self.locationManager.requestLocation()
				}

			}, failureHandle: { (error) in
				print("-----ERROR-----")
				print(error.localizedDescription)
				self.responseLabel.text =  error.localizedDescription
			})

		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {

		print("textFieldShouldReturn")

		textField.resignFirstResponder() // Dismiss the keyboard

		//makeRequest(self.searchButton)

		return true
	}

	func getWeatherFor(coords: String) {
		print("-----GETWEATHER-----")
		print("-----BEFORE ENCODING-----\n\(coords)")
		let encodedCoords = coords.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
		print("-----AFTER ENCODING-----\n\(encodedCoords?.description)")
		let urlStr : String = "https://api.darksky.net/forecast/d99e828ba53977ed62d8caa980da4baa/"
		let arguments : String = "?exclude=minutely,hourly,daily,alerts,flags&units=ca"
		let url : NSURL = NSURL(string: urlStr + encodedCoords! + arguments)!
		let request = NSMutableURLRequest(url: url as URL)

		request.httpMethod = "GET"
		request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")

		let task = URLSession.shared.dataTask(with: request as URLRequest) {
			(data, response, error) in
			if let resp = response {
				print("------- RESPONSE -------\n\(resp)")
			}

			if let err = error {
				print("------- ERROR -------\n\(err)")
			}
			else if let d = data {
				do {
					let jsonObject = try JSONSerialization.jsonObject(with: d, options: [])
					print("------- jsonObject -------\n\(jsonObject)")
					if let jsonObject = jsonObject as? [String: AnyObject] {
						if let currentData = JSONValue.fromObject(jsonObject)?["currently"]?.object {
							print("------- jsonData -------\n\(currentData)")
							// Out string for label
							var output : String = ""
							for (key, val) in currentData {
								if key == "temperature" {
									print("-------temps-----")
									if let temp = val.double {
										output = "\(temp)°C, " + output
									}

								}
								if  key == "summary" {
									print("--summary--")
									if let cond = val.string {
										output += "\n\(cond) conditions"
									}
								}
								if key == "windSpeed" {
									print("--windspeed--")
									if let wind = val.double {
										output += " \(wind) km/h"
									}
								}
							}
							print("output--\n\(output)")
							OperationQueue.main.addOperation({
								self.responseLabel.text = output
							})
						}
					}
				}
				catch (let err) {
					print(err)
					// Update the UI on the main thread
					OperationQueue.main.addOperation({
						self.responseLabel.text = err.localizedDescription
					})
				}
			}
		}
		task.resume()
	}

	/*### LocationManager Functions ###*/
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		print("--- Updated locations ---")
		for loc in locations {
			print(loc.description)
		}

		let location = locations.last! as CLLocation
		var coords = location.coordinate.latitude.description
		coords += "," + location.coordinate.longitude.description
		print("-----COORDS----\n\(coords)")
		self.getWeatherFor(coords: coords)
		
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("-----LOCATION MANAGER ERROR-----\n\(error.localizedDescription)")
	}

}

