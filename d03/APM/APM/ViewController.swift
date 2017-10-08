//
//  ViewController.swift
//  APM
//
//  Created by Kyle BAMPING on 2017/10/08.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

	@IBOutlet weak var myCollectionView: UICollectionView!

	// Array of image URLs
	let imageURLs : [String] =
		[
			"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/iss053e023965.jpg",
			"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/ega_1ms_mapcam_color_corrected_0.png",
			"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/images/581363main_PIA00013_full.jpg",
			"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/iss053e0794041.jpg",
			"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/orion-las-test-img2451.jpg",
			"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia21350-1041.jpg",
			"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/iss053e047067.jpg",
			"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/37488222542_f680cf2a11_o.jpg",
			"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/34253921331_aec575a398_o.jpg",
			"https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/33204101741_4feb9a2c38_o.jpg"
		]

	// Array of NSURL Objects
	var urls : [NSURL]!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		// Build url objects onLoad
		urls = imageURLs.map({ (url: String) -> NSURL in
			return NSURL(string: url)!
		})

		let itemSize = UIScreen.main.bounds.width / 3 - 3
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
		layout.itemSize = CGSize(width: itemSize, height: itemSize)

		layout.minimumInteritemSpacing = 3
		layout.minimumLineSpacing = 3

		myCollectionView.collectionViewLayout = layout

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return imageURLs.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCollectionViewCell

		print("\(indexPath.row) - \(urls[indexPath.row])")

		// Show activity indicator
		cell.downloadIndicator.startAnimating()
		cell.downloadIndicator.isHidden = false

		// Enable Network indicator
		UIApplication.shared.isNetworkActivityIndicatorVisible = true

		// Download image - Asynchronously
		URLSession.shared.dataTask(with: urls[indexPath.row] as URL, completionHandler: {
			(data, resp, error) -> Void in
			if (error == nil && data != nil) {
				if let httpResponse = resp as? HTTPURLResponse {
					if httpResponse.statusCode == 200 {
						// There are 2 ways of using multi thread -  GCD and NSOperationQueue or OperationQueue
						// GCD
						//				DispatchQueue.main.async(execute: {
						//					indicator.isHidden = true
						//					self.imageView.image = UIImage(data: data!)
						//				})

						// NSOperationQueue/OperationQueue
						OperationQueue.main.addOperation({
							cell.downloadIndicator.stopAnimating()
							cell.downloadIndicator.isHidden = true
							cell.myImageView.image = UIImage(data: data!)
						})
					} else {
						cell.downloadIndicator.stopAnimating()
						cell.downloadIndicator.isHidden = true
						print("Request failed\nURL:'\(httpResponse.url!)'\nSuggested Name:'\(httpResponse.suggestedFilename!)'\nresponseCode: '\(httpResponse.statusCode)'")
						self.createAlert(title: "\(httpResponse.statusCode) - Request failed", message: "Name:'\(httpResponse.suggestedFilename!)'\nURL:'\(httpResponse.url!)'\n")
					}
				}
			}
			
		}).resume()

		// Disable Network indicator
		UIApplication.shared.isNetworkActivityIndicatorVisible = false

		return cell
	}

	// Function to create an alert
	func createAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

		// Create a button
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
			alert.dismiss(animated: true, completion: { 
				print("DISMISSED ALERT")
			})
		}))

		self.present(alert, animated: true, completion: nil)
	}

	// Send image url to scroll view
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destinationViewController.
		let destVC = segue.destination as? scrollViewController
		let og = sender as? myCollectionViewCell
		destVC?.image = og?.myImageView.image

	}

}

