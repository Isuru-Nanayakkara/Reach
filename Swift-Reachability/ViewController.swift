//
//  ViewController.swift
//  Swift-Reachability
//
//  Created by Isuru Nanayakkara on 9/2/14.
//  Copyright (c) 2014 Isuru Nanayakkara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var networkStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func checkButtonPressed(sender: UIButton) {
        
        if Reachability.isConnectedToNetwork() {
            networkStatusLabel.text = "Internet Connection: Available"
            networkStatusLabel.textColor = UIColor.greenColor()
        } else {
            networkStatusLabel.text = "Internet Connection: Unavailable"
            networkStatusLabel.textColor = UIColor.redColor()
        }
    }
    
}

