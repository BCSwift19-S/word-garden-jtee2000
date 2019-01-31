//
//  ViewController.swift
//  Word Garden
//
//  Created by Jason Tee on 1/30/19.
//  Copyright © 2019 Jason Tee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordtoguess = "SWIFT"
    var lettersguessed = ""
    let MaxNumberofWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guesscount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        
    }

    func updateUIAfterGuess() {
        guessLetterField.resignFirstResponder()
        guessLetterField.text = ""
    }
    
    func formatUserGuessLabel() {
        var revealedword = ""
        lettersguessed += guessLetterField.text!
        
        for char in wordtoguess {
            if lettersguessed.contains(char) {
                revealedword += " \(char)"
            } else {
                revealedword += " _"
            }
        }
        revealedword.removeFirst()
        userGuessLabel.text = revealedword
        
    }
    
    func guessALetter() {
        formatUserGuessLabel()
        guesscount+=1
        let currentLetterGuessed = guessLetterField.text!
        
        if !wordtoguess.contains(currentLetterGuessed) {
            wrongGuessesRemaining -= 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        
        let revealedword = userGuessLabel.text!
        //stop game if wrong guesses reamining goes to 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you're all out of guesses. Try Again?"
        } else if !revealedword.contains("_") {
            // You've won the game
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You got it! It took you \(guesscount) guesses to guess the word!"
            
        } else {
            // Update guess count
            let guess = ( guesscount == 1 ? "guess": "guesses" )
            guessCountLabel.text = "You've made \(guesscount) \(guess)"
        }
    }
    
    @IBAction func gussLetterFieldChange(_ sender: UITextField) {
        if let letterGuessed = guessLetterField.text?.last {
            guessLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
            
        } else{
            //disable the button if I don't have a single character
            guessLetterButton.isEnabled = false
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
        
    }
    
    @IBAction func guessButtonPress(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = MaxNumberofWrongGuesses
        lettersguessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've made 0 guesses"
        guesscount = 0
    }
    
}

