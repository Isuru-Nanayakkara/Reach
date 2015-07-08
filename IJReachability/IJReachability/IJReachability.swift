//
//  IJReachability.swift
//  IJReachability
//
//  Created by Isuru Nanayakkara on 1/14/15.
//  Copyright (c) 2015 Appex. All rights reserved.
//

import Foundation
import SystemConfiguration

public enum IJReachabilityType {
    case WWAN,
    WiFi,
    NotConnected
}


struct NetworkStatusConstants  {
    static let kNetworkAvailabilityStatusChangeNotification = "kNetworkAvailabilityStatusChangeNotification"
    static let Status = "Status"
    static let Offline = "Offline"
    static let Online = "Online"
    static let Unknown = "Unknown"
}

/// With thanks to http://stackoverflow.com/questions/25623272/how-to-use-scnetworkreachability-in-swift/25623647#25623647


public class IJReachability {
    
    /**
    :see: Original post - http://www.chrisdanielson.com/2009/07/22/iphone-network-connectivity-test-example/
    */
    public class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = []
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return false
        }
        
        let isReachable = flags.contains(.Reachable)
        let needsConnection = flags.contains(.ConnectionRequired)
        
        return isReachable && !needsConnection
    }
    
    public class func isConnectedToNetworkOfType() -> IJReachabilityType {
        
        
        //MARK: - TODO Check this when I have an actual iOS 9 device.
        if !self.isConnectedToNetwork() {
            return .NotConnected
        }
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return .NotConnected
        }
        
        var flags : SCNetworkReachabilityFlags = []
        
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return .NotConnected
        }
        
        let isReachable = flags.contains(.Reachable)
        let isWWAN = flags.contains(.IsWWAN)
        
        if isReachable && isWWAN {
            return .WWAN
        }
        
        if isReachable && !isWWAN {
            return .WiFi
        }
        
        return .NotConnected
    }
    
    
    
    ///
    /// Usage:
    ///
    /// Setup
    ///
    ///
    ///        NSNotificationCenter.defaultCenter().addObserver(self,
    ///          selector: "networkStatusDidChange:",
    ///          name: NetworkStatusConstants.kNetworkAvailabilityStatusChangeNotification,
    ///          object: nil)
    ///
    ///
    ///        IJReachability.monitorNetworkChanges()
    ///
    /// Callback
    ///
    ///         func networkStatusDidChange(notification: NSNotification) {
    ///             let networkStatus = notification.userInfo?[ NetworkStatusConstants.Status]
    ///             print("\(networkStatus)")
    ///         }
    ///    
    ///
    
    class func monitorNetworkChanges() {
        
        let host = "google.com"
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        let reachability = SCNetworkReachabilityCreateWithName(nil, host)!
        
        SCNetworkReachabilitySetCallback(reachability, { (_, flags, _) in
            
            let status:String?
            
            if !flags.contains(SCNetworkReachabilityFlags.ConnectionRequired) && flags.contains(SCNetworkReachabilityFlags.Reachable) {
                status = NetworkStatusConstants.Online
            } else {
                status =  NetworkStatusConstants.Offline
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName(NetworkStatusConstants.kNetworkAvailabilityStatusChangeNotification,
                object: nil,
                userInfo: [NetworkStatusConstants.Status: status!])
            
        }, &context)
        
        SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetMain(), kCFRunLoopCommonModes)
    }
}