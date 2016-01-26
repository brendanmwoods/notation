//
//  NoteLibrary.swift
//  NotationApp_v1
//
//  Created by brendan woods on 2016-01-24.
//  Copyright © 2016 brendan woods. All rights reserved.
//

import Foundation


var totalNotes = 88
var allNotesArr = [(noteName: String,octaveNumber: Int,absoluteNote: Int)]()

func fillNoteLibrary() {
    //create all 88 notes and assign note number
    for (var i = 1; i <= totalNotes ; i++) {
        var tempNote = (noteName:"",octaveNumber:0,absoluteNote:0)
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
        case 0 : allNotesArr[index].noteName = "Aa"
        case 1 : allNotesArr[index].noteName = "A"
        case 2 : allNotesArr[index].noteName = "Bb"
        case 3 : allNotesArr[index].noteName = "B"
        case 4 : allNotesArr[index].noteName = "C"
        case 5 : allNotesArr[index].noteName = "Db"
        case 6 : allNotesArr[index].noteName = "D"
        case 7 : allNotesArr[index].noteName = "Eb"
        case 8 : allNotesArr[index].noteName = "E"
        case 9 : allNotesArr[index].noteName = "F"
        case 10 : allNotesArr[index].noteName = "Gb"
        case 11 : allNotesArr[index].noteName = "G"
        default : print("default case shouldn't be reached")
        }
    }
    
    for note in allNotesArr {
        print(note)
    }
}