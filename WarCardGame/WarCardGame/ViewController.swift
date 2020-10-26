//
//  ViewController.swift
//  Lesson4
//
//  Created by Kacper Młodkowski on 21/08/2020.
//  Copyright © 2020 Kacper Młodkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var cpuImageView: UIImageView!
    
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    @IBOutlet weak var cpuScorelabel: UILabel!
    
    var playerScore = 0
    var cpuScore = 0
    var myArray = [Int]()
    var arrayCount = 51
    let serialQueue = DispatchQueue(label: "Serial Queue") // custom dispatch queues are serial by default
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fillMyArray()
        
    }
    
    
    
    @IBAction func dealTapped(_ sender: Any) {
        
        var playerCardNumber = generateRandom()
        var cpuCardNumber = generateRandom()
        
        updateCards(playerCardNumber: removeCardFromDeck(index: playerCardNumber), cpuCardNumber: removeCardFromDeck(index: cpuCardNumber))
        
        if playerCardNumber > cpuCardNumber {
            playerScore += 1
            updateScore(label: playerScoreLabel, score: playerScore)
        }
        if playerCardNumber < cpuCardNumber {
            cpuScore += 1
            updateScore(label: cpuScorelabel, score: cpuScore)
        }
        else {
            playerCardNumber = generateRandom()
            cpuCardNumber = generateRandom()
            updateCards(playerCardNumber: removeCardFromDeck(index: playerCardNumber), cpuCardNumber: removeCardFromDeck(index: cpuCardNumber))
        }
        
    }
    
    func generateRandom() -> Int {
        var random = 0
        serialQueue.sync {
            random = Int.random(in: 0...self.myArray.count-1)
        }
        return random
    }
    
    func removeCardFromDeck(index:Int) -> Int {
        arrayCount -= 1
        return myArray.remove(at: index)
    }
    
    func updateScore(label:UILabel,score:Int){
        label.text = String (score)
    }
    
    func updateCards(playerCardNumber:Int,cpuCardNumber:Int){
        playerImageView.image = UIImage(named: "\(playerCardNumber)")
        cpuImageView.image = UIImage(named: "\(cpuCardNumber)")
    }
    func fillMyArray(){
        for i in 0 ... 51 {
            myArray.append(i+1)
        }
    }
    
    

}

