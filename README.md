Reach
==================

A simple class to check for internet connection availability in Swift. Works for both 3G and WiFi connections.


## Install

##### Manually
- Add the _Reach.swift_ file to your project.


## Usage
There are two ways to get network status information from Reach.

1. Call `Reach().connectionStatus()`. The network status is returned in an enum called `ReachabilityStatus`.

```swift
let status = Reach().connectionStatus()

switch status {
case .unknown, .offline:
    print("Not connected")
case .online(.wwan):
    print("Connected via WWAN")
case .online(.wiFi):
    print("Connected via WiFi")
}
```

2. By subscribing to `ReachabilityStatusChangedNotification`s. The network status is returned as a string.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.networkStatusChanged(_:)), name: Notification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
    
    Reach().monitorReachabilityChanges()
}

@objc func networkStatusChanged(_ notification: Notification) {
    if let userInfo = notification.userInfo {
        let status = userInfo["Status"] as! String
        print(status)
    }
    
}
```


## ToDo
- [ ] Return storngly typed object containing more information about the network status.

## Credits

* [Chris Danielson](http://www.chrisdanielson.com/2009/07/22/iphone-network-connectivity-test-example/) is the author of the original code written in Objective-C.
* [Martin R](http://stackoverflow.com/users/1187415/martin-r) from StackOverflow helped me immensely in converting C code to Swift.
