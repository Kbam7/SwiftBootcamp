//
//  ViewController.swift
//  Tweets
//
//  Created by Kyle BAMPING on 2017/10/09.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit

struct Tweet : CustomStringConvertible {
	let name : String
	let text : String

	var description: String {
		return "(\(name) - \"\(text)\")"
	}
}

protocol APITwitterDelegate {
	func processTweets(_ tweets: [Tweet]) -> Void
	func tweetsError(_ err: NSError) -> Void
}

class APIController {
	var delegate : APITwitterDelegate?
	var	token : String = ""

	// Constructor
	init(delegate: APITwitterDelegate?, token: String) {
		self.delegate = delegate
		self.token = token
	}

	// Search for tweets
	func searchForTweetsContaining(query: String) -> Bool {

		let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
		let url : NSURL = NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?q=" + encodedQuery! + "&count=2&lang=en&result_type=recent")!
		let request = NSMutableURLRequest(url: url as URL)

		request.httpMethod = "GET"
		request.setValue("Bearer " + self.token, forHTTPHeaderField: "Authorization")
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
					print("------- DATA -------\n\(try JSONSerialization.jsonObject(with: d))")
					if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//					if let dic = try JSONSerialization.jsonObject(with: d) as  {
						print("------- DATA -------\n\(dic)")
						print(dic.allKeys)

						print(dic.value(forKey: "statuses") as Any)

						dic.value(forKey: "statuses").map({ (item : Any) -> Void in
							print("---ITEM---\n \(item)")
						})

						let tweets : [Tweet] = dic.map({
							(key: Any, value: Any) -> Tweet in
								return Tweet(name: key as! String, text: value as! String)
						})

						// Displays tweets on View Controller
						self.delegate?.processTweets(tweets)
					}
				}
				catch (let err) {
					print(err)
				}
			}
		}
		task.resume()
		return true
	}

}

class ViewController: UIViewController, APITwitterDelegate {

	var apiCtrlr : APIController?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.


		var tok : String = ""
		let consumer_key : String = "wkk87wCP4WizS59O6v9Hp4ZUn"
		let consumer_secret : String = "BDdXyqoqh1ONUIvQAHWJPbccEgvZrRI7QXI6jeDrrgrdIX6bp0"

		// Get bearer for initial authentification
		let BEARER = ((consumer_key + ":" + consumer_secret).data(using: String.Encoding.utf8))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))

		// Target address
		let url : NSURL = NSURL(string: "https://api.twitter.com/oauth2/token")!
		let request = NSMutableURLRequest(url: url as URL)

		// Configure request
		request.httpMethod = "POST"
		request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
		request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
		request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)

		let task = URLSession.shared.dataTask(with: request as URLRequest) {
			(data, response, error) in
			if let resp = response {
				print("------- RESPONSE (BEARER) -------\n\(resp)")
			}

			if let err = error {
				print("------- ERROR (BEARER) -------\n\(err)")
			}
			else if let d = data {
				do {
					if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
						print("------- DATA (BEARER) -------\n\(dic)")
						if (dic.value(forKey: "token_type") as! String == "bearer") {
							print("FUCK YEAH!!")
							tok = dic.value(forKey: "access_token") as! String
							//getTweets(token: dic.value(forKey: "access_token") as! String, q: "q=%40twitterapi&count=4")
							if tok != "" {
								self.apiCtrlr = APIController(delegate: self as APITwitterDelegate, token: tok)
								if (self.apiCtrlr?.searchForTweetsContaining(query: "school 42") == true) {
									print("SUCCESS")
								}
							} else {
								print("------- ERROR -------\nNO AUTH TOKEN")
							}
						}
					}
				}
				catch (let err) {
					print(err)
				}
			}
		}
		task.resume()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// Process data into views
	func processTweets(_ tweets : [Tweet]) -> Void {
		for twt in tweets {
			print(twt)
		}
	}

	// In case of errors
	func tweetsError(_ err : NSError) -> Void {
		print("------- ERROR -------\n\(err)")
	}


}

func getAuthentificationToken(_ consumer_key : String = "wkk87wCP4WizS59O6v9Hp4ZUn",
                              _ consumer_secret : String = "BDdXyqoqh1ONUIvQAHWJPbccEgvZrRI7QXI6jeDrrgrdIX6bp0") -> String
{
	var tok : String = ""
	// Get bearer for initial authentification
	let BEARER = ((consumer_key + ":" + consumer_secret).data(using: String.Encoding.utf8))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))

	// Target address
	let url : NSURL = NSURL(string: "https://api.twitter.com/oauth2/token")!
	let request = NSMutableURLRequest(url: url as URL)

	// Configure request
	request.httpMethod = "POST"
	request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
	request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
	request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)

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
				if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
					print("------- DATA -------\n\(dic)")
					if (dic.value(forKey: "token_type") as! String == "bearer") {
						print("FUCK YEAH!!")
						tok = dic.value(forKey: "access_token") as! String
						//getTweets(token: dic.value(forKey: "access_token") as! String, q: "q=%40twitterapi&count=4")
					}
				}
			}
			catch (let err) {
				print(err)
			}
		}
	}
	task.resume()
	return tok
}

