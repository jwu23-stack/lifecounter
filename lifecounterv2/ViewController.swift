//
//  ViewController.swift
//  lifecounterv2
//
//  Created by Jerry CH Wu on 4/26/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var players: [Player] = []
    var history: [String] = []
    
    @IBOutlet weak var addPlayerBtn: UIButton!
    @IBOutlet weak var playerTable: UITableView!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var textLabel: UITextField!
    @IBOutlet weak var historyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTable.delegate = self
        playerTable.dataSource = self
        textLabel.delegate = self
        textLabel.text = String(5)
        startGame()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // code from stackOverflow forum on "How to restrict UITextField to take only numbers in Swift?"
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerTableViewCell = playerTable.dequeueReusableCell(withIdentifier: "Player Cell") as! PlayerTableViewCell
        cell.name.text = players[indexPath.row].name
        cell.health.text = String(players[indexPath.row].health)
        return cell
    }
    
    func startGame() {
        players = [
            Player(name: "Player 1", health: 20),
            Player(name: "Player 2", health: 20),
            Player(name: "Player 3", health: 20),
            Player(name: "Player 4", health: 20)
        ]
        history = ["Start Game!"]
        reloadTableData(player: players[0])
    }
    
    func reloadTableData(player: Player) {
        addPlayerBtn.isEnabled = true
        minusBtn.isEnabled = true
        plusBtn.isEnabled = true
        playerTable.reloadData()
        if player.health <= 0 {
            addPlayerBtn.isEnabled = false
            minusBtn.isEnabled = false
            plusBtn.isEnabled = false
            let alert = UIAlertController(title: "Game Over", message: "\(player.name)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func historyBtnClick(_ sender: Any) {
        performSegue(withIdentifier: "showHistory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistory" {
            let historyVC = segue.destination as! HistoryViewController
            historyVC.history = history
        }
    }
    
    @IBAction func unwindToMainVC(unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        let name = players.count + 1
        self.players.append(Player(name: "Player \(String(name))", health: 20))
        playerTable.reloadData()
    }
    
    @IBAction func modifyHealth(_ sender: Any) {
        let selectedTablePlayerIndex =  playerTable.indexPathForSelectedRow //selected table row
        if selectedTablePlayerIndex != nil { // player selected
            let selectedTableCell = playerTable.cellForRow(at: selectedTablePlayerIndex!) as! PlayerTableViewCell
            let playerNumber = selectedTableCell.name!.text
            let player = players.filter {
                return $0.name == playerNumber
            }[0]
            let stringHealth = textLabel.text!
            if (sender as! UIButton) == minusBtn {
                player.subtract(healthToSubtract: Int(stringHealth)!)
                history.append("\(String(describing: playerNumber!)) lost \(String(describing: Int(stringHealth)!)) life.")
            } else {
                player.add(healthToAdd: Int(stringHealth)!)
                history.append("\(String(describing: playerNumber!)) gained \(String(describing: Int(stringHealth)!)) life.")
            }
            reloadTableData(player: player)
            playerTable.selectRow(at: selectedTablePlayerIndex!, animated: true, scrollPosition: .none) // removes unselection after button is clicked
        } else { // no player selected
            print("Error: No player selected")
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}

