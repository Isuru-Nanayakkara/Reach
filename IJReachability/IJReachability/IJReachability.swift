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

public class IJReachability {
    
    /**
    :see: Original post - http://www.chrisdanielson.com/2009/07/22/iphone-network-connectivity-test-example/
    */
    public class func isConnectedToNetwork() -> Bool {
        
        var Status:Bool = false
        let url = NSURL(string: "https://google.com/")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response: NSURLResponse?
        
        _ = (try? NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)) as NSData?
        
        if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
        }
        
        return Status
    }
    
    public class func isConnectedToNetworkOfType() -> IJReachabilityType {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return .NotConnected
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            return .NotConnected
        }
        
        let isReachable = flags.contains(.Reachable)
        let isWWAN = (flags.intersect(SCNetworkReachabilityFlags.IsWWAN)) != []

        if(isReachable && isWWAN){
            return .WWAN
        }
        if(isReachable && !isWWAN){
            return .WiFi
        }
        
        return .NotConnected

    }
    
}
