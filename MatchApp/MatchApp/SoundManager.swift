//
//  SoundManager.swift
//  MatchApp
//
//  Created by Kacper Młodkowski on 31/08/2020.
//  Copyright © 2020 Kacper Młodkowski. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    var audioPlayer:AVAudioPlayer?
    
    enum soundEffect {
        case flip
        case match
        case nomatch
        case shuffle
    }
    
    func playSound(effect:soundEffect) {
        var soundFileName = ""
        
        switch effect {
            case .flip:
                soundFileName = "cardflip"
            case .match:
                soundFileName = "dingcorrect"
            case .nomatch:
                soundFileName = "dingwrong"
            case .shuffle:
                soundFileName = "shuffle"
        }
//        get the path to the resource
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: ".wav")
//        check that it is not null
        guard bundlePath != nil else {
            return
        }
        let url = URL(fileURLWithPath: bundlePath!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }
        catch {
            print("Couldn't create an audio player")
            return
        }
        
    }
}


