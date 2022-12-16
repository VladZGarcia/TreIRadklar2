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
        enum UIKeyboardType : Int, @unchecked Sendable {
            case namePhonePad
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        overrideUserInterfaceStyle = .light
        firstPlayerTextField.isHidden = true
        secondPlayerTextField.isHidden = true
        startButton.isHidden = true
        nameTextLabel.isHidden = true
        levelTextLabel.isHidden = true
        easyButton.isHidden = true
        mediumButton.isHidden = true
        hardButton.isHidden = true
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func twoPlayerButton(_ sender: UIButton) {
        nameTextLabel.isHidden = false
        firstPlayerTextField.isHidden = false
        firstPlayerTextField.placeholder = "Player 1"
        secondPlayerTextField.isHidden = false
        secondPlayerTextField.placeholder = "Player 2"
        startButton.isHidden = false
        multiPlayerButton.isHidden = false
        singlePlayerButton.isHidden = false
        levelTextLabel.isHidden = true
        easyButton.isHidden = true
        mediumButton.isHidden = true
        hardButton.isHidden = true
        
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if ((firstPlayerTextField.text) != nil && (secondPlayerTextField.text) != nil) {
           multiplayer = true
            performSegue(withIdentifier: segueToGameView, sender: self)
        }
        
        
    }
    @IBAction func singlePlayerButton(_ sender: UIButton) {
        multiplayer = false
        multiPlayerButton.isHidden = false
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
                if (!multiplayer) {
                    destinationVC.playerNameOne = firstPlayerTextField.text ?? "Player one"
                    destinationVC.playerNameTwo = "Computer "
                    destinationVC.computerEasy = levelEasy
                    destinationVC.computerMid = levelMid
                    destinationVC.computerHard = levelHard
                }
            }
        }
    }

}

