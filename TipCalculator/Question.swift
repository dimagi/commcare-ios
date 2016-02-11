//
//  Question.swift
//  CommCare
//
//  Created by Will Pride on 2/11/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation

class Question {
    var caption = "caption"
    var answer = "answer"
    var ix = "ix"
    var type = "type"
    var datatype = "datatype"
    
    var description: String {
        return "Caption: \(caption)"
    }
    
    init(){
        
    }
    
    init(caption: String, ix: String, type: String, datatype: String){
        self.caption = caption
        self.ix = ix
        self.type = type
        self.datatype = datatype
    }
}