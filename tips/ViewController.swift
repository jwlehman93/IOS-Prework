//
//  ViewController.swift
//  tips
//
//  Created by Jeremy Lehman on 12/7/15.
//  Copyright © 2015 Jeremy Lehman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //initialize all view components
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var sumBar: UIView!
    @IBOutlet weak var tipStatic: UILabel!
    @IBOutlet weak var totalStatic: UILabel!
    //initialize NSUser defaults for settings
    let defaults = NSUserDefaults.standardUserDefaults()
    var currencySymbol = NSLocale.currentLocale().objectForKey(NSLocaleCurrencySymbol) as! String
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //set intial tip and total labels to $0
        tipLabel.text = "\(currencySymbol)0.00"
        totalLabel.text = "\(currencySymbol)0.00"
        /*check if time from previous close exists
          if so, checks if it has been greater than 
          10 mins and if not sets bill amount to
          saved amount if exists and updates tip and
          total label
        */if(defaults.objectForKey("previousMin") != nil) {
            let prevMin = defaults.integerForKey("previousMin")
            let currentDate = NSDateComponents()
            let curMin = currentDate.minute
            billField.placeholder = currencySymbol
            if(abs(prevMin - curMin )<10){
                if(defaults.objectForKey("billAmount") != nil) {billField.text = defaults.stringForKey("billAmount")
                }
            }
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var percentages = [0.18,0.22,0.25]
        /* check if default tip Percentage has been set
            if set, changes selected segment in main view
            and updates tip and total labels
        */
        if(defaults.objectForKey("tipIndex") != nil){
            let index = defaults.integerForKey("tipIndex")
            tipControl.selectedSegmentIndex = index
        
            let percentage = percentages[tipControl.selectedSegmentIndex]
            let billAmount = NSString(string:billField.text!).doubleValue
            let tip = billAmount * percentage
            let total = billAmount + tip
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            let tipStr = formatter.stringFromNumber(tip)
            let totalStr = formatter.stringFromNumber(total)
            
            tipLabel.text = tipStr!
            totalLabel.text = totalStr!

        }
        /*check if index for color scheme exists
           then implement color scheme
        */
        if(defaults.objectForKey("colorIndex") != nil) {
            let color = defaults.integerForKey("colorIndex")
            setColors(color)
        }
    }
    override func viewWillDisappear(animated: Bool) {
        //saves bill amount and time of close
        super.viewWillDisappear(animated)
        defaults.setObject(billField.text, forKey: "billAmount")
        let date = NSDateComponents()
        defaults.setInteger(date.minute, forKey: "previousMin")
        defaults.synchronize()
    }

    func setColors(colorIndex : Int) {
        if(colorIndex == 1) {
            view.backgroundColor = UIColor.blackColor()
            // set all text colors to green
            billField.textColor = UIColor.greenColor()
            tipLabel.textColor = UIColor.greenColor()
            totalLabel.textColor = UIColor.greenColor()
            tipStatic.textColor = UIColor.greenColor()
            totalStatic.textColor = UIColor.greenColor()
            billField.backgroundColor = UIColor.darkGrayColor()
            tipControl.backgroundColor = UIColor.darkGrayColor()
            tipControl.tintColor = UIColor.greenColor()
            sumBar.backgroundColor = UIColor.greenColor()
        }
        else if(colorIndex == 0) {
            view.backgroundColor = UIColor.whiteColor()
            billField.textColor = UIColor.blackColor()
            tipLabel.textColor = UIColor.blackColor()
            tipStatic.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            totalStatic.textColor = UIColor.blackColor()
            billField.backgroundColor = UIColor.clearColor()
            tipControl.backgroundColor = UIColor.whiteColor()
            tipControl.tintColor = UIColor.blueColor()
            sumBar.backgroundColor = UIColor.blackColor()
        }
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        /*updates text field and tip and total labels as things are typed into it. Also formats values for current locale
        */
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        var tipPercentages = [0.18,0.22,0.25]
        let percentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * percentage
        let total = billAmount + tip
        
        let tipStr = formatter.stringFromNumber(tip)
        let totalStr = formatter.stringFromNumber(total)
        
        tipLabel.text = tipStr!
        totalLabel.text = totalStr!
    }
    
    @IBAction func onTap(sender: AnyObject) {
        //push keyboard down when screen is click?d
        view.endEditing(true)
        currencySymbol = NSLocale.currentLocale().objectForKey(NSLocaleCurrencySymbol) as! String
        billField.placeholder = currencySymbol
    }

 
}

