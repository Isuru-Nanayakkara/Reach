//
//  ViewController.swift
//  IJReachability
//
//  Created by Isuru Nanayakkara on 1/14/15.
//  Copyright (c) 2015 Appex. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {

    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var connectionTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func networkStatusDidChange(notification: NSNotification) {
        if let networkStatus = notification.userInfo?[ NetworkStatusConstants.Status]{
            print("\(networkStatus)")
        }
        
        checkConnection()
    }
    
    @IBAction func checkButtonTapped(sender: UIButton) {

         checkConnection()
        
    }
    
    
    @IBAction func manualAutoSwitchDidChange(manualSwitch: UISwitch) {
        
        if manualSwitch.on {
            
            NSNotificationCenter.defaultCenter().addObserver(self,
                selector: "networkStatusDidChange:",
                name: NetworkStatusConstants.kNetworkAvailabilityStatusChangeNotification,
                object: nil)
    
            IJReachability.monitorNetworkChanges()
            
        } else {
            
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
    private func checkConnection() {
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
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

