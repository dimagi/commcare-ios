//
//  ViewController.swift
//  CommCare
//
//  Created by Main Account on 9/15/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class SubmitController: UIViewController {
    
    @IBOutlet var submitTextView : UITextView!
    
    var jsonPrevious = "null"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dataFromString = jsonPrevious.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            let output = json["output"]
            submitTextView.text = output.stringValue
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

