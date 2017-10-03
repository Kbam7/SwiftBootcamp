//
//  ViewController.swift
//  Make some code
//
//  Created by Kyle BAMPING on 2017/10/02.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numberOnScreen:Double = 0
    var currentValue:Double = 0
    
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBAction func numberBtns(_ sender: UIButton) {
        print("Pressed: \(sender.tag - 1)")
        if mainLabel.text == "0" || mainLabel.text == "*" || mainLabel.text == "/"
            || mainLabel.text == "+" || mainLabel.text == "-"{
            mainLabel.text = ""
        }
        mainLabel.text = mainLabel.text! + String(sender.tag - 1)
        numberOnScreen = Double(mainLabel.text!)!
    }
    
    @IBAction func mainButtons(_ sender: UIButton) {
        if sender.tag == 11         // AC
        {
            mainLabel.text = "0"
            print("Pressed: AC")
        }
        else if sender.tag == 13    // NEG
        {
            print("Pressed: NEG")
        }
        else if sender.tag == 14    // DIV
        {
            print("Pressed: DIV")
        }
        else if sender.tag == 15    // MULT
        {
            print("Pressed: MULT")
        }
        else if sender.tag == 16    // SUB
        {
            print("Pressed: SUB")
        }
        else if sender.tag == 17    // ADD
        {
            print("Pressed: ADD-")
        }
        else if sender.tag == 18    // EQUALS
        {
            print("Pressed: EQUALS")
            mainLabel.text = String(currentValue)
        }
    
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

