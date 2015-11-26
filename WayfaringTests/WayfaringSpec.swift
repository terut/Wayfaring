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
    case Ninja, Naruto, Sakura, Sasuke

    static var all: [Resource] {
        return [Ninja, Naruto, Sakura, Sasuke]
    }

    var path: String {
        switch self {
        case .Ninja:
            return "/ninja"
        case .Naruto:
            return "/naruto/:hokage"
        case .Sakura:
            return "/sasuke/:id/suki"
        case .Sasuke:
            return "/uchiha/:id/no/:mono"
        }
    }
}

class WayfaringSpec: QuickSpec {
    override func spec() {
        beforeSuite {
            Routes.sharedInstance.bootstrap(TestResource.all)
        }
        it("/ninja") {
            let route = Route(resource: TestResource.Ninja)
            expect(route.pattern).to(equal("^/ninja$"))
            expect(route.keys).to(equal([]))
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
        it("/ninja") {
            let resourceAndParams = Routes.sharedInstance.dispatch("com.example://ninja?aaa=bbb&ccc=111#d=222&ee=fff")
            let actual1 = resourceAndParams.resource! as? TestResource
            expect(actual1).to(equal(TestResource.Ninja))
            let actual2 = resourceAndParams.params!["aaa"] as? String
            expect(actual2).to(equal("bbb"))
            let actual3 = resourceAndParams.params!["ccc"] as? String
            expect(actual3).to(equal("111"))
            let actual4 = resourceAndParams.params!["d"] as? String
            expect(actual4).to(equal("222"))
            let actual5 = resourceAndParams.params!["ee"] as? String
            expect(actual5).to(equal("fff"))
        }
        it("/naruto/123") {
            let resourceAndParams = Routes.sharedInstance.dispatch("com.example://naruto/123/?aaa=bbb&ccc=111#d=222&ee=fff")
            let actual1 = resourceAndParams.resource! as? TestResource
            expect(actual1).to(equal(TestResource.Naruto))
            let actual2 = resourceAndParams.params!["hokage"] as? String
            expect(actual2).to(equal("123"))
            let actual3 = resourceAndParams.params!["aaa"] as? String
            expect(actual3).to(equal("bbb"))
            let actual4 = resourceAndParams.params!["ccc"] as? String
            expect(actual4).to(equal("111"))
            let actual5 = resourceAndParams.params!["d"] as? String
            expect(actual5).to(equal("222"))
            let actual6 = resourceAndParams.params!["ee"] as? String
            expect(actual6).to(equal("fff"))
        }
        it("/naruto/123/dayo") {
            let resourceAndParams = Routes.sharedInstance.dispatch("com.example://naruto/123/dayo?aaa=bbb&ccc=111")
            let actual1 = resourceAndParams.resource as? TestResource
            expect(actual1).to(beNil())
            let actual2 = resourceAndParams.params?["hokage"] as? String
            expect(actual2).to(beNil())
        }
        it("/sasuke/dai/suki") {
            let resourceAndParams = Routes.sharedInstance.dispatch("com.example://sasuke/dai/suki?aaa=")
            let actual1 = resourceAndParams.resource! as? TestResource
            expect(actual1).to(equal(TestResource.Sakura))
            let actual2 = resourceAndParams.params!["id"] as? String
            expect(actual2).to(equal("dai"))
            let actual3 = resourceAndParams.params!["aaa"] as? String
            expect(actual3).to(equal(""))
        }
        it("/uchiha/123/no/itachi") {
            let resourceAndParams = Routes.sharedInstance.dispatch("com.example://uchiha/123/no/itachi?aaa=bbb&ccc=dd")
            let actual1 = resourceAndParams.resource! as? TestResource
            expect(actual1).to(equal(TestResource.Sasuke))
            let actual2 = resourceAndParams.params!["id"] as? String
            expect(actual2).to(equal("123"))
            let actual3 = resourceAndParams.params!["mono"] as? String
            expect(actual3).to(equal("itachi"))
        }
    }
}
