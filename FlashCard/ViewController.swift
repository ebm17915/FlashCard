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
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // Adding initial flashcard if needed
        if flashcards.count == 0 {
        updateFlashcard(question: "What is AWS?", answer: "A cloud service provider")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
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
     flipFlashcard()
    }
    
    func flipFlashcard() {
        
         UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
        if(self.Question.isHidden == true)
        {
            self.Question.isHidden = false;
            self.Answer.isHidden = true;
            }
            else {
            self.Question.isHidden = true;
            self.Answer.isHidden = false;
            }
    })
    }
    
    func animateCardOut(toRight: Bool) {
        if(toRight) {
            UIView.animate(withDuration: 0.3, animations: {
                self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
            }, completion: { finished in
                // Update labels
                self.updateLabels()
                
                // Run other animation
                self.animateCardIn(toRight: toRight)
            })
        } else {
            // Start on left side (don't animate this)
            card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
            
            // Animate card going back to original location
            UIView.animate(withDuration: 0.3) {
                self.card.transform = CGAffineTransform.identity
            }
        }
        
    }
    
    
    func animateCardIn(toRight: Bool) {
        if(toRight) {
            // Start on right side (don't animate this)
            card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
            
            // Animate card going back to original location
            UIView.animate(withDuration: 0.3) {
                self.card.transform = CGAffineTransform.identity
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
            }, completion: { finished in
                // Update labels
                self.updateLabels()
                
                // Run other animation
                self.animateCardOut(toRight: toRight)
            })
        }
        
    }

    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
        
        //Animate
        animateCardOut(toRight: true)
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex - 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
        
        //Animate
        animateCardOut(toRight: false)
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
        /// Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            
            // In here we know for sure that we have a dictionary array
            let savedCards = dictionaryArray.map {  dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func saveAllFlashcardsToDisk() {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults!")
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController =  segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
  }
}


