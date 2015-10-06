//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  This is a mobile game of Tic Tac Toe.
//
//  Created by Malachi Hul on 9/23/15.
//  Copyright © 2015 Malachi Hul. All rights reserved.
//

import UIKit

    // MARK: Global Variables to shared between ViewControllers.
    var playerOpponentHuman:Bool = Bool()
    var resetGame:Bool = Bool()

    var playerOne:Player = Player()
    var playerTwo:Player = Player()

class TicTacToeViewController: UIViewController {

    //UI Connections
    @IBOutlet weak var PlayerOneTurn: UIImageView!
    @IBOutlet weak var PlayerTwoTurn: UIImageView!
    @IBOutlet weak var PlayerOneSymbol: UILabel!
    @IBOutlet weak var PlayerTwoSymbol: UILabel!
    @IBOutlet weak var playerOneScore: UILabel!
    @IBOutlet weak var playerTwoScore: UILabel!
    @IBOutlet weak var totalGameCount: UILabel!
    @IBOutlet var ticTacToeCells: [UIButton]!
    
    // MARK: Initialization declaration
    //Game states.
    var TicTacToeBrain = TicTacToe()
    var gameComplete:Bool = Bool()
    var initialMove:Bool = Bool()
    
    //Score keeper
    var moveCount:Int = Int()
    var gameCount:Int = Int()
    var playerOneCount:Int = Int()
    var playerTwoCount:Int = Int()

    //Current player
    var currentPlayer:Int = Int()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Mark: Assigning initial variable values
        playerOne.setPlayerDetails(1, character: "X")
        playerTwo.setPlayerDetails(2, character: "O")
        
        //UI initial settings
        UIReset()
        getPlayerCharacters()
        
        //Initial game state
        resetGame = false
        setResetState()

        //Initial Opponent state
        playerOpponentHuman = true
        
        //Initial scoring
        moveCount = 0
        playerOneCount = 0
        playerTwoCount = 0
    }
    
    // MARK: ViewWillAppear
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //If settings changed, a new game will be created.
        //Computer Oponent feature coming soon!
        if playerOpponentHuman == false{
            gameAlert("Computer opponent not available", message: "Computer opponent feature will be avaible in Tic Tac Toe version 2.0.", start: "Start New Game", key: "nil")
            resetGame = false
            playerOpponentHuman = true
        } else if resetGame == true{
            NewGame()
            resetGame = false
        }
    }
    
    // MARK: Actions
    @IBAction func btnXOPressed(sender: UIButton) {
        
        //Sets the first move
        if initialMove == true {
            currentPlayer = playerOne.playerPosition
            initialMove = false
        }
        
        //Moves are saved in a dictionary and each turn calculates if there is a winner.
        if TicTacToeBrain.savedPositions[sender.tag] == nil && gameComplete != true {
        
            if playerOpponentHuman == true {
               sender.setTitle(humanMove(sender.tag, presentPlayer: currentPlayer), forState: UIControlState.Normal)
            }
        }
        
        let didSomeoneWin:Bool = TicTacToeBrain.calculateBoard()
        
        if didSomeoneWin == true {
            let winner:String = TicTacToeBrain.winner
            gameAlert("We have a winner!", message: "\(winner) won!", start:"Start New Game!", key:winner)
            gameCount++
        } else if moveCount == 9 && gameComplete == false {
            let winner:String = "draw"
            gameAlert("We have a tie!", message: "Draw Game!", start:"Start New Game!", key:winner)
            gameCount++
        }
    }
    
    // MARK: Assist functions
    
    func humanMove(position:Int, presentPlayer:Int)-> String{
        //Save users play
        let title:String = setUsersPlay(position, player: currentPlayer)
        
        if presentPlayer == playerOne.playerPosition {
            currentPlayer = playerTwo.playerPosition
        } else {
            currentPlayer = playerOne.playerPosition
        }
        
        //Toggle player label
        togglePlayerTurn()
        return title
    }
    
    func setUsersPlay(boardPosition:Int, player: Int) -> String{
        //logging
        print("Player \(currentPlayer) has moved.")
        print("Player One: \(playerOne.playerCharacter) Player Two: \(playerTwo.playerCharacter)")
        
        let playerPosition = player == 1 ? playerOne.playerCharacter : playerTwo.playerCharacter
        TicTacToeBrain.savedPositions[boardPosition] = player
        
        return playerPosition
    }
    
    func getPlayerCharacters(){
        PlayerOneSymbol.text = playerOne.playerCharacter
        PlayerTwoSymbol.text = playerTwo.playerCharacter
    }
    
    func togglePlayerTurn(){
        getPlayerCharacters()
        playerOneScore.text = "\(playerOneCount)"
        playerTwoScore.text = "\(playerTwoCount)"
        
        if PlayerOneTurn.hidden == true{
            PlayerOneTurn.hidden = false
            PlayerTwoTurn.hidden = true
            PlayerOneSymbol.hidden = false
            PlayerTwoSymbol.hidden = true
            playerOneScore.hidden = false
            playerTwoScore.hidden = true
            
        } else {
            PlayerOneTurn.hidden = true
            PlayerTwoTurn.hidden = false
            PlayerOneSymbol.hidden = true
            PlayerTwoSymbol.hidden = false
            playerOneScore.hidden = true
            playerTwoScore.hidden = false
        }
        moveCount++
    }


    func gameAlert(title:String, message:String, start:String, key:String){
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        
        //Create and add first option action
        let startNewGame: UIAlertAction = UIAlertAction(title: start, style: .Default) { action -> Void in
            
            //Reset Game Code
            self.NewGame()
        }
        actionSheetController.addAction(startNewGame)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
        //Player Score
        if key == "Player One" {
            playerOneCount++
        } else if key == "Player Two"{
            playerTwoCount++
        }
        playerOneScore.text = "\(playerOneCount)"
        playerTwoScore.text = "\(playerTwoCount)"
    }
    
    // MARK: Common functions
    func setResetState(){
        initialMove = true
        gameComplete = false
    }
    
    func UIReset(){
        PlayerOneTurn.hidden = false
        PlayerTwoTurn.hidden = true
        PlayerOneSymbol.hidden = false
        PlayerTwoSymbol.hidden = true
        playerOneScore.hidden = false
        playerTwoScore.hidden = true
    }

    func NewGame(){
        //rest positions saved
        TicTacToeBrain.savedPositions = [:]
        
        //reset UI buttons
        for buttons in ticTacToeCells{
            buttons.setTitle("", forState: UIControlState.Normal)
        }
        
        //Set back to initial state
        UIReset()
        getPlayerCharacters()
        setResetState()

        //reset counters
        moveCount = 0
        totalGameCount.text = "\(gameCount)"
    }
}
