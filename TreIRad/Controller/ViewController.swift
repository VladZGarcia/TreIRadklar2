//
//  ViewController.swift
//  TreIRad
//
//  Created by Hugo Garcia on 2022-11-30.
//

import UIKit

class ViewController: UIViewController {
    
    var gameModel = GameModel()
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var turnName: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var noughtsScore = 0
    var crossesScore = 0
    
    var playerNameOne : String?
    var playerNameTwo : String?
    var computerEasy = false
    var computerMid = false
    var computerHard = false
    
    var currentTurn = GameModel.Turn.Cross
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        initBoard()
    }
    
    func initBoard(){
        gameModel.board.append(a1)
        gameModel.board.append(a2)
        gameModel.board.append(a3)
        gameModel.board.append(b1)
        gameModel.board.append(b2)
        gameModel.board.append(b3)
        gameModel.board.append(c1)
        gameModel.board.append(c2)
        gameModel.board.append(c3)
        turnName.text = "\(playerNameOne ?? "")'s turn!"
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        if (currentTurn == GameModel.Turn.Cross) {
            turnInfo(gameModel.addToBoard(sender))
            
            if gameModel.checkForVictory(gameModel.CROSS){
                crossesScore += 1
                resultAlert(title: "\(playerNameOne ?? "Player one")  Win!")
                return
            }
            if (!computerEasy || !computerMid || !computerHard) {
                if self.gameModel.checkForVictory(self.gameModel.NOUGHT){
                    self.noughtsScore += 1
                    
                    self.resultAlert(title: "\(playerNameTwo ?? "Player two") Win!")
                    return
                }
            }
            if(self.gameModel.fullBoard()) {
                self.resultAlert(title: "Draw")
                return
            }
            if (computerEasy || computerMid || computerHard) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                    
                    if(!(self.gameModel.checkForVictory(self.gameModel.CROSS)) || self.gameModel.fullBoard()){
                        
                        self.determinComputerTurnPosition()
                        
                        if self.gameModel.checkForVictory(self.gameModel.NOUGHT){
                            self.noughtsScore += 1
                            self.resultAlert(title: "Computer Win!")
                            return
                        }
                        if(self.gameModel.fullBoard()) {
                            self.resultAlert(title: "Draw")
                            return
                        }
                    }
                }
            }
        }
    }
    
    
    
    func determinComputerTurnPosition() {
        if (computerEasy){
            
            turnInfo(self.gameModel.addToBoard(gameModel.levelEasy()))
            
        } else if(computerMid || computerHard){
            var level: String?
            if (computerMid){
                 level = "computerMid"
            } else if (computerHard) {
                level = "computerHard"
            }
            let computerMove = gameModel.checkForPosibleWin(gameModel.NOUGHT, level)
            
            turnInfo(self.gameModel.addToBoard(computerMove!))
        }
    }
    
    func turnInfo (_ infoTurn: GameModel.Turn){
        if (infoTurn == GameModel.Turn.Cross) {
            turnName.text = "\(playerNameOne ?? "Player one")´s turn!"
            turnLabel.text = gameModel.CROSS
        } else if (infoTurn == GameModel.Turn.Nought) {
            turnName.text = "\(playerNameTwo ?? "Player two")´s turn!"
            turnLabel.text = gameModel.NOUGHT
        }
    }
    
    func resultAlert(title: String) {
        
        let message = "\n \(playerNameOne ?? "Player one") score : " + String(crossesScore) + " win" + "\n\n \(playerNameTwo ?? "player two") score :"  + String(noughtsScore) + " win"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [self] (_) in
            
            currentTurn = gameModel.resetBoard()
            if (currentTurn == GameModel.Turn.Nought) {
                determinComputerTurnPosition()
                currentTurn = GameModel.Turn.Cross
            }
        }))
        self.present(ac, animated: true)
    }
}

