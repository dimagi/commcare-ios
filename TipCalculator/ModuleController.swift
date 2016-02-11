//
//  ViewController.swift
//  TipCalculator
//
//  Created by Main Account on 9/15/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit
import Foundation

class ModuleController: UIViewController {
    
    var jsonResponseText = "module null"
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = jsonResponseText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func viewTapped(sender : AnyObject) {
        //totalTextField.resignFirstResponder()
    }
    
}

