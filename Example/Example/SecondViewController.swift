//
//  SecondViewController.swift
//  Example
//  Copyright (c) 2015年 terut. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var paramsLabel: UILabel!
    var params: [String: AnyObject]!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.paramsLabel.text = "Params: \(self.params)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
