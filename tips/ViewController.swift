//
//  ViewController.swift
//  tips
//
//  Created by Jeremy Lehman on 12/7/15.
//  Copyright © 2015 Jeremy Lehman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    let defaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        if(defaults.objectForKey("previousMin") != nil) {
            let prevMin = defaults.integerForKey("previousMin")
            let currentDate = NSDateComponents()
            let curMin = currentDate.minute
            if(abs(prevMin - curMin )<10){
                if(defaults.objectForKey("billAmount") != nil) {billField.text = defaults.stringForKey("billAmount")
                    let billAmount = NSString(string:billField.text!).doubleValue
                    let percentages = [0.18,0.22,0.25]
                    let percentage = percentages[tipControl.selectedSegmentIndex]
                    let tip = billAmount * percentage
                    let total = billAmount + tip
                    tipLabel.text = String(format:"%.2f",tip)
                    totalLabel.text = String(format:"%.2f",total)
                }
            }
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var percentages = [0.18,0.22,0.25]
        if(defaults.objectForKey("tipIndex") != nil){
            let index = defaults.integerForKey("tipIndex")
            tipControl.selectedSegmentIndex = index
        
            let percentage = percentages[tipControl.selectedSegmentIndex]
            let billAmount = NSString(string:billField.text!).doubleValue
            let tip = billAmount * percentage
            let total = billAmount + tip
            tipLabel.text = String(format:"$%.2f",tip)
            totalLabel.text = String(format:"$%.2f",total)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        defaults.setObject(billField.text, forKey: "billAmount")
        let date = NSDateComponents()
        defaults.setInteger(date.minute, forKey: "previousMin")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18,0.22,0.25]
        let percentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * percentage
        let total = billAmount + tip
        tipLabel.text = String(format:"$%.2f",tip)
        totalLabel.text = String(format:"$%.2f",total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

 
}

