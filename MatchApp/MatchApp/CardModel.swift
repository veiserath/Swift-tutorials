//
//  CardModel.swift
//  MatchApp
//
//  Created by Kacper Młodkowski on 25/08/2020.
//  Copyright © 2020 Kacper Młodkowski. All rights reserved.
//

import Foundation

class CardModel {
    
    
    
    func getCards() -> [Card] {
        
        //        Declare an empty array to store the numbers that we have generated
        var generatedNumbers = [Int]()
        
        //        Declare an empty array
        var generatedCards = [Card]()
        
        //        randomly generate 8 pairs of cards
        while generatedNumbers.count < 8 {
            
            
            //            generate a random number
            let randomNumber = Int.random(in: 1...13)
            
            if generatedNumbers.contains(randomNumber) == false {
                //            create two new card objects
                let cardOne = Card()
                let cardTwo = Card()
                
                //            set their images
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
                
                //            add them to the array
                generatedCards += [cardOne, cardTwo]
                
                generatedNumbers.append(randomNumber)
                
                print(randomNumber)
                
                //            randomize the array
                generatedCards.shuffle()
            }
        }
        
        return generatedCards
        
        
    }
}
