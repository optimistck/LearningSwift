//
//  ViewController.swift
//  Egg Timer
//
//  Created by Constantin on 11/30/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    let startTime = 15
    var remainingTime = 0
    var timerRunning = false

    @IBOutlet var timeLabel: UILabel!
    
    func updateTimerLabel() {
        timeLabel.text = String(remainingTime)
    }
    

    
    @IBAction func startTimer(_ sender: Any) {
        timerRunning = true
    }
    
    @IBAction func pauseTimer(_ sender: Any) {
        timerRunning = false
    }

    @IBAction func minusTenSeconds(_ sender: Any) {
        if remainingTime > 10 {
            remainingTime -= 10
            updateTimerLabel()
        }
    }

    @IBAction func plusTenSeconds(_ sender: Any) {
        if remainingTime < startTime - 10 {
            remainingTime += 10
            updateTimerLabel()
        } else if (startTime - remainingTime) < 10 {
            remainingTime += startTime - remainingTime
            updateTimerLabel()
        }
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        timerRunning = false
        remainingTime = startTime
        updateTimerLabel()
    }
    
    func processTimer() {
        // stuff to do once timer hits a threshold
        if timerRunning {
            remainingTime -= 1
            if remainingTime == 0 {
                timerRunning = false
            }
            updateTimerLabel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        remainingTime = startTime
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.processTimer), userInfo: nil, repeats: true)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

