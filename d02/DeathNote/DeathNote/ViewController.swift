//
//  ViewController.swift
//  DeathNote
//
//  Created by Kyle BAMPING on 2017/10/05.
//  Copyright © 2017 Kyle BAMPING. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    private var data: [String] = []
    private var names: [String] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        names.append("Garry G. - Heart Attack")
        names.append("Larry L. - Car Accident")
        names.append("Richard R. - Being Awesome")
        
        for (index, value) in names.enumerated() {
            data.append("\(index + 1) - \(value)")
        }
        
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        
        let text = data[indexPath.row]
        
        cell.textLabel?.text = text
        
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueIdenifier" {
//            segue.destination
//        }
//    }

    
}

