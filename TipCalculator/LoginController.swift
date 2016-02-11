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
    
    
  let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    
  var jsonResponse = "null"
 
  func refreshUI() {
  }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "loginToMenu") {
            let viewController:ModuleController = segue!.destinationViewController as! ModuleController
            viewController.jsonResponseText = jsonResponse
        }
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
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary?{
        var _: NSError?
        do{
            let boardsDictionary: NSDictionary = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            return boardsDictionary
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
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

