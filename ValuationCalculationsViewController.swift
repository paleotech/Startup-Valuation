//
//  ValutionCalculationsViewController.swift
//  Valuation1
//
//  Created by Jim Hurst on 7/8/15.
//  Copyright (c) 2015 Stephen Poland. All rights reserved.
//

import Foundation
import UIKit

class ValuationCalculationsViewController: UITableViewController {
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func unwindToCalculators(segue: UIStoryboardSegue)
    {
        //self.performSegueWithIdentifier("goToCalculatorMenu", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view,
        // typically from a nib.
    }
}