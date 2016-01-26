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
    @IBOutlet weak var resultText:UILabel?
    @IBOutlet weak var correctResulDisplay:UILabel?
    @IBOutlet weak var totalResultDisplay:UILabel?
    @IBOutlet weak var resultsPercentage:UILabel?
    
    var nextRandomNoteInt = 0
    var currentNote = 0
    var correctCount = 0
    var incorrectCount = 0
    var skipCount = 0
    
    enum Notes {
    case C,D,E,F,G,A,B
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNextNoteImage()
        // Do any additional setup after loading the view, typically from a nib.
        
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

        //displayNextNoteImage()
        noteImage?.image = UIImage(named: "grandStaff-blank-400x500.png")
        skipCount++
        if skipCount % 2 == 0 {
            displayNextNoteImage()
        }
    }
    
    func displayNextNoteImage() {
        
    nextRandomNoteInt = pickRandomNote()
        while(nextRandomNoteInt == currentNote) {
            print("DUPLICATE AVOIDED")
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
        resultText!.text = "Correct"
        resultText!.textColor = UIColor.blueColor()
        print("Correct")
        correctResulDisplay?.text = String(correctCount)
        totalResultDisplay?.text = String(correctCount + incorrectCount)
        updateResultPercentage()
        displayNextNoteImage()
    }
    
    func displayIncorrect() {
        incorrectCount++
        resultText!.text = "Incorrect"
        resultText!.textColor = UIColor.redColor()
        print("Incorrect")
        totalResultDisplay?.text = String(correctCount + incorrectCount)
        updateResultPercentage()
    }
    
    func updateResultPercentage() {
        let resultPercentage:Double = Double(correctCount) / (Double(incorrectCount + correctCount)) * 100
        resultsPercentage!.text = String(Int(resultPercentage)) + "%"
    }
}



