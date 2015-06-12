//
//  Regex.swift
//  Wayfaring
//
//  Copyright (c) 2015年 terut. All rights reserved.
//

import Foundation

class Regex {
    internal static func capture(string: String, pattern: String) -> [String] {
        var captures = [String]()
        let regex = NSRegularExpression(
            pattern: pattern,
            options: NSRegularExpressionOptions.allZeros,
            error: nil)
        if let matches = regex?.matchesInString(string, options: NSMatchingOptions.allZeros, range: NSRange(location: 0, length: count(string))) {
            for match in matches as! [NSTextCheckingResult] {
                for var i = 1; i < match.numberOfRanges; ++i {
                    let range = match.rangeAtIndex(i)
                    let cap = (string as NSString).substringWithRange(range)
                    captures.append(cap)
                }
            }
        }
        return captures
    }
}
