//
//  battleship.swift
//  Battleship
//
//  Created by Amber Spadafora on 9/17/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class Battleship {
    
    init(){
        buttonSetUp()
    }
    
    enum Status {
        case hit
        case unhit
        case miss
    }
    
    var buttons = [[Status]]()
    
    var buttonTwoDArray = [[Int]]()
    
    func buttonSetUp() {
        buttons = Array(repeating: [.miss,.miss,.miss,.miss,.miss,.miss,.miss,.miss,.miss,.miss], count: 10)
    }
    
    
}
