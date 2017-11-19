//
//  ViewController.swift
//  Sound Effects
//
//  Created by Constantin on 12/21/16.
//  Copyright © 2016 Constantin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if event?.subtype == UIEventSubtype.motionShake {
            
            let soundArray = ["slide_and_click", "close_lighter", "slide_whistle_down"]
            
            let randomNumber = Int(arc4random_uniform(UInt32(soundArray.count)))
            
            let fileLocation = Bundle.main.path(forResource: soundArray[randomNumber], ofType: "mp3") // Bundle.main().pathForResource(soundArray[randomNumber], ofType: "mp3") is now Bundle.main.path(forResource: soundArray[randomNumber], ofType: "mp3")
            
            do {
                
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileLocation!))
                
                player.play()
                
            } catch {
                
                // process error
                
            }
            
        }
        
    }
    
//    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
//        if event?.subtype == UIEventSubtype.motionShake {
//
//            
//            let soundArray = ["slide_and_click", "close_lighter", "slide_whistle_down"]
//            
//            let randomNumber = Int(arc4random_uniform(UInt32(soundArray.count)))
//            
//          //let fileLocation = Bundle.main.path(forResource: soundArray[randomNumber], ofType: "mp3")
//            let fileLocation = Bundle.main.path(forResource: soundArray[randomNumber], ofType: "mp3")
//            
//            //let audioPath = Bundle.main.path(forResource: "close_lighter", ofType: "mp3")
//            
//            
//            
//            do {
//                
//        //      try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileLocation!))
//                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileLocation!))
//                //try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
//                print("shaked")
//                
//            } catch {
//             
//                // process error
//            }
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

