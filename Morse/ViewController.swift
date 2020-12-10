//
//  ViewController.swift
//  Morse
//
//  Created by Christopher Reed on 11/10/20.
//

import UIKit
import CoreHaptics

class ViewController: UIViewController {
    
    
    
    var engine: CHHapticEngine?
    
    var transmissionMode = CHHapticEvent.EventType.hapticContinuous
    
    var codes = ["A": ".-",
                 "B": "-...",
                 "C": "-.-.",
                 "D": "-..",
                 "E": "-",
                 "F": "..-.",
                 "G": "--.",
                 "H": "....",
                 "I": "..",
                 "J": ".---",
                 "K": "-.-",
                 "L": ".-..",
                 "M": "..",
                 "N": "-.",
                 "O": "---",
                 "P": ".--.",
                 "Q": "--.-",
                 "R": "-.-",
                 "S": "...",
                 "T": "-",
                 "U": "..-",
                 "V": "...-",
                 "W": ".--",
                 "X": "-..-",
                 "Y": "-.--",
                 "Z": "--.."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let letter = sender.titleLabel!.text!
        playCoded(letter)
    }
    
    
    func playCoded(_ letter: String) {
        
        
        if let code = codes[letter] {
            print(code)
            var codeHaptic = [CHHapticEvent]()
            var t = 0.0
            for char in code {
                print(char)
                if char == "." {
                    codeHaptic.append(CHHapticEvent(eventType: transmissionMode, parameters: [], relativeTime: t, duration: 0.3))
                    t += 0.5
                } else {
                    codeHaptic.append(CHHapticEvent(eventType: transmissionMode, parameters: [], relativeTime: t, duration: 0.6))
                    t += 0.8
                }
                
            }
            do {
                let pattern = try CHHapticPattern(events: codeHaptic, parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription).")
            }
            
            
        } else {
            print("Something when wrong")
        }
        
    }
    

    
    @IBAction func transmissionModeSelected(_ sender: UIButton) {
        
        
        let mode = sender.titleLabel!.text
        print(sender.titleLabel!.text!)
        
        transmissionMode = mode == "Audio" ?  CHHapticEvent.EventType.audioContinuous : CHHapticEvent.EventType.hapticContinuous
        
    }
    
        
    
}

