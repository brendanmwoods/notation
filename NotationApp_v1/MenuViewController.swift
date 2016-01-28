//
//  MenuViewController.swift
//  NotationApp_v1
//
//  Created by brendan woods on 2016-01-27.
//  Copyright © 2016 brendan woods. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "easyButtonSegue") {
            let difficulty = "easy"
            let destinationVc = segue.destinationViewController as! ViewController
            destinationVc.difficulty = difficulty
        }
        
        if(segue.identifier == "mediumButtonSegue") {
            let difficulty = "medium"
            let destinationVc = segue.destinationViewController as! ViewController
            destinationVc.difficulty = difficulty
        }
    }
    
 
}
