//
//  ValutionCalculationsViewController.swift
//  Valuation1
//
//  Created by Jim Hurst on 7/28/15.
//  Copyright (c) 2015 Stephen Poland. All rights reserved.
//

import Foundation
import UIKit

class HelpViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var theWebView: UIWebView!
    @IBOutlet var theTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showContent(theString: NSString)
    {
        // Load in the local html help file.
        let localfilePath = NSBundle.mainBundle().URLForResource(theString as String, withExtension: "html");
        let theRequest = NSURLRequest(URL: localfilePath!);
        theWebView = UIWebView(frame: CGRectMake(0, 60, self.view.bounds.width, self.view.bounds.height))
        theWebView.loadRequest(theRequest);
        self.view.addSubview(theWebView)
        if (theString == "about")
        {
            theTitle.text = "About This Calculator"
        }
    }
}
