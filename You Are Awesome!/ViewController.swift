//
//  ViewController.swift
//  You Are Awesome!
//
//  Created by PJ Shalhoub on 8/27/17.
//  Copyright © 2017 PJ Shalhoub. All rights reserved.
//

import UIKit
import AVFoundation // need to import this in order to play sounds in the app

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var awesomeImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var soundSwitch: UISwitch!
    var awesomePlayer = AVAudioPlayer() // create variable for audio player
    var index = -1
    var imageNumber = -1
    var soundNumber = -1
    let numberOfImages = 10
    let numberOfSounds = 6
    
    // This code executes when the view controller loads
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    // MARK: - My Own Functions
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) { // use "inout" if we are going to pass in something that needs to be mutable
        // Now this is a function with mutable parameters
        // Note: we have to pass in a mutable value! Passing in a number, let constant or literal (like a String) will result in an error. Need to pass in varible type values
        // Can we load in a file sound name?
        if let sound  = NSDataAsset(name: soundName) {
            // check if sound.data is a sound file
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: data in \(soundName) couldn't be played as a sound")
            }
        } else {
            // if reading in the NSDataAsset did not work, tell the user / report the error
            print("ERROR: file \(soundName) did not load")
        }
    }
    
    func nonRepeatingRandom(lastNumber: Int, maxValue: Int) -> Int {
        var newIndex = -1
        repeat {
            newIndex = Int(arc4random_uniform(UInt32(maxValue)))
        } while lastNumber == newIndex
        return newIndex
    }
    
    // MARK: - Actions
    
    @IBAction func soundSwitchPressed(_ sender: UISwitch) {
        if !soundSwitch.isOn && soundNumber != -1 {
            // Stop playing
            awesomePlayer.stop()
        }
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        
        let messages = ["You Are Fantastic!",
                        "You Are Great!",
                        "You Are Amazing!",
                        "When the Genius Bar needs help, they call you!",
                        "You Brighten My Day",
                        "You Are Da Bomb!",
                        "I can't wait to use your app!",
                        "Fabulous? That's You!"]

        // Show a message here
        index = nonRepeatingRandom(lastNumber: index, maxValue: messages.count)
        messageLabel.text = messages[index]
        
        // Show an image here
        awesomeImage.isHidden = false
     
        imageNumber = nonRepeatingRandom(lastNumber: imageNumber, maxValue: numberOfImages)
        awesomeImage.image = UIImage(named: "image\(imageNumber)")
        
        if soundSwitch.isOn {
            // Get a random number to use in sound name file
            soundNumber = nonRepeatingRandom(lastNumber: soundNumber, maxValue: numberOfSounds)
            // Play a sound
            let soundName = "sound\(soundNumber)"
            playSound(soundName: soundName, audioPlayer: &awesomePlayer) // whenever you use inout, we need to put a & attached to the variable that we used inout with
        }

        
        
        
        
       // var randomIndex = Int(arc4random_uniform(UInt32(messages.count)))
       // messageLabel.text = messages[randomIndex]
        
        
        /*
        messageLabel.text = messages[index]
        index += 1
        if index == messages.count {
            index = 0
        }
        */
        
//        let message1 = "You Are Fantastic!!!"
//        let message2 = "You Are Great"
//        let message3 = "You Are Amazing"
//
//        if messageLabel.text == message1 {
//            messageLabel.text = message2
//        }
//        else if messageLabel.text == message2{
//            messageLabel.text = message3
//        }
//        else{
//            messageLabel.text = message1
//        }
 
    }
    
}

