//
//  TicTacToeBrain.swift
//  TicTacToe
//
// This is the brain of Tic Tac Toe and calculates if a player wins.
//
//  Created by Malachi Hul on 9/24/15.
//  Copyright © 2015 Malachi Hul. All rights reserved.
//

import Foundation
import UIKit

class TicTacToe{
    
    var savedPositions = Dictionary<Int, Int>()
    let winningPerson = ["Player One":1, "Player Two":2]
    var winner:String = String()
    
    func calculateBoard() -> Bool{
        
        for(key,value) in winningPerson {
            
            if (savedPositions[7] == value && savedPositions[8] == value && savedPositions[9] == value) ||
                (savedPositions[4] == value && savedPositions[5] == value && savedPositions[6] == value) ||
                (savedPositions[1] == value && savedPositions[2] == value && savedPositions[3] == value) ||
                (savedPositions[1] == value && savedPositions[4] == value && savedPositions[7] == value) ||
                (savedPositions[2] == value && savedPositions[5] == value && savedPositions[8] == value) ||
                (savedPositions[3] == value && savedPositions[6] == value && savedPositions[9] == value) ||
                (savedPositions[1] == value && savedPositions[5] == value && savedPositions[9] == value) ||
                (savedPositions[3] == value && savedPositions[5] == value && savedPositions[7] == value) {
                    
                winner = key
                return true
            }
        }
        return false
    }
    
    func computerMove() -> UInt32{
        var ComputerScore = arc4random_uniform(9)
        ComputerScore++
        return ComputerScore
    }
    

}