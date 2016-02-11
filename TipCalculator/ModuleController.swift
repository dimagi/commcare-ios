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

class ModuleController: UIViewController, UITableViewDataSource {
    
    var jsonResponseText = "module null"
    var moduleDictionary: [String:String] = [:]
    var count = 0
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dataFromString = jsonResponseText.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            print ("options")
            print (json["options"])
            print ("sessionid")
            print(json["session_id"])
            for(key, value):(String, JSON) in json["options"] {
                print("key: " + key)
                print(value)
                moduleDictionary[key] = value.stringValue
                count++
            }
            print(count)
            
        }
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        let row = indexPath.row
        let stringRow = String(row)
        label.text = moduleDictionary[stringRow]
        cell.addSubview(label)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func viewTapped(sender : AnyObject) {
        //totalTextField.resignFirstResponder()
    }
    
}

