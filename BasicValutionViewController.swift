//
//  ValutionCalculationsViewController.swift
//  Valuation1
//
//  Created by Jim Hurst on 7/8/15.
//  Copyright (c) 2015 Stephen Poland. All rights reserved.
//

import Foundation
import UIKit

class BasicValuationViewController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    var vc: HelpViewController!
    
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
        self.updateDisplay(textField)
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
    
    func updateDisplay(textField: AnyObject)
    {
        if ( ( !textfield.text.isEmpty ) && ( !textfield2.text.isEmpty) )
        {
            let tmp: String = (textfield.text as NSString) as String
            let tmp2: String = tmp.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            let tmp3: String = tmp2.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var preMoney = tmp3.toInt()
            let inv: String = (textfield2.text as NSString) as String
            let inv2: String = inv.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            let inv3 = inv2.stringByReplacingOccurrencesOfString("$", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            var invAmount = inv3.toInt()
            var total = preMoney! + invAmount!
            textfield3.text = String(total)
        }
    }
    
    func animateTextField(up: Bool) {
        var movement = (up ? -kbHeight : kbHeight)
        
        UIView.animateWithDuration(0.3, animations: {
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
    
    @IBAction func ButtonPressed( sender: AnyObject? ) {
        self.updateDisplay(sender!)
    }
    
    @IBAction func HelpPressed( sender: AnyObject? ) {
        textfield.text = ""
        textfield2.text = ""
        textfield3.text = ""
    }
    
    @IBAction func ClearPressed( sender: AnyObject? ) {
        textfield.text = ""
        textfield2.text = ""
        textfield3.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.delegate = self
        textfield2.delegate = self
        textfield3.delegate = self
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    // MARK: The following methods support the help popover
    @IBAction func popover(sender: AnyObject) {
        self.performSegueWithIdentifier("showHelp", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if segue.identifier == "showHelp"
        {
            vc = segue.destinationViewController as! HelpViewController
            vc.showContent("basic")
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
}