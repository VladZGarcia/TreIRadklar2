//
//  ViewController.swift
//  TreIRad
//
//  Created by Hugo Garcia on 2022-11-30.
//

import UIKit

class ViewController: UIViewController {
    
    var playerNameOne : String?
    var playerNameTwo : String?
    
    enum Turn{
        case Nought
        case Cross
    }
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
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    
    var board = [UIButton]()
    
    var noughtsScore = 0
    var crossesScore = 0
    var computerEasy = false
    var computerMid = false
    var computerHard = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        initBoard()
    }
    
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
        turnName.text = "\(playerNameOne ?? "")'s turn!"
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        
        //if(currentTurn == Turn.Cross) {
        
        addToBoard(sender)
        if checkForVictory(CROSS){
            crossesScore += 1
            resultAlert(title: "\(playerNameOne ?? "")  Win!")
            return
        }
        if (!computerEasy || !computerMid || !computerHard) {
            if self.checkForVictory(self.NOUGHT){
                self.noughtsScore += 1
                
                self.resultAlert(title: "\(playerNameTwo ?? "") Win!")
                return
            }
        }
        if(self.fullBoard()) {
            
            self.resultAlert(title: "Draw")
            return
        }
        if (computerEasy || computerMid || computerHard) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                
                if(!(self.checkForVictory(self.CROSS)) || self.fullBoard()){
                    self.determinComputerTurnPosition()
                    
                    if self.checkForVictory(self.NOUGHT){
                        self.noughtsScore += 1
                        
                        self.resultAlert(title: "Computer AI Win!")
                        return
                    }
                    if(self.fullBoard()) {
                        self.resultAlert(title: "Draw")
                        return
                    }
                }
            }
        }
        
        //}
    }
    
    func determinComputerTurnPosition() {
        
        //Level 1
        if (computerEasy){
            var turnPosition = self.board.randomElement()!
            
            while (!(turnPosition.title(for: .normal) == nil)){
                turnPosition = self.board.randomElement()!
                
            }
            self.addToBoard(turnPosition)
        } else if(computerMid || computerHard){
            
            let computerMove = checkForPosibleWin(NOUGHT)
            self.addToBoard(computerMove!)
        }
    }
    
    func checkForPosibleWin(_ s :String) -> UIButton? {
        
        let winPatterns: Set<Set<UIButton>> = [[a1, a2, a3], [b1, b2, b3], [c1, c2, c3], [a1, b1, c1], [a2, b2, c2], [a3, b3, c3], [a1, b2, c3], [a3, b2, c1]]
        let computerMoves: [UIButton] = board.compactMap { $0 }.filter { $0.title(for: .normal) == s }
        let humanMoves: [UIButton] = board.compactMap { $0 }.filter { $0.title(for: .normal) == CROSS }
        
        if (computerHard) {
            
            
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(computerMoves)
                
                if winPositions.count == 1 {
                    if winPositions.first?.title(for: .normal) == nil {
                        
                        self.addToBoard(winPositions.first!)
                        return winPositions.first!
                    }
                }
            }
        }
        
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanMoves)
            
            if winPositions.count == 1 {
                if winPositions.first?.title(for: .normal) == nil {
                    self.addToBoard(winPositions.first!)
                    return winPositions.first!
                    
                }
            }
        }
        
        if (computerHard) {
            let sides: Set<UIButton> = [a2, b1, b3, c2]
            
            if (b2.title(for: .normal) == nil) {
                return b2
            }
            
            for pattern in winPatterns {
                var smartPositions = pattern.subtracting(computerMoves)
                smartPositions = pattern.subtracting(humanMoves)
                smartPositions = pattern.subtracting(sides)
                
                if smartPositions.count == 2 {
                    // for info in smartPositions {
                    //     print("\(info)")
                    // }
                    
                    if (smartPositions.first?.title(for: .normal) == nil) {
                        
                        
                        self.addToBoard(smartPositions.first!)
                        //print("Smartest position! \(smartPositions.first!)")
                        return smartPositions.first!
                    }
                }
            }
            
        }
        var randomPosition = self.board.randomElement()!
        
        while (!(randomPosition.title(for: .normal) == nil)){
            randomPosition = self.board.randomElement()!
            
        }
        
        return randomPosition
        
    }
    
    func checkForVictory(_ s :String) -> Bool {
        // Horizontal
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) {
            return true
        }
        // Vertical
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) {
            return true
        }
        // Diagonal
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) {
            return true
        }
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        
        let message = "\n \(playerNameOne ?? "") score : " + String(crossesScore) + " win" + "\n\n \(playerNameTwo ?? "") score : " + String(noughtsScore) + " win"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            
            self.resetBoard()
            
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
      
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstTurn == Turn.Nought {
            firstTurn = Turn.Cross
            turnLabel.text = "\(CROSS)"
        }
        else if firstTurn == Turn.Cross {
            firstTurn = Turn.Nought
            turnLabel.text = "\(NOUGHT)"
        }
        
        currentTurn = firstTurn
        print("\(currentTurn)")
        if(firstTurn == Turn.Nought) {
            
            determinComputerTurnPosition()
            
        }
        
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        
        if(sender.title(for: .normal) == nil){
            if(currentTurn == Turn.Nought){
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnName.text = "\(playerNameOne ?? "")´s turn!"
                turnLabel.text = CROSS
            }
            else if(currentTurn == Turn.Cross){
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnName.text = "\(playerNameTwo ?? "")´s turn!"
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
}

