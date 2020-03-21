//
//  ViewController.swift
//  FlashCard
//
//  Created by Earl on 2/21/20.
//  Copyright © 2020 Earl Madjus. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}
    // Array to hold our flashcards
    var flashcards = [Flashcard]()

    // Current flashcards index
    var currentIndex = 0

class ViewController: UIViewController {

    @IBOutlet weak var Answer: UILabel!
    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateFlashcard(question: "What is AWS?", answer: "A cloud service provider")
    
        
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
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex - 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    func updateLabels() {
    let currentFlashcard = flashcards[currentIndex]
        Question.text = currentFlashcard.question
        Answer.text = currentFlashcard.answer
    }
    
    func updateFlashcard(question: String, answer: String) {
    let flashcard = Flashcard(question: question, answer: answer)
    Question.text = flashcard.question
    Answer.text = flashcard.answer
        
        flashcards.append(flashcard)
        // Console logs
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        // Update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        // Update buttons
        updateNextPrevButtons()
        
        // Update labels
        updateLabels()
    }
    
    func updateNextPrevButtons() {
        // Disable nextButton if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
    func readSavedFlashcards() {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            
            // In here we know for sure that we have a dictionary array
            let savedCards = dictionaryArray.map {  dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController =  segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
  }
}


