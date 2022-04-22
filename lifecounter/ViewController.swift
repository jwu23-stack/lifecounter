//
//  ViewController.swift
//  lifecounter
//
//  Created by Jerry CH Wu on 4/21/22.
//

import UIKit

class ViewController: UIViewController {
    var player1Lives : Int = 20
    var player2Lives : Int = 20
    
    //Player 1
    @IBOutlet weak var player1LivesLabel: UILabel!
    @IBOutlet weak var player1Plus1: UIButton!
    @IBOutlet weak var player1Plus5: UIButton!
    @IBOutlet weak var player1Minus1: UIButton!
    @IBOutlet weak var player1Minus5: UIButton!
    
    //Player 2
    @IBOutlet weak var player2LivesLabel: UILabel!
    @IBOutlet weak var player2Plus1: UIButton!
    @IBOutlet weak var player2Plus5: UIButton!
    @IBOutlet weak var player2Minus1: UIButton!
    @IBOutlet weak var player2Minus5: UIButton!
    
    // Losing player label
    @IBOutlet weak var losingPlayer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func updateScore(_ sender: UIButton) {
        switch sender {
        case player1Plus1:
            player1Lives += 1
        case player1Plus5:
            player1Lives += 5
        case player1Minus1:
            player1Lives -= 1
        case player1Minus5:
            player1Lives -= 5
        case player2Plus1:
            player2Lives += 1
        case player2Plus5:
            player2Lives += 5
        case player2Minus1:
            player2Lives -= 1
        case player2Minus5:
            player2Lives -= 5
        default:
            print(sender)
        }
        updateLivesCounter()
    }
    
    func updateLivesCounter() -> Void {
        player1LivesLabel.text = "\(player1Lives)"
        player2LivesLabel.text = "\(player2Lives)"
        if player1Lives <= 0 {
            losingPlayer.text = "Player 1 LOSES!"
        }
        if player2Lives <= 0 {
            losingPlayer.text = "Player 2 LOSES!"
        }
    }
    
}

