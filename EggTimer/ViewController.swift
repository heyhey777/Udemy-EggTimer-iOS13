//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5,
                    "Medium": 7,
                    "Hard": 1]
    var timeLeft = 0
    var timer: Timer?
    var totalTime = 0
    var currentProgress: Float = 0.1
    
    @objc func fireTimer(timer: Timer) {
        timeLeft -= 1
        print("Time left \(timeLeft) seconds")
        currentProgress = Float(totalTime-timeLeft)/Float(totalTime)
        eggProgress.setProgress(currentProgress, animated: true)
     
        print("[Debug] totalTime \(totalTime)")
        print("[Debug] totalTime-timeLeft \(totalTime-timeLeft)")

        print("[Debug] currentProgress \(currentProgress)")
        print("[Debug] Egg progress \(eggProgress.progress)")
        
        
        if timeLeft == 0 {
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
                print("Could not find audio file")
                return
            }

            let player = AVPlayer(url: url)
            player.play()
            timer.invalidate()
        }
    }
    @IBOutlet weak var eggProgress: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        guard let time = eggTimes[hardness] else {
            print("Invalid hardness level selected")
            return
        }
        totalTime = time * 60
        print("Selected hardness level: \(hardness), time: \(time) minutes")
        timeLeft = time * 60
        timer?.invalidate()
        eggProgress.setProgress(0, animated: true)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer(timer:)), userInfo: nil, repeats: true)
    }
    
}
