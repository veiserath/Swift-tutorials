//
//  ViewController.swift
//  MatchApp
//
//  Created by Kacper Młodkowski on 25/08/2020.
//  Copyright © 2020 Kacper Młodkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    
    
    let model = CardModel()
    var cards = [Card]()
    var firstFlippedCardIndex:IndexPath?
    var timer:Timer?
    var miliseconds:Int = 20 * 1000
    var soundPlayer = SoundManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cards = model.getCards()
        
        
//        set the view controller as the data source and delegate of the collection view
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        play the shuffle sound
        
        soundPlayer.playSound(effect: .shuffle)
    }
//    MARK: Timer Methods
    
    @objc func timerFired() {
//        Decrement the counter
        miliseconds -= 1
        
//        Update the label
        let seconds:Double = Double(miliseconds)/1000.0
        timerLabel.text = String(format: "Time Remaining: %.2f", seconds)
        
        
//        Stop the timer when it reaches zero
        
        if miliseconds == 0 {
            timerLabel.textColor = UIColor.red
            timer?.invalidate()
//            check if the user has cleared all the pairs
            checkForGameEnd()
            
        }
        
//        check if the user has cleared all the pairs
        
        
    }
    
    
    //    MARK: - Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        //        return it
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        configure the state of the cell based on the properties of the Card it represents
        
        let cardCell = cell as? CardCollectionViewCell
        let card = cards[indexPath.row]
        cardCell?.configureCell(card: card)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        check if there is time remaining. dont let user interact if the time is zero
        
        if miliseconds <= 0 {
            return
        }
//        get a reference to a cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
//        check the status of the card to determine how to flip it
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            
            cell?.flipUp()
            
//            play sound
            soundPlayer.playSound(effect: .flip)
            
//            check if this was the first card that was flipped or the second card
            if firstFlippedCardIndex == nil {
//                first card is flipped
                firstFlippedCardIndex = indexPath
                
            }
            else {
//                second card is flipped
//                run the comparison logic
                
                checkForMatch(indexPath)
                
            }
        }
    }
    
//    MARK: The game logic methods
    
    func checkForMatch(_ secondFlippedCardIndex:IndexPath){
//        get the two card objects for the two indices and see if they match
        
        let cardOne = cards[firstFlippedCardIndex!.row]
        let cardTwo = cards[secondFlippedCardIndex.row]
        
//        get the two collection view cells that represent card one and two
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        if cardOne.imageName == cardTwo.imageName {
//            it's a match
            
//            play match sound
            soundPlayer.playSound(effect: .match)
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
//            was it the last pair?
            checkForGameEnd()
        }
        else {
//            it's not a match - flip them back over
            
//            play the no match sound
            soundPlayer.playSound(effect: .nomatch)
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        firstFlippedCardIndex = nil
        
    }
    
    func checkForGameEnd(){
//        assume user has won, loop through all pairs to see if all of them are matched
        var hasWon = true
        
        for card in cards {
            if card.isMatched == false {
//                We've found a card that is unmatched
                hasWon = false
                break
            }
        }
        
        if hasWon {
            showAlert(title: "Congratulations", message: "You've won the game!")
        }
        else {
//            user hasn't won, check if there's any time left
            if miliseconds <= 0 {
                showAlert(title: "Time's Up!", message: "Sorry, better luck next time")
            }
            
        }
    }
    func showAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
        
    }
}

