//
//  GameModel.swift
//  TreIRad
//
//  Created by Hugo Garcia on 2022-12-15.
//

import Foundation
import UIKit

class GameModel {
    var board = [UIButton]()
    
    var modelFirstTurn = Turn.Cross
    var modelCurrentTurn = Turn.Cross
    var NOUGHT = "O"
    var CROSS = "X"
    
    enum Turn{
        case Nought
        case Cross
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func addToBoard(_ sender: UIButton) -> Turn {
        
        if(sender.title(for: .normal) == nil){
            if(modelCurrentTurn == Turn.Nought){
                sender.setTitle(NOUGHT, for: .normal)
                modelCurrentTurn = Turn.Cross
            }
            else if(modelCurrentTurn == Turn.Cross){
                sender.setTitle(CROSS, for: .normal)
                modelCurrentTurn = Turn.Nought
            }
            sender.isEnabled = false
        }
        return modelCurrentTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func resetBoard() -> Turn{
        
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if modelFirstTurn == Turn.Nought {
            modelFirstTurn = Turn.Cross
        }
        else if modelFirstTurn == Turn.Cross {
            modelFirstTurn = Turn.Nought
            //turnLabel.text = "\(NOUGHT)"
        }
        //currentTurn = firstTurn
        
        return modelFirstTurn
    }
    
    func levelEasy() -> UIButton {
        var turnPosition = self.board.randomElement()!
        
        while (!(turnPosition.title(for: .normal) == nil)){
            turnPosition = self.board.randomElement()!
            
        }
        return turnPosition
    }
   // func levelMid() {
   //
   //
   // }
   // func levelHard() {
   //
   //
   // }
    func checkForVictory(_ s :String) -> Bool {
        
        // Horizontal
        if thisSymbol(board[0], s) && thisSymbol(board[1], s) && thisSymbol(board[2], s) {
            return true
        }
        if thisSymbol(board[3], s) && thisSymbol(board[4], s) && thisSymbol(board[5], s) {
            return true
        }
        if thisSymbol(board[6], s) && thisSymbol(board[7], s) && thisSymbol(board[8], s) {
            return true
        }
        // Vertical
        if thisSymbol(board[0], s) && thisSymbol(board[3], s) && thisSymbol(board[6], s) {
            return true
        }
        if thisSymbol(board[1], s) && thisSymbol(board[4], s) && thisSymbol(board[7], s) {
            return true
        }
        if thisSymbol(board[2], s) && thisSymbol(board[5], s) && thisSymbol(board[8], s) {
            return true
        }
        // Diagonal
        if thisSymbol(board[0], s) && thisSymbol(board[4], s) && thisSymbol(board[8], s) {
            return true
        }
        if thisSymbol(board[2], s) && thisSymbol(board[4], s) && thisSymbol(board[6], s) {
            return true
        }
        
        return false
    }
    
    func checkForPosibleWin(_ s :String, _ level :String? ) -> UIButton? {
        let sides: Set<UIButton> = [board[1], board[3], board[5], board[7]]
        let winPatterns: Set<Set<UIButton>> = [[board[0], board[1], board[2]], [board[3], board[4], board[5]], [board[6], board[7], board[8]], [board[0], board[3], board[6]], [board[1], board[4], board[7]], [board[2], board[5], board[8]], [board[0], board[4], board[8]], [board[2], board[4], board[6]]]
        let computerMoves: [UIButton] = board.compactMap { $0 }.filter { $0.title(for: .normal) == s }
        let humanMoves: [UIButton] = board.compactMap { $0 }.filter { $0.title(for: .normal) == CROSS }
        
        if (level == "computerHard") {
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(computerMoves)
                
                if winPositions.count == 1 {
                    if winPositions.first?.title(for: .normal) == nil {
                        
                       // turnInfo(self.gameModel.addToBoard(winPositions.first!))
                        
                        return winPositions.first!
                    }
                }
            }
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(humanMoves)
                
                if winPositions.count == 1 {
                    if winPositions.first?.title(for: .normal) == nil {
                        
                        //turnInfo(self.gameModel.addToBoard(winPositions.first!))
                        
                        return winPositions.first!
                        
                    }
                }
            }
            
            
            if (board[4].title(for: .normal) == nil) {
                return board[4]
            }
            
            for pattern in winPatterns {
                var smartPositions = pattern.subtracting(computerMoves)
                smartPositions = pattern.subtracting(humanMoves)
                smartPositions = pattern.subtracting(sides)
                
                if smartPositions.count == 2 {
                    if (smartPositions.first?.title(for: .normal) == nil) {
                        
                        //turnInfo(self.gameModel.addToBoard(smartPositions.first!))
                        
                        return smartPositions.first!
                    }
                }
            }
        }
        
            
            var randomPosition = levelEasy()
            while (!(randomPosition.title(for: .normal) == nil)){
                randomPosition = levelEasy()
            }
        return randomPosition
    }
}
