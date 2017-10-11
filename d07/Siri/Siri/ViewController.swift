//
//  ViewController.swift
//  Siri
//
//  Created by Kyle BAMPING on 2017/10/11.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit
import RecastAI


class ViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var responseLabel: UILabel!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var searchButton: UIButton!


	// ChatBot API
	var bot : RecastAIClient?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.bot = RecastAIClient(token : "7fb65f39e304208683e8028a80a3a4e8")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func makeRequest(_ sender: UIButton) {
		print("Found '\(self.textField.text!)'")
		if !((self.textField.text?.isEmpty)!) { // text input not empty

			self.bot?.textConverse(self.textField.text!, successHandler: { (response) in
				print("Sent '\(self.textField.text)'\n----RESPONSE----")
				print(response.toJSONString(prettyPrint: true) ?? {})
				print("----REPLIES---\n")
				print(response.replies ?? [])

				self.textField.text = ""
				self.responseLabel.text = (response.replies?.count)! > 0 ? response.replies?[0] : "No reply"
			}, failureHandle: { (error) in
				print("Failed to send 'Hello'")
				print(error.localizedDescription)
			})

		}
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {

		print("textFieldShouldReturn")

		textField.resignFirstResponder() // Dismiss the keyboard

		//makeRequest(self.searchButton)

		return true
	}

}

