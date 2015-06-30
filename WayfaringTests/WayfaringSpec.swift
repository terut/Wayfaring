//
//  WayfaringSpec.swift
//  WayfaringSpec
//
//  Copyright (c) 2015年 terut. All rights reserved.
//

import Quick
import Nimble
import Wayfaring

enum TestResource: Resource {
    case Naruto, Sakura, Sasuke

    static var all: [Resource] {
        return [Naruto, Sakura, Sasuke]
    }

    var path: String {
        switch self {
        case .Naruto:
            return "/naruto/:hokage"
        case .Sakura:
            return "/sasuke/:id/suki"
        case .Sasuke:
            return "/uchiha/:id/no/:mono"
        default:
            return "/"
        }
    }
}

class WayfaringSpec: QuickSpec {
    override func spec() {
        beforeSuite {
            Routes.sharedInstance.bootstrap(TestResource.all)
        }
        it("/naruto/:hokage") {
            let route = Route(resource: TestResource.Naruto)
            expect(route.pattern).to(equal("^/naruto/([^/?#]+)$"))
            expect(route.keys).to(equal(["hokage"]))
        }
        it("/sasuke/:id/suki") {
            let route = Route(resource: TestResource.Sakura)
            expect(route.pattern).to(equal("^/sasuke/([^/?#]+)/suki$"))
            expect(route.keys).to(equal(["id"]))
        }
        it("/uchiha/:id/no/:mono") {
            let route = Route(resource: TestResource.Sasuke)
            expect(route.pattern).to(equal("^/uchiha/([^/?#]+)/no/([^/?#]+)$"))
            expect(route.keys).to(equal(["id", "mono"]))
        }
        it("/naruto/123") {
            let resourceAndParams = Routes.sharedInstance.dispatch("com.example://naruto/123/?aaa=bbb&ccc=111")
            var actual1 = resourceAndParams.resource! as? TestResource
            expect(actual1).to(equal(TestResource.Naruto))
            var actual2 = resourceAndParams.params!["hokage"] as? String
            expect(actual2).to(equal("123"))
            var actual3 = resourceAndParams.params!["aaa"] as? String
            expect(actual3).to(equal("bbb"))
            var actual4 = resourceAndParams.params!["ccc"] as? String
            expect(actual4).to(equal("111"))
        }
        it("/naruto/123/dayo") {
            let resourceAndParams = Routes.sharedInstance.dispatch("com.example://naruto/123/dayo?aaa=bbb&ccc=111")
            var actual1 = resourceAndParams.resource as? TestResource
            expect(actual1).to(beNil())
            var actual2 = resourceAndParams.params?["hokage"] as? String
            expect(actual2).to(beNil())
        }
        it("/sasuke/dai/suki") {
            let resourceAndParams = Routes.sharedInstance.dispatch("com.example://sasuke/dai/suki?aaa=")
            var actual1 = resourceAndParams.resource! as? TestResource
            expect(actual1).to(equal(TestResource.Sakura))
            var actual2 = resourceAndParams.params!["id"] as? String
            expect(actual2).to(equal("dai"))
            var actual3 = resourceAndParams.params!["aaa"] as? String
            expect(actual3).to(equal(""))
        }
        it("/uchiha/123/no/itachi") {
            let resourceAndParams = Routes.sharedInstance.dispatch("com.example://uchiha/123/no/itachi?aaa=bbb&ccc=dd")
            var actual1 = resourceAndParams.resource! as? TestResource
            expect(actual1).to(equal(TestResource.Sasuke))
            var actual2 = resourceAndParams.params!["id"] as? String
            expect(actual2).to(equal("123"))
            var actual3 = resourceAndParams.params!["mono"] as? String
            expect(actual3).to(equal("itachi"))
        }
    }
}
