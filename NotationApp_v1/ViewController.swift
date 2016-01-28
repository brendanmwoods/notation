//
//  ViewController.swift
//  NotationApp_v1
//
//  Created by brendan woods on 2016-01-19.
//  Copyright © 2016 brendan woods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var noteImage:UIImageView?
    @IBOutlet weak var resultImage:UIImageView?
    @IBOutlet weak var correctResulDisplay:UILabel?
    @IBOutlet weak var totalResultDisplay:UILabel?
    @IBOutlet weak var resultsPercentage:UILabel?
    
    var nextRandomNoteInt = 0
    var currentNote = 0
    var correctCount = 0
    var incorrectCount = 0
    var skipCount = 0
    var difficulty = ""
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNextNoteImage()
        
        //create a note library, populate it with all 88 notes,
        //   and then filter based on difficulty
        let notes = NoteLibrary()
        notes.fillNoteLibrary()
        notes.filterNotesForDifficulty(difficulty)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pickRandomNote() -> Int {
        let noteInt = Int(arc4random_uniform(7) + 1)
        return noteInt
    }
    
    
    @IBAction func displayNextNoteImage(sender:UIButton) {
        skipCount++
        displayNextNoteImage()
    }
    
    func displayNextNoteImage() {
        
    nextRandomNoteInt = pickRandomNote()
        while(nextRandomNoteInt == currentNote) {
            nextRandomNoteInt = pickRandomNote()
        }
        
    switch nextRandomNoteInt {
    case 1:
    noteImage?.image = UIImage(named: "C.png")
    case 2:
    noteImage?.image = UIImage(named: "D.png")
    case 3:
    noteImage?.image = UIImage(named: "E.png")
    case 4:
    noteImage?.image = UIImage(named: "F.png")
    case 5:
    noteImage?.image = UIImage(named: "G.png")
    case 6:
    noteImage?.image = UIImage(named: "A.png")
    case 7:
    noteImage?.image = UIImage(named: "B.png")
    default :
        print("got to default case")
    }
    currentNote = nextRandomNoteInt
    }

    
    
    @IBAction func noteButtonPushed(sender:UIButton) {
        checkIfNote(sender.titleLabel!.text!)
    }
    
    func checkIfNote(note:String) {
        var guessedCorrect = false
        
        if currentNote == 1 {
            if note == "C" {
                guessedCorrect = true
                displayCorrect()
            }
        }
        
        if currentNote == 2 {
            if note == "D" {
                guessedCorrect = true
                displayCorrect()
            }
        }

        if currentNote == 3 {
            if note == "E" {
                guessedCorrect = true
                displayCorrect()
            }
        }

        if currentNote == 4 {
            if note == "F" {
                guessedCorrect = true
                displayCorrect()
            }
        }

        if currentNote == 5 {
            if note == "G" {
                guessedCorrect = true
                displayCorrect()
            }
        }

        if currentNote == 6 {
            if note == "A" {
                guessedCorrect = true
                displayCorrect()
            }
        }

        if currentNote == 7 {
            if note == "B" {
                guessedCorrect = true
                displayCorrect()
            }
        }
        if !guessedCorrect {
            displayIncorrect()
        }
    }
    
    func displayCorrect() {
        correctCount++
        correctResulDisplay?.text = String(correctCount)
        totalResultDisplay?.text = String(correctCount + incorrectCount)
        updateResultPercentage()
        displayCorrectResultImage()
        displayNextNoteImage()
    }
    
    func displayIncorrect() {
        incorrectCount++
        totalResultDisplay?.text = String(correctCount + incorrectCount)
        updateResultPercentage()
        displayIncorrectResultImage()
    }
    
    func updateResultPercentage() {
        let resultPercentage:Double = Double(correctCount) / (Double(incorrectCount + correctCount)) * 100
        resultsPercentage!.text = String(Int(resultPercentage)) + "%"
    }
    
    func displayCorrectResultImage() {
        resultImage?.image = UIImage(named: "check.png")
    }
    
    func displayIncorrectResultImage() {
        resultImage?.image = UIImage(named: "x.png")
    }
    
 
}



