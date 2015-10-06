//
//  Player.swift
//  TicTacToe
//
// Creates the players used in Tic Tac Toe
//
//  Created by Malachi Hul on 9/23/15.
//  Copyright © 2015 Malachi Hul. All rights reserved.
//

import Foundation

class Player {
    
    var playerPosition:Int = Int()
    var playerCharacter:String = String()
    
    func setPlayerDetails(position:Int, character:String){
        playerPosition = position
        playerCharacter = character
    }
    
}