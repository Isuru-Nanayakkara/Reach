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
    @IBOutlet var networkTypeLabel: UILabel!
    
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
        
        let statusType = Reachability.isConnectedToNetworkOfType()
        switch statusType{
        case .WWAN:
            networkTypeLabel.text = "Connection Type: Mobile"
            networkTypeLabel.textColor = UIColor.yellowColor()
        case .WiFi:
            networkTypeLabel.text = "Connection Type: WiFi"
            networkTypeLabel.textColor = UIColor.greenColor()
            
        case .NotConnected:
            networkTypeLabel.text = "Connection Type: Not connected to the Internet"
            networkTypeLabel.textColor = UIColor.redColor()
        }
        
        
        
    }
    
}

