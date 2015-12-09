//
//  SettingsViewController.swift
//  tips
//
//  Created by Erin Walsh on 12/8/15.
//  Copyright © 2015 Jeremy Lehman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        if(defaults.objectForKey("tipIndex") != nil){
            tipControl.selectedSegmentIndex = defaults.integerForKey("tipIndex")
        }
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex,forKey: "tipIndex")
        defaults.synchronize()
        
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
