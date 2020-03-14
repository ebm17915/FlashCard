//
//  ViewController.swift
//  FlashCard
//
//  Created by Earl on 2/21/20.
//  Copyright © 2020 Earl Madjus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Answer: UILabel!
    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cards
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.5
       
        //Question
        Question.clipsToBounds = true
        Question.layer.cornerRadius = 20.0
        Question.layer.shadowRadius = 15.0
        Question.layer.shadowOpacity = 0.5
        
        //Answer
        Answer.clipsToBounds = true
        Answer.layer.cornerRadius = 20.0
        Answer.layer.shadowRadius = 15.0
        Answer.layer.shadowOpacity = 0.5
        
        // Button 1
        btnOptionOne.layer.cornerRadius = 15.0
        btnOptionOne.layer.borderWidth = 3
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.7774125934, alpha: 1)
        
        // Button 2
        btnOptionTwo.layer.cornerRadius = 15.0
        btnOptionTwo.layer.borderWidth = 3
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.7774125934, alpha: 1)
        
        // Button 3
    
        btnOptionThree.layer.cornerRadius
        = 15.0
        btnOptionThree.layer.borderWidth = 3
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0, green: 1, blue: 0.7774125934, alpha: 1)
        
        
        Question.isHidden = false
        Answer.isHidden = true
       
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(Question.isHidden == true)
        {
            Question.isHidden = false;
            Answer.isHidden = true;
        }
        else {
            Question.isHidden = true;
            Answer.isHidden = false;
        }
    }
    
    func updateFlashcard(question: String, answer: String){
    Question.text = question
    Answer.text = answer
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController =  segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
}

