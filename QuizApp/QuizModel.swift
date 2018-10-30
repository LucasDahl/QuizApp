//
//  QuizModel.swift
//  QuizApp
//
//  Created by Lucas Dahl on 9/2/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    
    func questionsRetrieved(questions:[Question])
    
}

class QuizModel {
    
    var delegate:QuizProtocol?
    
    func getQuestions() {
        
        // Get retrieve data locally
        //getLocalJsonFile()
        
        // You will need a urk to get remote JSON files
        getRemoteJsonFile()
        
    }
    
    func getLocalJsonFile() {
        
        // Get a path to the json file in our app bundle
        let path = Bundle.main.path(forResource: "QuestionData", ofType: ".json")
        
        // Check if path is nil or not
        guard path != nil else {
            print("Error, no JSON file found.")
            return
        }
        
        // Create a URL object from the string path
        let url = URL(fileURLWithPath: path!)
        
         // Decode that data into instances of the Question Struct
        do {
            // Get the sata from that URL
            let data = try Data(contentsOf: url)
            
            // Decode the json data
            let decoder = JSONDecoder()
            let array = try decoder.decode([Question].self, from: data)
            
            // Return the question structs to the view controller
            delegate?.questionsRetrieved(questions: array)
            
        } catch {
            print("Couldnt create data object from file.")
        }
        
        
    }
    
    func getRemoteJsonFile() {
        
        // Get URL object froma s string
        let stringUrl = "https://codewithchris.com/code/QuestionData.json" // You will need a URL to get remote JSON data.
        let url = URL(string: stringUrl)

        guard url != nil else {
            print("Couldnt get a URL object")
            return
        }
        
        // Get a URLSession object
        let session = URLSession.shared
        
        // Get a DataTask object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check for error
            if error == nil && data != nil {
                
                // Create a json decoder
                let decoder = JSONDecoder()
                
                do {
                    
                    // Try to parse the data
                    let array = try decoder.decode([Question].self, from: data!)
                    
                    // Notify the view controller woth results by passing the data back to the main thread
                    DispatchQueue.main.async {
                        
                        self.delegate?.questionsRetrieved(questions: array)
                        
                    }
                    
                } catch {
                    
                    // print error
                    print("Couldn't decode the JSON.")
                    
                }
                
            }
           
        }
        
        // Call resume on the Datatask object
        dataTask.resume()
        
    }
    
}
