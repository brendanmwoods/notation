//
//  NoteLibrary.swift
//  NotationApp_v1
//
//  Created by brendan woods on 2016-01-24.
//  Copyright © 2016 brendan woods. All rights reserved.
//

import Foundation

class NoteLibrary:NSObject {
    
    //Difficulty constants
    let easyTrebleBottomNote = 40
    let easyTrebleTopNote = 57
    let easyBassBottomNote = 23
    let easyBassTopNote = 40
    let mediumBottomNote = 23
    let mediumTopNote = 57
    var includeFlatsAndSharps = false
    
    var totalNotes = 88
    var allNotesArr = [(noteName: String,octaveNumber: Int,
        absoluteNote: Int, isFlatOrSharp:Bool)]()
    
    
    func fillNoteLibrary() {
        
        
        //create all 88 notes and assign absolute note number
        for (var i = 1; i <= totalNotes ; i++) {
            var tempNote = (noteName:"",octaveNumber:0,absoluteNote:0,false)
            tempNote.absoluteNote = i
            allNotesArr.append(tempNote)
        }
        
        //assign octave numbers
        for note in 0..<totalNotes {
            switch allNotesArr[note].absoluteNote {
            case 1...3: allNotesArr[note].octaveNumber = 0
            case 4...15: allNotesArr[note].octaveNumber = 1
            case 16...27: allNotesArr[note].octaveNumber = 2
            case 28...39: allNotesArr[note].octaveNumber = 3
            case 40...51: allNotesArr[note].octaveNumber = 4
            case 52...63: allNotesArr[note].octaveNumber = 5
            case 64...75: allNotesArr[note].octaveNumber = 6
            case 76...87: allNotesArr[note].octaveNumber = 7
            case 88: allNotesArr[note].octaveNumber = 8
            default: ("default case shouldn't be reached")
            }
        }
        
        //assign note names
        for index in 0..<totalNotes {
            switch allNotesArr[index].absoluteNote % 12 {
            case 0 : allNotesArr[index].noteName = "ab"
            allNotesArr[index].isFlatOrSharp = true
            case 1 : allNotesArr[index].noteName = "a"
            case 2 : allNotesArr[index].noteName = "bb"
            allNotesArr[index].isFlatOrSharp = true
            case 3 : allNotesArr[index].noteName = "b"
            case 4 : allNotesArr[index].noteName = "c"
            case 5 : allNotesArr[index].noteName = "db"
            allNotesArr[index].isFlatOrSharp = true
            case 6 : allNotesArr[index].noteName = "d"
            case 7 : allNotesArr[index].noteName = "eb"
            allNotesArr[index].isFlatOrSharp = true
            case 8 : allNotesArr[index].noteName = "e"
            case 9 : allNotesArr[index].noteName = "f"
            case 10 : allNotesArr[index].noteName = "gb"
            allNotesArr[index].isFlatOrSharp = true
            case 11 : allNotesArr[index].noteName = "g"
            default : print("default case shouldn't be reached")
            }
        }
    }
    
    
    func filterNotesForDifficulty(difficulty:String) {
        var tempBottomNote = 0
        var tempTopNote = 0
        
        switch difficulty {
        case "easyTreble":
            tempBottomNote = easyTrebleBottomNote
            tempTopNote = easyTrebleTopNote
        case "easyBass":
            tempBottomNote = easyBassBottomNote
            tempTopNote = easyBassTopNote
        case "medium":
            tempBottomNote = mediumBottomNote
            tempTopNote = mediumTopNote
        default:
            print("default case for filtering based on difficulty")
        }
        
        // remove all notes outside difficulty range
        for var i = allNotesArr.count-1; i >= 0; i-- {
            if allNotesArr[i].absoluteNote < tempBottomNote ||
                allNotesArr[i].absoluteNote > tempTopNote  {
                    allNotesArr.removeAtIndex(i)
            }
        }
        
        if !includeFlatsAndSharps {
            removeFlatsAndSharps()
        }
    }
    
    
    func removeFlatsAndSharps() {
        for var i = allNotesArr.count-1; i >= 0; i-- {
            if allNotesArr[i].isFlatOrSharp == true {
                allNotesArr.removeAtIndex(i)
            }
        }
    }
    
    
    func returnNotesArray() -> [(noteName: String,octaveNumber: Int,
        absoluteNote: Int, isFlatOrSharp:Bool)] {
            return allNotesArr
    }
    
    func printAllNotes() {
        print("Array currently contains \(allNotesArr.count) notes")
        for note in allNotesArr {
            print(note)
        }
    }
    
}