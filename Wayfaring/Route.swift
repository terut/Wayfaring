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

    internal func isMatch(path: String) -> Bool {
        if let match = path.rangeOfString(self.pattern, options: .RegularExpressionSearch) {
            return true
        }
        return false
    }

    private func compile(path: String) -> (pattern: String, keys: [String]) {
        let corePattern = path.stringByReplacingOccurrencesOfString(":[^/?#]+", withString: "([^/?#]+)", options: NSStringCompareOptions.RegularExpressionSearch, range: nil)
        var pattern = "^\(corePattern)$"
        var keys = Regex.capture(path, pattern: ":([^/?#]+)")
        return (pattern, keys)
    }
}