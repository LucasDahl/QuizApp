//
//  Question.swift
//  QuizApp
//
//  Created by Lucas Dahl on 9/2/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

struct Question: Codable {
    
    var question:String?
    var answers:[String]?
    var correctAnswerIndex:Int?
    var feedback:String?
    
}
