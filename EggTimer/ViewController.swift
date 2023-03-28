//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
var player: AVAudioPlayer?

class ViewController: UIViewController {
    
    @IBOutlet weak var eggTimerLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft" : 5, "Medium" : 8, "Hard" : 12] //change to seconds 300, 420, 720
    var timeToBoil: Int = 0 //total time needed to boil the egg
    var secondsPassed = 0 //seconds passed boiling the egg
    var timer = Timer() //creating an instance of the Timer obj
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness: String? = sender.currentTitle!
        if hardness != nil {
            eggTimerLabel.text = hardness
            secondsPassed = 0
            timeToBoil = eggTimes[hardness!]! //changing the value of counter
            progressBar.progress = Float(secondsPassed) / Float(timeToBoil)
            timer.invalidate() //invalidating the Timer to avoid LOOP
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true) //creating the new Timer
        }
    }
    
    @objc func updateCounter() {
        //example functionality
        if secondsPassed < timeToBoil {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(timeToBoil)
        } else {
            timer.invalidate()
            eggTimerLabel.text = "DONE!"
            playAlarm()
        }
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
    }
}
