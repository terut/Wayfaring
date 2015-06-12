//
//  Resource.swift
//  Wayfaring
//
//  Copyright (c) 2015年 terut. All rights reserved.
//

import Foundation

public protocol Resource {
    static var all: [Resource] { get }
    var path: String { get }
}