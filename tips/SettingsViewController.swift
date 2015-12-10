//
//  SettingsViewController.swift
//  tips
//
//  Created by Erin Walsh on 12/8/15.
//  Copyright © 2015 Jeremy Lehman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    //initalize variables
    @IBOutlet weak var colorSchemeControl: UISegmentedControl!
    @IBOutlet weak var tipControl: UISegmentedControl!
    //intialize NSUserDefaults for settings
    let defaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //update tip segment control if exists to correct setting
        if(defaults.objectForKey("tipIndex") != nil){
            tipControl.selectedSegmentIndex = defaults.integerForKey("tipIndex")
        }
        //update color scheme segment control if exists to correct setting
        if(defaults.objectForKey("colorIndex") != nil) {
            colorSchemeControl.selectedSegmentIndex = defaults.integerForKey("colorIndex")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        //save default tip and color scheme settings
        super.viewWillDisappear(animated)
        defaults.setInteger(tipControl.selectedSegmentIndex,forKey: "tipIndex")
        defaults.setInteger(colorSchemeControl.selectedSegmentIndex, forKey:"colorIndex")
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
