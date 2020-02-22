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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Question.isHidden = false
        Answer.isHidden = true
       
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(Question.isHidden)
        {
            Question.isHidden = false;
            Answer.isHidden = true;
        }
            
        else if (Question.isHidden) {  Question.isHidden = true;
            Answer.isHidden = false;
            
        }
    }
    



}

