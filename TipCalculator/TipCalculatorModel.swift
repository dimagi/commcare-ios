//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Main Account on 9/15/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import Foundation

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
    
    func loginTapped(){
        let data = getJSON("http://jsonplaceholder.typicode.com/posts/1")
        print(data)
        let dictData = parseJSON(data)
        print(dictData)
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




}