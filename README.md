# Wayfaring

Routing library for Swift

### Usage

#### Resource definition

```swift
import Wayfaring

enum AppResource: Resource {
    case First, Second

    // MARK: - Resource
    static var all: [Resource] {
        return [First, Second]
    }

    // MARK: - Resource
    var path: String {
        switch self {
        case .First:
            return "/first"
        case .Second:
            return "/second/:second_id"
        default:
            return ""
        }
    }

    var identifier: String {
        switch self {
        case .First:
            return "firstView"
        case .Second:
            return "secondView"
        }
    }
}
```

#### Load resources

```swift
import Wayfaring

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Routes.sharedInstance.bootstrap(AppResource.all)

        return true
    }
}
```

### URL dispatch

```swift
import Wayfaring

class ViewController: UIViewController {

    func handleURL() {
        let dispatch = Routes.sharedInstance.dispatch("com.example://second/secsec")
        if let resource = dispatch.resource as? AppResource {
            let vc =  self.storyboard!.instantiateViewControllerWithIdentifier(resource.identifier) as! UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
```

### Requirements

- iOS 8.0+
- Xcode 6.3

### Installation

#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is decentralized dependency manager for Cocoa.

```sh
$ vim Cartfile

github "terut/Wayfaring" ~> 0.1

$ carthage update
```

### LICENSE

Wayfaring is released under the MIT license. See MIT-LICENSE for details.
