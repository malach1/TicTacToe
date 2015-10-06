//
//  SettingsViewController.swift
//  TicTacToe
//
/*  Settings for the Tic Tac Toe game.  Player can choose the Character for Player 1 to be an X or an O.
Player is able to set the opponent type of Human (2 players) or Computer (single player).

The setting has a dependency from the TicTacToeViewController global variables.
*/
//  Created by Malachi Hul on 9/23/15.
//  Copyright © 2015 Malachi Hul. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: UI Properties
    @IBOutlet weak var playerChoice: UISegmentedControl!
    @IBOutlet weak var playerOpponent: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Get UI selection to last known type of Player One's chose character and Opponent type.
        getPlayerCharacter()
        getOpponentType()
    }

    // MARK: Actions
    @IBAction func btnCancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});
    }

    @IBAction func btnSavePressed(sender: UIButton) {
        setPlayerCharacter()
        setOpponentType()
        
        //log of Player Character and Opponent Type
        print("Player One: \(playerOne.playerCharacter)")
        print("Player Two: \(playerTwo.playerCharacter)")
        print("Opponent is human: \(playerOpponentHuman)")
        
        //Saving changes will reset the game.
        saveAlert()
    }
    
    // MARK: Get
    func getPlayerCharacter(){
        if playerOne.playerCharacter == "X"{
            playerChoice.selectedSegmentIndex = 0
        } else {
            playerChoice.selectedSegmentIndex = 1
        }
    }
    
    func getOpponentType(){
        if playerOpponentHuman == true {
            playerOpponent.selectedSegmentIndex = 0
        } else {
            playerOpponent.selectedSegmentIndex = 1
        }
    }
    
    // MARK: Set
    func setPlayerCharacter(){
        if playerChoice.selectedSegmentIndex == 0 {
            playerOne.playerCharacter = "X"
            playerTwo.playerCharacter = "O"
        } else if playerChoice.selectedSegmentIndex == 1 {
            playerOne.playerCharacter = "O"
            playerTwo.playerCharacter = "X"
        }
    }
    
    // MARK: Methods
    func setOpponentType(){
        if playerOpponent.selectedSegmentIndex == 0 {
            playerOpponentHuman = true
        } else if playerOpponent.selectedSegmentIndex == 1 {
            playerOpponentHuman = false
        }
    }
    
    func saveAlert(){

        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Saving changes?", message: "Saving changings will start a new game.", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
        //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        //Create and add first option action
        let startNewGame: UIAlertAction = UIAlertAction(title: "Save changes and start a new game.", style: .Default) { action -> Void in
            
            //Reset Game
            resetGame = true
            self.dismissViewControllerAnimated(true, completion: {});
        }
        actionSheetController.addAction(startNewGame)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
}
