//
//  ValutionCalculationsViewController.swift
//  Valuation1
//
//  Created by Jim Hurst on 7/8/15.
//  Copyright (c) 2015 Stephen Poland. All rights reserved.
//

import Foundation
import UIKit


class CapTableViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var before1: UITextField!
    @IBOutlet weak var before2: UITextField!
    @IBOutlet weak var before3: UITextField!
    @IBOutlet weak var before4: UITextField!
    @IBOutlet weak var after1: UITextField!
    @IBOutlet weak var after2: UITextField!
    @IBOutlet weak var after3: UITextField!
    @IBOutlet weak var after4: UITextField!
    @IBOutlet weak var dilution1: UITextField!
    @IBOutlet weak var dilution2: UITextField!
    @IBOutlet weak var dilution3: UITextField!
    @IBOutlet weak var dilution4: UITextField!
    @IBOutlet weak var investor1: UITextField!
    @IBOutlet weak var investor2: UITextField!
    @IBOutlet weak var total1: UITextField!
    @IBOutlet weak var total2: UITextField!
    @IBOutlet weak var total3: UITextField!
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var hiddenButton: UIButton!
    
    var kbHeight: CGFloat!

    var lastTextField: UITextField!
    var tapRec = UITapGestureRecognizer()
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersInString:"$,0123456789").invertedSet
        let components = string.componentsSeparatedByCharactersInSet(inverseSet)
        
        let filtered = join("", components)
        return string == filtered
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        self.updateDisplay()
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        lastTextField = textField
        tapRec.addTarget(self, action: "backgroundTap")
        view.addGestureRecognizer(tapRec)
    }

    func backgroundTap() {
        lastTextField.resignFirstResponder()
    }
    
    func formatToMoney(value: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        var decimalMoney: NSString =  formatter.stringFromNumber(round(value))!
        let stringLength = decimalMoney.length
        let substringIndex = stringLength - 3
        return decimalMoney.substringToIndex(advance(0, substringIndex))
    }
    
    func stringToNumber(value: String) -> Double {
        var tmp: String = value.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        var tmp2: String = tmp.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        var returnVal = (tmp2 as NSString).doubleValue
        return returnVal
    }
    
    func updateDisplay()
    {
        var tmp: String = textfield1.text
        var pm: String = textfield2.text

        // The simple part: Calculate Post-Money
        if ( ( !textfield1.text.isEmpty ) && ( !textfield2.text.isEmpty) )
        {
            var preMoney: Double = stringToNumber(textfield1.text)
            var raiseMoney: Double = stringToNumber(textfield2.text)
            var postMoney: Double = preMoney + raiseMoney
            var postMoneyString = self.formatToMoney(postMoney)
            
            textfield3.text = postMoneyString
        
            // The rest of it: calculate Founder and Investor percentages. First, get the percents in numeric form:
            var before1percent: Int = 0
            var before2percent: Int = 0
            var before3percent: Int = 0
            var before4percent: Int = 0
            if !before1.text.isEmpty {
                before1percent = before1.text.toInt()!
            }
            if !before2.text.isEmpty {
                before2percent = before2.text.toInt()!
            }
            if !before3.text.isEmpty {
                before3percent = before3.text.toInt()!
            }
            if !before4.text.isEmpty {
                before4percent = before4.text.toInt()!
            }
            
            let percentTotal: Int = before1percent + before2percent + before3percent + before4percent
            
            // Don't display nonsensical percentages. For this to work, founder percents before investment must add to 100
            if (percentTotal == 100)
            {
                if (before1percent > 0) {
                    var oldEquityTotal = preMoney * Double(before1percent)
                    var newEquityPercent = oldEquityTotal/postMoney
                    var dilution: Double = Double(before1percent) - newEquityPercent
                    after1.text = NSString(format: "%.2f", newEquityPercent) as String
                    dilution1.text = NSString(format: "%.2f", dilution) as String
                }
                if (before2percent > 0) {
                    var oldEquityTotal = preMoney * Double(before2percent)
                    var newEquityPercent = oldEquityTotal/postMoney
                    var dilution: Double = Double(before2percent) - newEquityPercent
                    after2.text = NSString(format: "%.2f", newEquityPercent) as String
                    dilution2.text = NSString(format: "%.2f", dilution) as String
                }
                if (before3percent > 0) {
                    var oldEquityTotal = preMoney * Double(before3percent)
                    var newEquityPercent = oldEquityTotal/postMoney
                    var dilution: Double = Double(before3percent) - newEquityPercent
                    after3.text = NSString(format: "%.2f", newEquityPercent) as String
                    dilution3.text = NSString(format: "%.2f", dilution) as String
                }
                if (before4percent > 0) {
                    var oldEquityTotal = preMoney * Double(before4percent)
                    var newEquityPercent = oldEquityTotal/postMoney
                    var dilution: Double = Double(before4percent) - newEquityPercent
                    after4.text = NSString(format: "%.2f", newEquityPercent) as String
                    dilution4.text = NSString(format: "%.2f", dilution) as String
                }
                
                var oldEquityTotal = preMoney * Double(before4percent)
                var investorEquityPercent = (raiseMoney/postMoney) * 100
                investor1.text = "0"
                investor2.text = NSString(format: "%.2f", investorEquityPercent) as String
                total1.text = "100"
                total2.text = "100"
                total3.text = NSString(format: "%.2f", investorEquityPercent) as String
            }
        }
    }
    
    @IBAction func ButtonPressed( sender: AnyObject? ) {
        self.updateDisplay()
        self.backgroundTap()
    }
    
    @IBAction func ClearPressed( sender: AnyObject? ) {
        textfield1.text = ""
        textfield2.text = ""
        textfield3.text = ""
    }
    
    @IBAction func DonePressed( sender: AnyObject? ) {
        lastTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield1.delegate = self
        textfield2.delegate = self
        before1.delegate = self
        before2.delegate = self
        before3.delegate = self
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: The following methods support the help popover
    @IBAction func popover(sender: AnyObject) {
        self.performSegueWithIdentifier("showHelp", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if segue.identifier == "showHelp"
        {
            var vc = segue.destinationViewController as! HelpViewController
            vc.showContent("captable")
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
}