//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Lucas Dahl on 9/7/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

protocol ResultViewControllerProtocol {
    
    func resultViewDismissed()
    
}

class ResultViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    // Delegate
    var delegate:ResultViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Set rounded corners for the dialog view
        dialogView.layer.cornerRadius = 10
        
        // Set the alpha for the dim view and elements to zero
        dimView.alpha = 0
        resultLabel.alpha = 0
        feedbackLabel.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Sets the dim view alpha back to one, by animating it in.
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            
            self.dimView.alpha = 1
            
        }, completion: nil)
        
    }
    
    func setPopup(withTitle:String, withMessage:String, withAction:String) {
        
        resultLabel.text = withTitle
        feedbackLabel.text = withMessage
        dismissButton.setTitle(withAction, for: .normal)
        
        // Fade in the labels
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            
            self.resultLabel.alpha = 1
            self.feedbackLabel.alpha = 1
            
        }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismissTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            
            self.dimView.alpha = 0
            
        }) { (completed) in
            
            // Only to dismiss after dim view has faded out.
            self.dismiss(animated: true, completion: {
                
                // Clear the labels
                self.resultLabel.text = ""
                self.feedbackLabel.text = ""
                
            })
            
            self.delegate?.resultViewDismissed()
            
        }
        
    }
    

}// End class
