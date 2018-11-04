//
//  ViewController.swift
//  The Decider
//
//  Created by Mick Mossman on 2/11/18.
//  Copyright © 2018 Mick Mossman. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore

class MainViewController: UIViewController {

    @IBOutlet weak var imgYouScore: UIImageView!
    
    @IBOutlet weak var imgMeScore: UIImageView!
    
    @IBOutlet weak var imgYouWinner: UIImageView!
    
    @IBOutlet weak var imgMeWinner: UIImageView!
    
    @IBOutlet weak var imgArrow: UIImageView!
    
    var winImages : [String] = []
    var audioPlayer : AVAudioPlayer!
    
    var winnerisMe = false
    var winnerisYou = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK:- Build
    func initPlayer() {
        
    }
    
    func playSoundWithFile(filename:String) {
        if let sound = NSDataAsset(name: filename) {
            do {
                audioPlayer = try AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            }catch{
                print("Error playng sound")
            }
//            do {
//                try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//                try! AVAudioSession.sharedInstance().setActive(true)
//                try alarmAudioPlayer = AVAudioPlayer(data: sound.data, fileTypeHint: AVFileTypeWAVE)
//                alarmAudioPlayer!.play()
//            } catch {
//                print("error initializing AVAudioPlayer")
//            }
        }
    }
    
    func loadImages() {
        for i in 1 ... 12 {
            winImages.append(String(format: "winner%d", i))
        }
    }
    //MARK:- IBActions
    
    @IBAction func spinArrow(_ sender: Any) {
    }
}

