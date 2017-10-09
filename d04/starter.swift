//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

//var str = "Hello, playground"
/*
let CUSTOMER_KEY = "09jC7kDa3eNf9LLrjhiD6K1sQ"

let CUSTOMER_SECRET = "EzapmHd82nw2gRX90kNSNBBatFY0G2fPzfPHU5fLotcN3h5hdu"
*/
let CUSTOMER_KEY = "wkk87wCP4WizS59O6v9Hp4ZUn"

let CUSTOMER_SECRET = "BDdXyqoqh1ONUIvQAHWJPbccEgvZrRI7QXI6jeDrrgrdIX6bp0"


let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))

//let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).dataUsingEncoding(NSUTF8StringEncoding))!.base64EncodedStringWithOptions(NSData.Base64EncodingOptions(rawvalue: 0))

let url : NSURL = NSURL(string: "https://api.twitter.com/oauth2/token")!
let request = NSMutableURLRequest(url: url as URL)

request.httpMethod = "POST"
request.setValue("Basic" + BEARER, forHTTPHeaderField: "Authorization")
request.setValue("application/x-www-form-urlencoded:carset=UTF-8", forHTTPHeaderField: "Content-Type")
request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)

let task = URLSession.shared.dataTask(with: request as URLRequest) {// gets run in async thread, when server responds.
	(data, response, error) in
	if let resp = response {
		print(resp)
	}

	if let err = error {
		print(err)
	}
	else if let d = data {
		do {
			if let dic1: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
				print(dic1)
			}
		}
		catch (let err) {
			print(err)
		}
	}
}
task.resume()

PlaygroundPage.current.needsIndefiniteExecution = true
