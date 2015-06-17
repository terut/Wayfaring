//
//  ViewController.swift
//  Example
//  Copyright (c) 2015年 terut. All rights reserved.
//

import UIKit
import Wayfaring

class ViewController: UIViewController {
    var targetURL: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        handleURL()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleURL() {
        let dispatch = Routes.sharedInstance.dispatch(self.targetURL)
        if let resource = dispatch.resource as? AppResource {
            let vc =  self.storyboard!.instantiateViewControllerWithIdentifier(resource.identifier) as! UIViewController
            if resource == AppResource.Second {
                (vc as! SecondViewController).params = dispatch.params!
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
