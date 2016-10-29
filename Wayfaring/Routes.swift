//
//  Routes.swift
//  Wayfaring
//
//  Copyright (c) 2015年 terut. All rights reserved.
//

import Foundation

open class Routes {
    open static let sharedInstance = Routes()
    fileprivate var routes = [Route]()

    fileprivate init() {}

    open func bootstrap(_ resources: [Resource]) {
        for res in resources {
           routes.append(Route(resource: res))
        }
    }

    open func dispatch(_ urlString: String) -> (resource: Resource?, params: [String: AnyObject]?) {
        if let url = URL(string: urlString) {
            let path = "/\(url.host!)\(url.path)"
            if let route = searchRoute(path) {
                var params = [String: AnyObject]()
                if route.keys.count > 0 {
                    var values = Regex.capture(path, pattern: route.pattern)
                    for (i, key) in route.keys.enumerated() {
                        params[key] = values[i] as AnyObject?
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

    fileprivate func searchRoute(_ path: String) -> Route? {
        for route in self.routes {
            if route.isMatch(path) {
                return route
            }
        }
        return nil
    }

    fileprivate func paramsFromQueryStringAndFragment(_ url: URL) -> [String: AnyObject] {
        var params: [String: AnyObject] = [:]
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if let items = components?.queryItems {
            for item in items {
                if let v = item.value {
                    params[item.name] = v as AnyObject?
                } else {
                    params[item.name] = "" as AnyObject?
                }
            }
        }

        if let fragmentStr = components?.fragment {
            let items = fragmentStr.components(separatedBy: "&")
            if items.count > 0 {
                for item in items {
                    let keyValue = item.components(separatedBy: "=")
                    params[keyValue[0]] = keyValue[1] as AnyObject?
                }
            }
        }

        return params
    }
}
