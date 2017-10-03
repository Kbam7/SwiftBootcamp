//
//  ViewController.swift
//  Supersize Me
//
//  Created by Kyle BAMPING on 2017/10/02.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBAction func mainButton(_ sender: UIButton) {
        mainLabel.text = "Hello World!"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

