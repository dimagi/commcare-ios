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
    var count = 0
    var questionTree = [Question]()
    
    
    @IBOutlet var titleView: UILabel!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var formStack: UIStackView!
    
    @IBAction func viewTapped(sender : AnyObject) {
        //totalTextField.resignFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "submitForm") {
            let viewController:SubmitController = segue!.destinationViewController as! SubmitController
            viewController.jsonPrevious = jsonNext
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Previous json: " + jsonPrevious)
        if let dataFromString = jsonPrevious.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json = JSON(data: dataFromString)
            sessionId = json["session_id"].stringValue
            formTitle = json["title"].stringValue
            
            for (index,subArrayJson):(String, JSON) in json["tree"] {
                let newQuestion = Question(caption: subArrayJson["caption"].stringValue, ix: subArrayJson["ix"].stringValue, type: subArrayJson["type"].stringValue, datatype: subArrayJson["datatype"].stringValue)
                questionTree.append(newQuestion)
                var questionWidget = QuestionWidget(question: newQuestion, index: count)
                print("Add question: " + String(questionWidget))
                formStack.addSubview(questionWidget)
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
                    self.performSegueWithIdentifier("submitForm", sender: sender)
                }
        }
    }
    
    @IBAction func submitTapped(sender: AnyObject){
        var answers = Dictionary<String, String>()
        for (question):(Question) in questionTree{
            let answer = question.answer
            let ix = question.ix
            if(!(answer == "answer")){
                answers[ix] = answer
            }
        }
        print("Answers")
        print(answers)
        
        let json: [String: AnyObject] = [ "answers":answers, "session_id": sessionId]
        do{
            postJson("submit", jsonBody: json, sender: self)
            print(json)
        } catch let error as NSError {
            print(error)
        }
        
    }
}