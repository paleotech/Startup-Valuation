//
//  ValutionCalculationsViewController.swift
//  Valuation1
//
//  Created by Jim Hurst on 7/8/15.
//  Copyright (c) 2015 Stephen Poland. All rights reserved.
//

import Foundation
import UIKit

class CheatSheetViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var pre1: UILabel!
    @IBOutlet weak var pre2: UILabel!
    @IBOutlet weak var pre3: UILabel!
    @IBOutlet weak var pre4: UILabel!
    @IBOutlet weak var pre5: UILabel!
    @IBOutlet weak var pre6: UILabel!
    @IBOutlet weak var pre7: UILabel!
    @IBOutlet weak var pre8: UILabel!
    @IBOutlet weak var pre9: UILabel!
    @IBOutlet weak var pre10: UILabel!
    @IBOutlet weak var post1: UILabel!
    @IBOutlet weak var post2: UILabel!
    @IBOutlet weak var post3: UILabel!
    @IBOutlet weak var post4: UILabel!
    @IBOutlet weak var post5: UILabel!
    @IBOutlet weak var post6: UILabel!
    @IBOutlet weak var post7: UILabel!
    @IBOutlet weak var post8: UILabel!
    @IBOutlet weak var post9: UILabel!
    @IBOutlet weak var post10: UILabel!
    @IBOutlet weak var theButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var kbHeight: CGFloat!
    var lastTextField: UITextField!
    var tapRec = UITapGestureRecognizer()
    
    @IBAction func cancelButtonpressed(sender: UIButton) {
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
            var raiseMoney: Double = stringToNumber(textfield1.text)
            var post: Double = raiseMoney / 0.05;
            var postMoneyString = formatToMoney(post)
            var pre = post - raiseMoney
            var preMoneyString = formatToMoney(pre)
            pre1.text = preMoneyString
            post1.text = postMoneyString
            post = raiseMoney / 0.1
            postMoneyString = formatToMoney(post)
            pre = post - raiseMoney
            preMoneyString = formatToMoney(pre)
            pre2.text = preMoneyString
            post2.text = postMoneyString
            post = raiseMoney / 0.15
            postMoneyString = formatToMoney(post)
            pre = post - raiseMoney
            preMoneyString = formatToMoney(pre)
            pre3.text = preMoneyString
            post3.text = postMoneyString
            post = raiseMoney / 0.2
            postMoneyString = formatToMoney(post)
            pre = post - raiseMoney
            preMoneyString = formatToMoney(pre)
            pre4.text = preMoneyString
            post4.text = postMoneyString
            post = raiseMoney / 0.25
            postMoneyString = formatToMoney(post)
            pre = post - raiseMoney
            preMoneyString = formatToMoney(pre)
            pre5.text = preMoneyString
            post5.text = postMoneyString
            post = raiseMoney / 0.3
            postMoneyString = formatToMoney(post)
            pre = post - raiseMoney
            preMoneyString = formatToMoney(pre)
            pre6.text = preMoneyString
            post6.text = postMoneyString
            post = raiseMoney / 0.35
            postMoneyString = formatToMoney(post)
            pre = post - raiseMoney
            preMoneyString = formatToMoney(pre)
            pre7.text = preMoneyString
            post7.text = postMoneyString
            post = raiseMoney / 0.4
            postMoneyString = formatToMoney(post)
            pre = post - raiseMoney
            preMoneyString = formatToMoney(pre)
            pre8.text = preMoneyString
            post8.text = postMoneyString
            post = raiseMoney / 0.45
            postMoneyString = formatToMoney(post)
            pre = post - raiseMoney
            preMoneyString = formatToMoney(pre)
            pre9.text = preMoneyString
            post9.text = postMoneyString
            post = raiseMoney / 0.5
            postMoneyString = formatToMoney(post)
            pre = post - raiseMoney
            preMoneyString = formatToMoney(pre)
            pre10.text = preMoneyString
            post10.text = postMoneyString
        }
    }
    
    @IBAction func ButtonPressed( sender: AnyObject? ) {
        self.updateDisplay()
    }
    
    @IBAction func ClearPressed( sender: AnyObject? ) {
        pre1.text = ""
        pre2.text = ""
        pre3.text = ""
        pre4.text = ""
        pre5.text = ""
        pre6.text = ""
        pre7.text = ""
        pre8.text = ""
        pre9.text = ""
        pre10.text = ""
        post1.text = ""
        post2.text = ""
        post3.text = ""
        post4.text = ""
        post5.text = ""
        post6.text = ""
        post7.text = ""
        post8.text = ""
        post9.text = ""
        post10.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield1.delegate = self
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
            vc.showContent("cheat")
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
}