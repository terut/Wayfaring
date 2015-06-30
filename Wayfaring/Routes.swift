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
                if route.keys.count > 0 {
                    var params = [String: AnyObject]()
                    var values = Regex.capture(path, pattern: route.pattern)
                    for (i, key) in enumerate(route.keys) {
                        params[key] = values[i]
                    }
                    for (key, val) in paramsFromQueryString(url) {
                        params[key] = val
                    }
                    return (route.resource, params)
                } else {
                    return (route.resource, nil)
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

    private func paramsFromQueryString(url: NSURL) -> [String: AnyObject] {
        var params: [String: AnyObject] = [:]
        let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)
        if let items = components?.queryItems {
            for item in items {
                let i = item as! NSURLQueryItem
                if let v = i.value {
                    params[i.name] = v
                } else {
                    params[i.name] = ""
                }
            }
        }
        return params
    }
}