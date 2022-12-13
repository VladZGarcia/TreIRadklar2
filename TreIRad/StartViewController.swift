//
//  StartViewController.swift
//  TreIRad
//
//  Created by Hugo Garcia on 2022-12-12.
//

import UIKit

class StartViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var firstPlayerTextField: UITextField!
    
    @IBOutlet weak var secondPlayerTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var levelTextLabel: UILabel!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var multiPlayerButton: UIButton!
    @IBOutlet weak var singlePlayerButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    
    @IBOutlet weak var mediumButton: UIButton!
    
    @IBOutlet weak var hardButton: UIButton!
    let segueToGameView = "segueToGame"
    
    var multiplayer = true
    var levelEasy = false
    var levelMid = false
    var levelHard = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstPlayerTextField.isHidden = true
        secondPlayerTextField.isHidden = true
        startButton.isHidden = true
        nameTextLabel.isHidden = true
        levelTextLabel.isHidden = true
        easyButton.isHidden = true
        mediumButton.isHidden = true
        hardButton.isHidden = true
        
    }
    
    @IBAction func twoPlayerButton(_ sender: UIButton) {
        firstPlayerTextField.isHidden = false
        secondPlayerTextField.isHidden = false
        startButton.isHidden = false
        multiPlayerButton.isHidden = true
        singlePlayerButton.isHidden = true
        levelTextLabel.isHidden = true
        easyButton.isHidden = true
        mediumButton.isHidden = true
        hardButton.isHidden = true
        
    }
    
    
    @IBAction func startButton(_ sender: UIButton) {
        performSegue(withIdentifier: segueToGameView, sender: self)
        
        
    }
    
    
    
    
    
    @IBAction func singlePlayerButton(_ sender: UIButton) {
        multiplayer = false
        multiPlayerButton.isHidden = true
        singlePlayerButton.isHidden = true
        firstPlayerTextField.isHidden = false
        secondPlayerTextField.isHidden = true
        startButton.isHidden = true
        nameTextLabel.isHidden = false
        levelTextLabel.isHidden = false
        easyButton.isHidden = false
        mediumButton.isHidden = false
        hardButton.isHidden = false
        
        
    }
    
    @IBAction func easyButton(_ sender: UIButton) {
         levelEasy = true
         levelMid = false
         levelHard = false
        performSegue(withIdentifier: segueToGameView, sender: self)
    }
    
    @IBAction func midButton(_ sender: UIButton) {
        levelEasy = false
        levelMid = true
        levelHard = false
        performSegue(withIdentifier: segueToGameView, sender: self)
    }
    
    @IBAction func hardButton(_ sender: UIButton) {
        levelEasy = false
        levelMid = false
        levelHard = true
        performSegue(withIdentifier: segueToGameView, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToGameView {
            if let destinationVC = segue.destination as? ViewController{
                if ( multiplayer){
                    destinationVC.playerNameOne = firstPlayerTextField.text ?? "Player one"
                    destinationVC.playerNameTwo = secondPlayerTextField.text ?? "Player two"
                }
                destinationVC.playerNameOne = firstPlayerTextField.text ?? "Player one"
                destinationVC.playerNameTwo = "Dator AI"
                destinationVC.computerEasy = levelEasy
                destinationVC.computerMid = levelMid
                destinationVC.computerHard = levelHard
                
            }
        }
    }
    

}

