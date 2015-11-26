//
//  Routes.swift
//  Wayfaring
//
//  Copyright (c) 2015年 terut. All rights reserved.
//

import Foundation

public class Routes {
    public static let sharedInstance = Routes()
    private var routes = [Route]()

    private init() {}

    public func bootstrap(resources: [Resource]) {
        for res in resources {
           routes.append(Route(resource: res))
        }
    }

    public func dispatch(urlString: String) -> (resource: Resource?, params: [String: AnyObject]?) {
        if let url = NSURL(string: urlString) {
            let path = "/\(url.host!)\(url.path!)"
            if let route = searchRoute(path) {
                var params = [String: AnyObject]()
                if route.keys.count > 0 {
                    var values = Regex.capture(path, pattern: route.pattern)
                    for (i, key) in route.keys.enumerate() {
                        params[key] = values[i]
                    }
                }
                for (key, val) in paramsFromQueryStringAndFragment(url) {
                    params[key] = val
                }
                if params.isEmpty {
                    return (route.resource, nil)
                } else {
                    return (route.resource, params)
                }
            }
        }
        return (nil, nil)
    }

    private func searchRoute(path: String) -> Route? {
        for route in self.routes {
            if route.isMatch(path) {
                return route
            }
        }
        return nil
    }

    private func paramsFromQueryStringAndFragment(url: NSURL) -> [String: AnyObject] {
        var params: [String: AnyObject] = [:]
        let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)
        if let items = components?.queryItems {
            for item in items {
                if let v = item.value {
                    params[item.name] = v
                } else {
                    params[item.name] = ""
                }
            }
        }

        if let fragmentStr = components?.fragment {
            let items = fragmentStr.componentsSeparatedByString("&")
            if items.count > 0 {
                for item in items {
                    let keyValue = item.componentsSeparatedByString("=")
                    params[keyValue[0]] = keyValue[1]
                }
            }
        }

        return params
    }
}