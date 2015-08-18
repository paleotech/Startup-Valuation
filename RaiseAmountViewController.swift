//
//  ValutionCalculationsViewController.swift
//  Valuation1
//
//  Created by Jim Hurst on 7/8/15.
//  Copyright (c) 2015 Stephen Poland. All rights reserved.
//

import Foundation
import UIKit

class RaiseAmountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
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
    
    func stringToNumber(value: String) -> Double {
        var tmp: String = value.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        var tmp2: String = tmp.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        var returnVal = (tmp2 as NSString).doubleValue
        return returnVal
    }
    
    func updateDisplay()
    {
        if ( !textfield1.text.isEmpty )
        {
            var preMoney: Double = stringToNumber(textfield1.text)
            var maxMoney: Double = (preMoney / 2.0)
            var invOwn: Double = maxMoney / (preMoney + maxMoney)
            var maxMoneyString = self.formatToMoney(maxMoney)
    
            textfield2.text = maxMoneyString
            textfield3.text = NSString(format: "%.2f", invOwn * 100.0) as String
        }
    }
    
    @IBAction func ButtonPressed( sender: AnyObject? ) {
        self.updateDisplay()
    }
    
    @IBAction func ClearPressed( sender: AnyObject? ) {
        textfield1.text = ""
        textfield2.text = ""
        textfield3.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield1.delegate = self
        textfield2.delegate = self
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
        // Ramp down the font size so it fits. Even on the 4S.
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.boldSystemFontOfSize(16.0)]
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
            vc.showContent("raise")
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
}