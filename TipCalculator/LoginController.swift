//
//  ViewController.swift
//  TipCalculator
//
//  Created by Main Account on 9/15/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class LoginController: UIViewController {
  
  @IBOutlet var totalTextField : UITextField!
    
    @IBOutlet var appCode: UITextField!
    @IBOutlet var domainText: UITextField!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
  var jsonResponse = "null"
 
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "loginToMenu") {
            let viewController:ModuleController = segue!.destinationViewController as! ModuleController
            viewController.jsonResponseText = jsonResponse
        }
    }

  override func viewDidLoad() {
    super.viewDidLoad()

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
    let json: [String: AnyObject] = [ "username":user , "password": pass, "domain": domain, "install_reference":code ]
    do{
        postJson("install", jsonBody: json, sender: sender)
        print(json)
    } catch let error as NSError {
        print(error)
    }
  }

  @IBAction func viewTapped(sender : AnyObject) {
    //totalTextField.resignFirstResponder()
  }

    
    func postJson(url: String, jsonBody: [String: AnyObject], sender : AnyObject){
        let postsEndpoint: String = "http://localhost:8080/" + url
        Alamofire.request(.POST, postsEndpoint, parameters: jsonBody, encoding: .JSON)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    // handle the results as JSON, without a bunch of nested if loops
                    let post = JSON(value)
                    self.jsonResponse = post.description
                    print("Response: " + self.jsonResponse)
                    self.performSegueWithIdentifier("loginToMenu", sender: sender)
                }
        }
    }
  
}

