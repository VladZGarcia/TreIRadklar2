//
//  StartViewController.swift
//  TreIRad
//
//  Created by Hugo Garcia on 2022-12-12.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var firstPlayerTextField: UITextField!
    
    @IBOutlet weak var secondPlayerTextField: UITextField!
    
    let segueToGameView = "segueToGame"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func twoPlayerButton(_ sender: UIButton) {
        
        
        performSegue(withIdentifier: segueToGameView, sender: self)
        
    }
    
    @IBAction func singlePlayerButton(_ sender: Any) {
        
        performSegue(withIdentifier: segueToGameView, sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToGameView {
           if let destinationVC = segue.destination as? ViewController{
               destinationVC.playerNameOne = firstPlayerTextField.text ?? "Player one"
               destinationVC.playerNameTwo = secondPlayerTextField.text ?? "Player two"
            }
        }
    }
    

}

