//
//  ViewController.swift
//  TipCalculator
//
//  Created by Main Account on 9/15/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class FormEntryController: UIViewController {
    
    var jsonPrevious = "formentry prev null"
    var jsonNext = "formentry next null"
    var sessionId = "sessionId"
    var formTitle = "title"
    var moduleDictionary: [String:String] = [:]
    var count = 0
    
    @IBOutlet var titleView: UILabel!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var formStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Previous json: " + jsonPrevious)
        if let dataFromString = jsonPrevious.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            sessionId = json["session_id"].stringValue
            formTitle = json["title"].stringValue
            
            print("Form Title: " + formTitle)
            
            for(key, value):(String, JSON) in json["options"] {
                moduleDictionary[key] = value.stringValue
                count++
            }
            
            titleView.text = formTitle
            
        }
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
                    self.jsonNext = post.description
                    print("Next JSON: " + self.jsonNext)
                    self.performSegueWithIdentifier("startFormEntry", sender: sender)
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func viewTapped(sender : AnyObject) {
        //totalTextField.resignFirstResponder()
    }
    
}

