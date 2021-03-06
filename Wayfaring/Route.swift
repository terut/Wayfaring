//
//  Route.swift
//  Wayfaring
//
//  Copyright (c) 2015年 terut. All rights reserved.
//

import Foundation

public struct Route {
    public var resource: Resource!
    public var pattern: String!
    public var keys: [String]!

    public init(resource: Resource) {
        self.resource = resource
        let patternAndKeys = compile(self.resource.path)
        self.pattern = patternAndKeys.pattern
        self.keys = patternAndKeys.keys
    }

    internal func isMatch(_ path: String) -> Bool {
        if let _ = path.range(of: self.pattern, options: .regularExpression) {
            return true
        }
        return false
    }

    fileprivate func compile(_ path: String) -> (pattern: String, keys: [String]) {
        let corePattern = path.replacingOccurrences(of: ":[^/?#]+", with: "([^/?#]+)", options: NSString.CompareOptions.regularExpression, range: nil)
        let pattern = "^\(corePattern)$"
        let keys = Regex.capture(path, pattern: ":([^/?#]+)")
        return (pattern, keys)
    }
}
