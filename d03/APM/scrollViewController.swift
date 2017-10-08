//
//  scrollViewController.swift
//  APM
//
//  Created by Kyle BAMPING on 2017/10/08.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit

class scrollViewController: UIViewController {

	@IBOutlet weak var myScrollView: UIScrollView!
	var image : UIImage!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let imView = UIImageView()
		imView.image = image
		myScrollView.addSubview(imView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
