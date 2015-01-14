//
//  ViewController.swift
//  IJReachability
//
//  Created by Isuru Nanayakkara on 1/14/15.
//  Copyright (c) 2015 Appex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var connectionTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func checkButtonTapped(sender: UIButton) {
        
        if IJReachability.isConnectedToNetwork() {
            availabilityLabel.text = "Network Connection: Available"
            availabilityLabel.textColor = UIColor.greenColor()
        } else {
            availabilityLabel.text = "Network Connection: Unavailable"
            availabilityLabel.textColor = UIColor.redColor()
        }
        
        let statusType = IJReachability.isConnectedToNetworkOfType()
        switch statusType {
        case .WWAN:
            connectionTypeLabel.text = "Connection Type: Mobile"
            connectionTypeLabel.textColor = UIColor.yellowColor()
        case .WiFi:
            connectionTypeLabel.text = "Connection Type: WiFi"
            connectionTypeLabel.textColor = UIColor.greenColor()
        case .NotConnected:
            connectionTypeLabel.text = "Connection Type: Not connected to the Internet"
            connectionTypeLabel.textColor = UIColor.redColor()
        }
    }
}

