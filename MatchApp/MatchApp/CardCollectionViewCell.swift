//
//  CardCollectionViewCell.swift
//  MatchApp
//
//  Created by Kacper Młodkowski on 26/08/2020.
//  Copyright © 2020 Kacper Młodkowski. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func configureCell(card:Card) {
//        keep track of the card this cell represents
        self.card = card
//        set the front image view to the image that represents the card
        frontImageView.image = UIImage(named: card.imageName)
//        reset the state of the cell by checking the flipped status of the card and then showing the front or the back imageview accordingly
        
        if card.isMatched {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        }
        else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        if card.isFlipped {
            flipUp(speed: 0)
            
        } else {
            flipDown(speed: 0,delay: 0)
        }
    }
    
//    flip up animation
    func flipUp(speed:TimeInterval = 0.3) {
        
//        flip the animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
//        set the status of the card
        
        card?.isFlipped = true
        
        
    }
    func flipDown(speed:TimeInterval = 0.3, delay:TimeInterval = 0.5) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        }
        
        //        set the status of the card
        
        card?.isFlipped = false
        
        
    }
    func remove(){
//        make the image views invisible
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
        }, completion: nil)
    }
    
    
}
