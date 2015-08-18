//
//  ValutionCalculationsViewController.swift
//  Valuation1
//
//  Created by Jim Hurst on 7/8/15.
//  Copyright (c) 2015 Stephen Poland. All rights reserved.
//

import Foundation
import UIKit

class ImpliedValuation2ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
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
    
    func updateDisplay()
    {
        var tmp: String = textfield1.text
        var pm: String = textfield2.text
        if ( ( !textfield1.text.isEmpty ) && ( !textfield2.text.isEmpty) )
        {
            var tmp2: String = tmp.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var tmp3: String = tmp2.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var inv = (tmp3 as NSString).doubleValue
            
            var pm2: String = pm.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var pm3 = pm2.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var premoney = (pm3 as NSString).doubleValue
            var post = inv + premoney
            var invPercent = (inv/post) * 100.0
            
            textfield3.text = self.formatToMoney(post)
            textfield4.text =  NSString(format: "%.2f %", invPercent) as String
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
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield1.delegate = self
        textfield2.delegate = self
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
            vc.showContent("implieddil")
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }

}