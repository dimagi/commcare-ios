//
//  ViewController.swift
//  CommCare
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class ModuleController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var jsonResponseText = "module null"
    var jsonNext = "next null"
    var sessionId = "sessionId"
    var moduleDictionary: [String:String] = [:]
    var count = 0
    
    @IBOutlet var tableView: UITableView!
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "moduleToForm") {
            let viewController:FormController = segue!.destinationViewController as! FormController
            viewController.jsonPrevious = jsonNext
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dataFromString = jsonResponseText.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            sessionId = json["session_id"].stringValue
            for(key, value):(String, JSON) in json["options"] {
                print("key: " + key)
                print(value)
                moduleDictionary[key] = value.stringValue
                count++
            }
            print(count)
            
        }
        tableView.dataSource = self
        tableView.delegate = self
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Path click: " + String(indexPath.row))
        rowClicked(String(indexPath.row))
    }
    
    func rowClicked(index: String){
        let json: [String: AnyObject] = [ "selection":index, "session_id": sessionId]
        do{
            postJson("menu_select", jsonBody: json, sender: self)
            print(json)
        } catch let error as NSError {
            print(error)
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
                    self.performSegueWithIdentifier("moduleToForm", sender: sender)
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

