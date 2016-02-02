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
    @IBOutlet weak var timerLabel:UILabel?
    @IBOutlet weak var scoreDisplay:UILabel?
    @IBOutlet weak var aButton:UIButton?
    @IBOutlet weak var bButton:UIButton?
    @IBOutlet weak var cButton:UIButton?
    @IBOutlet weak var dButton:UIButton?
    @IBOutlet weak var eButton:UIButton?
    @IBOutlet weak var fButton:UIButton?
    @IBOutlet weak var gButton:UIButton?
    
    let gameDurationInSeconds = 20
    
    var nextRandomNoteInt = 0
    var currentNote = 0
    var correctCount = 0
    var incorrectCount = 0
    var skipCount = 0
    var score = 0
    var difficulty = ""
    var filteredNotesArr = [(noteName: String,octaveNumber: Int,
        absoluteNote: Int, isFlatOrSharp:Bool)]()
    var secondsRemaining = 0
    var timer = NSTimer()
    
    override func viewDidLoad() {
            super.viewDidLoad()
        formatButtonShapes()
        setup()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //create a note library, populate it with all 88 notes,and then
    //   filter based on difficulty. display first note, and start timer
    func setup() {
        
        let notes = NoteLibrary()
        notes.fillNoteLibrary()
        notes.filterNotesForDifficulty(difficulty)
        filteredNotesArr = notes.returnNotesArray()
        secondsRemaining = gameDurationInSeconds
        correctCount = 0
        incorrectCount = 0
        score = 0
        resultImage?.image = UIImage(named: "")
        updateResultsText()
        timerLabel!.text = "Time:\(gameDurationInSeconds)"
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        displayNextNoteImage()
    }
    
    func formatButtonShapes() {
        let buttonRadius:CGFloat = 5
        aButton?.layer.cornerRadius = buttonRadius
        bButton?.layer.cornerRadius = buttonRadius
        cButton?.layer.cornerRadius = buttonRadius
        dButton?.layer.cornerRadius = buttonRadius
        eButton?.layer.cornerRadius = buttonRadius
        fButton?.layer.cornerRadius = buttonRadius
        gButton?.layer.cornerRadius = buttonRadius
    }
    
    func pickRandomNote() -> Int {
        let maxRandom = filteredNotesArr.count
        let noteInt = Int(arc4random_uniform(UInt32(maxRandom)) + 1)
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
        
        let tempNote = filteredNotesArr[nextRandomNoteInt - 1]
        noteImage?.image = UIImage(named: "\(tempNote.noteName)\(tempNote.octaveNumber)-\(tempNote.absoluteNote)")
        
        currentNote = nextRandomNoteInt
    }
    
    
    @IBAction func noteButtonPushed(sender:UIButton) {
        checkIfNote(sender.titleLabel!.text!.lowercaseString)
    }
    
    
    func checkIfNote(note:String) {
        var guessedCorrect = false
        let tempNote = filteredNotesArr[currentNote - 1]
        if tempNote.noteName == note {
            guessedCorrect = true
            displayCorrect()
        }
        
        if !guessedCorrect {
            displayIncorrect()
        }
    }
    
    
    func displayCorrect() {
        correctCount++
        updateResultsText()
        displayCorrectResultImage()
        displayNextNoteImage()
    }

    
    func displayIncorrect() {
        incorrectCount++
        updateResultsText()
        displayIncorrectResultImage()
    }
    
    
    func updateResultsText(){
        correctResulDisplay?.text = String(correctCount)
        totalResultDisplay?.text = String(correctCount + incorrectCount)
        updateResultPercentage()
        updateScore()
    }
    
    func updateResultPercentage() {
        if(correctCount + incorrectCount == 0){
            resultsPercentage!.text = "0%"
        }else {
        let resultPercentage:Double = Double(correctCount) / (Double(incorrectCount + correctCount)) * 100
        resultsPercentage!.text = String(Int(resultPercentage)) + "%"
        }
    }
    
    func updateScore() {
        score = (correctCount * 100) - (incorrectCount * 50)
        scoreDisplay!.text = "Score: \(score)"
    }
    
    
    func displayCorrectResultImage() {
        resultImage?.image = UIImage(named: "check.png")
    }
    
    
    func displayIncorrectResultImage() {
        resultImage?.image = UIImage(named: "x.png")
    }
    
    
    func subtractTime() {
        secondsRemaining--
        timerLabel!.text = "Time:\(secondsRemaining)"
        if(secondsRemaining == 0){
            timer.invalidate()
            timerLabel?.text = "Game Over"
            let alert = UIAlertController(title: "Game Over", message: "You got \(correctCount) correct", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: { action in self.setup() } ))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}



