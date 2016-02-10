//
//  ViewController.swift
//  TipCalculator
//
//  Created by Main Account on 9/15/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var totalTextField : UITextField!
    
    @IBOutlet var appCode: UITextField!
    @IBOutlet var domainText: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
  let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
 
  func refreshUI() {
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    refreshUI()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func loginTapped(sender : AnyObject) {
    let user = username.text!
    let pass = password.text!
    let code = appCode.text!
    let domain = domainText.text!
    tipCalc.loginTapped(code, username: user, password:pass, domain:domain)
  }

  @IBAction func viewTapped(sender : AnyObject) {
    //totalTextField.resignFirstResponder()
  }
  
}

