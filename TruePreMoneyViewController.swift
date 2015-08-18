//
//  ValutionCalculationsViewController.swift
//  Valuation1
//
//  Created by Jim Hurst on 7/8/15.
//  Copyright (c) 2015 Stephen Poland. All rights reserved.
//

import UIKit
import Foundation

class TruePreMoneyViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
    @IBOutlet weak var textfield5: UITextField!
    @IBOutlet weak var textfield6: UITextField!
    @IBOutlet weak var textfield7: UITextField!
    @IBOutlet weak var textfield8: UITextField!
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var kbHeight: CGFloat!
    var lastTextField: UITextField!
    var tapRec = UITapGestureRecognizer()
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
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
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        lastTextField = textField
        tapRec.addTarget(self, action: "backgroundTap")
        view.addGestureRecognizer(tapRec)
    }
    
    func backgroundTap() {
        lastTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        self.updateDisplay()
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
        if ( ( !textfield1.text.isEmpty ) && ( !textfield2.text.isEmpty ) )
        {
            var preMoney: Double = stringToNumber(textfield1.text)
            var invAmt: Double = stringToNumber(textfield2.text)
            var postMoney: Double = (preMoney + invAmt)
            var preMoneyString = self.formatToMoney(preMoney)
            
            textfield3.text = self.formatToMoney(postMoney)
            if (!textfield4.text.isEmpty )
            {
                var optionPoolFraction: Double = stringToNumber(textfield4.text) * 0.01
                var optionPoolValue: Double = preMoney * optionPoolFraction
                textfield5.text = NSString(format: "%@%", textfield4.text) as String
                textfield6.text = preMoneyString
                textfield7.text = self.formatToMoney(optionPoolValue)
                textfield8.text = self.formatToMoney(preMoney - optionPoolValue)
            }
        }
    }
    
    @IBAction func ButtonPressed( sender: AnyObject? ) {
        self.updateDisplay()
    }
    
    @IBAction func ClearPressed( sender: AnyObject? ) {
        textfield1.text = ""
        textfield2.text = ""
        textfield3.text = ""
        textfield4.text = ""
        textfield5.text = ""
        textfield6.text = ""
        textfield7.text = ""
        textfield8.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield1.delegate = self
        textfield2.delegate = self
        textfield4.delegate = self
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
            vc.showContent("true")
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
}