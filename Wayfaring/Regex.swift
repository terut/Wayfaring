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
        let regex = try? NSRegularExpression(
            pattern: pattern,
            options: NSRegularExpressionOptions())
        if let matches = regex?.matchesInString(string, options: NSMatchingOptions(), range: NSRange(location: 0, length: string.characters.count)) {
            for match in matches {
                for i in (1 ..< match.numberOfRanges) {
                    let range = match.rangeAtIndex(i)
                    let cap = (string as NSString).substringWithRange(range)
                    captures.append(cap)
                }
            }
        }
        return captures
    }
}
