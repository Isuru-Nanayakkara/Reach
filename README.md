Reach
==================

A simple class to check for internet connection availability in Swift. Works for both 3G and WiFi connections.


## Install

##### [CocoaPods](http://cocoapods.org/) (< v0.36)
- 


##### Manually
- 

## Checking internet connection
``` swift
let status = Reach().connectionStatus()
        switch status {
        case .Unknown, .Offline:
            print("Not connected")
        case .Online(.WWAN):
            print("Connected via WWAN")
        case .Online(.WiFi):
            print("Connected via WiFi")
        }
```

## Delegate Method
``` swift
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("networkStatusChanged:"), name: ReachabilityStatusChangedNotification, object: nil)
        Reach().monitorReachabilityChanges()
    }
    
    func networkStatusChanged(notification: NSNotification) {
        let userInfo = notification.userInfo
        print(userInfo)
    }
```



## Credits

* [Chris Danielson](http://www.chrisdanielson.com/2009/07/22/iphone-network-connectivity-test-example/) is the author of the original code written in Objective-C.
* [Martin R](http://stackoverflow.com/users/1187415/martin-r) from StackOverflow helped me immensely in converting C code to Swift.
