//
//  FirstViewController.swift
//  Kanto
//
//  Created by Kyle BAMPING on 2017/10/10.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit

struct Location {
	var title : String = ""
	var subtitle : String = ""
	var coords : String = ""
}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var locationsTableView: UITableView!
	var locations : [Location] = [
									Location(title: "WeThinkCode_", subtitle: "This is some info", coords: "-26.2049337,28.0379703"),
									Location(title: "Place Two", subtitle: "This is some info", coords: "0.0, 0.0"),
									Location(title: "Place Three", subtitle: "This is some info", coords: "0.0, 0.0")
	                              ]

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return locations.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell : UITableViewCell = locationsTableView.dequeueReusableCell(withIdentifier: "cell")!

		cell.textLabel?.text = locations[indexPath.row].title

		return cell
	}

}

