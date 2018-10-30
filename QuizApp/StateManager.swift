//
//  StateManager.swift
//  QuizApp
//
//  Created by Lucas Dahl on 9/7/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//
// This manages the user defaults and clears them after the quiz

import Foundation

class StateManager {
    
    static var questionIndexKey = "QuestionIndexKey"
    static var numCorrectKey = "NumberCorrectKey"
    
    static func saveState(numCorrect:Int, questionIndex:Int) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(numCorrect, forKey: numCorrectKey)
        defaults.set(questionIndex, forKey: questionIndexKey)
        
    }
    
    static func retrieveValue(key:String) -> Any? {
        
        let defaults = UserDefaults.standard
        
        return defaults.value(forKey: key)
        
    }
    
    static func clearState() {
        
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: questionIndexKey)
        defaults.removeObject(forKey: numCorrectKey)
        
    }
    
}
