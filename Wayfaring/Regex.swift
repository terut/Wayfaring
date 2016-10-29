//
//  Regex.swift
//  Wayfaring
//
//  Copyright (c) 2015年 terut. All rights reserved.
//

import Foundation

class Regex {
    internal static func capture(_ string: String, pattern: String) -> [String] {
        var captures = [String]()
        let regex = try? NSRegularExpression(
            pattern: pattern,
            options: NSRegularExpression.Options())
        if let matches = regex?.matches(in: string, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: string.characters.count)) {
            for match in matches {
                for i in (1 ..< match.numberOfRanges) {
                    let range = match.rangeAt(i)
                    let cap = (string as NSString).substring(with: range)
                    captures.append(cap)
                }
            }
        }
        return captures
    }
}
