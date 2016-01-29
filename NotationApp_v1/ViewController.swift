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
    
    var nextRandomNoteInt = 0
    var currentNote = 0
    var correctCount = 0
    var incorrectCount = 0
    var skipCount = 0
    var difficulty = ""
    var filteredNotesArr = [(noteName: String,octaveNumber: Int,
        absoluteNote: Int, isFlatOrSharp:Bool)]()
    let gameDurationInSeconds = 10
    var secondsRemaining = 0
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        filteredNotesArr = notes.returnFilteredNotes()
        secondsRemaining = gameDurationInSeconds
        timerLabel!.text = "Time:\(gameDurationInSeconds)"
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        displayNextNoteImage()
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
        
        print(filteredNotesArr[nextRandomNoteInt - 1])
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
    
    
    func subtractTime() {
        secondsRemaining--
        timerLabel!.text = "Time:\(secondsRemaining)"
        if(secondsRemaining == 0){
            timer.invalidate()
            timerLabel?.text = "Game Over"
        }
    }
}



