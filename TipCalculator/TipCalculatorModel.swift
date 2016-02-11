//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Main Account on 9/15/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TipCalculatorModel {

  var total: Double
  var taxPct: Double
  var subtotal: Double {
    get {
      return total / (taxPct + 1)
    }
  }
  
  init(total: Double, taxPct: Double) {
    self.total = total
    self.taxPct = taxPct
  }
  
  func calcTipWithTipPct(tipPct: Double) -> Double {
    return subtotal * tipPct
  }
  
  func returnPossibleTips() -> [Int: Double] {
    
    let possibleTipsInferred = [0.15, 0.18, 0.20]
   
    var retval = [Int: Double]()
    for possibleTip in possibleTipsInferred {
      let intPct = Int(possibleTip*100)
      retval[intPct] = calcTipWithTipPct(possibleTip)
    }
    return retval
   
  }
    
    func loginTapped(appcode: String, username: String, password: String, domain: String){
        let json: [String: AnyObject] = [ "username":username , "password": password, "domain": domain, "install_reference":appcode ]
        do{
            //let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            postJson("install", jsonBody: json)
            print(json)
        } catch let error as NSError {
            print(error)
        }
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
    
    func postJson(url: String, jsonBody: [String: AnyObject]){
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
                    print("The post is: " + post.description)
                }
        }
    }
}