//
//  ViewController.swift
//  Word Garden
//
//  Created by Yinzhe Ma on 9/15/19.
//  Copyright © 2019 Yinzhe Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordToGuess=""
    var lettersGuessed=""
    let maxNumberOfWrongGuesses=8
    var wrongGuessesRemaining=8
    var guessCount=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let words = ["SWIFT",
                     "CODE",
                     "COMPUTER",
                     "SCIENCE",
                     "TECHNOLOGY",
                     "LACROSSE",
                     "NERD",
                     "FUN",
                     "BOSTON",
                     "FUTURE",
                     "HAPPY",
                     "SMART",
                     "AWESOME",
                     "FLOWER",
                     "GARDEN",
                     "COLLEGE",
                     "BEST"]
        wordToGuess=words.randomElement()!
        formatUserGuessLabel()
        guessLetterButton.isEnabled=false
        playAgainButton.isHidden=true
        // Do any additional setup after loading the view.
    }
    
    func formatUserGuessLabel(){
        var revealedWord=""
        lettersGuessed=lettersGuessed+guessedLetterField.text!
        for letter in wordToGuess{
            if lettersGuessed.contains(letter){
                revealedWord=revealedWord+" \(letter)"
            }else{
                revealedWord=revealedWord+" _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text=revealedWord
    }
    
    func guessALetter(){
        formatUserGuessLabel()
        guessCount+=1
        //decrements the wrongGuessesRemaining and shows the next flower image with one less pedal
        let currentLetterGuessed=guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed){
            wrongGuessesRemaining=wrongGuessesRemaining-1
            flowerImageView.image=UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        if wrongGuessesRemaining==0{
            playAgainButton.isHidden=false
            guessedLetterField.isEnabled=false
            guessLetterButton.isEnabled=false
            guessCountLabel.text="So sorry, you're all out of guesses. Try again?"
        } else if !userGuessLabel.text!.contains("_"){
            playAgainButton.isHidden=false
            guessedLetterField.isEnabled=false
            guessLetterButton.isEnabled=false
            guessCountLabel.text="Congratulations! You've Won A Game! It took you \(guessCount) times"
        } else{
            var guess="Guesses"
            //let guess=(guessCount==1? "guess":"guesses")
            if (guessCount==1)||(guessCount==0){
                guess="Guess"
            }
            guessCountLabel.text="You've Made \(guessCount) \(guess)"
        }
        
    }
    
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text=""
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last{
            guessedLetterField.text=String(letterGuessed)
            guessLetterButton.isEnabled=true
        } else{
            guessLetterButton.isEnabled=false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        let words = ["SWIFT",
                     "CODE",
                     "COMPUTER",
                     "SCIENCE",
                     "TECHNOLOGY",
                     "LACROSSE",
                     "NERD",
                     "FUN",
                     "BOSTON",
                     "FUTURE",
                     "HAPPY",
                     "SMART",
                     "AWESOME",
                     "FLOWER",
                     "GARDEN",
                     "COLLEGE",
                     "BEST"]
        wordToGuess=words.randomElement()!
        playAgainButton.isHidden=true
        guessedLetterField.isEnabled=true
        guessLetterButton.isEnabled=false
        flowerImageView.image=UIImage(named: "flower8")
        wrongGuessesRemaining=maxNumberOfWrongGuesses
        lettersGuessed=""
        formatUserGuessLabel()
        guessCountLabel.text="You've Made 0 Guess"
        guessCount=0
    }
    
}

