//
//  ValutionCalculationsViewController.swift
//  Valuation1
//
//  Created by Jim Hurst on 7/8/15.
//  Copyright (c) 2015 Stephen Poland. All rights reserved.
//

import Foundation
import UIKit

@objc(StartupValuationViewController) class StartupValuationViewController: UIViewController {
    

    // MARK: view controller life cycle.
    @IBAction func unwindToCalculators(segue: UIStoryboardSegue)
    {
        //self.performSegueWithIdentifier("goToCalculatorMenu", sender: self)
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        //self.performSegueWithIdentifier("goToMainMenu", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: The following methods support the About  popover, which is really just the help screen
    @IBAction func popover(sender: AnyObject) {
        self.performSegueWithIdentifier("showHelp", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if segue.identifier == "showHelp"
        {
            var vc = segue.destinationViewController as! HelpViewController
            vc.showContent("about")
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
}