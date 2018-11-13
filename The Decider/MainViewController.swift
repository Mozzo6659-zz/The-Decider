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

class MainViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var imgYouScore: UIImageView!
    
    @IBOutlet weak var youIconView: UIImageView!
    
    @IBOutlet weak var meIconView: UIImageView!
    
    @IBOutlet weak var imgMeScore: UIImageView!
    
    @IBOutlet weak var imgYouWinner: UIImageView!
    
    @IBOutlet weak var imgMeWinner: UIImageView!
    
    @IBOutlet weak var imgArrow: UIImageView!
    
    
    let animKey = "transform.rotation.z"
    
    let animKeyValueArrow = "360"
    let animKeyValueYOUME = "360YOUME"
    let animKeyDescription = "animationType"
    var meWin = false
    let myPrefs = appUserPrefs()
    
    var winImages : [UIImage] = []
    var audioPlayer : AVAudioPlayer!
    
    var winnerisMe = false
    var winnerisYou = false
    var yourScore = 0
    var myScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        loadImages()
        resetSeries()
        
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        updateScoreViews()
    }
    //MARK:- Build
    
    func playSoundWithFile(filename:String) {
        if let sound = NSDataAsset(name: filename) {
            do {
                audioPlayer = try AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            }catch{
                print("Error playng sound")
            }

        }
    }
    
    func loadImages() {
        for i in 1 ... 12 {
            winImages.append(UIImage(named: String(format: "winner%d", i))!)
        }
    }
    //MARK:- IBActions
    
    @IBAction func spinArrow(_ sender: Any) {
        if seriesFinished() {
            resetSeries()
        }else{
            settingsButton.isHidden = true
            spinButton.isHidden = true
        }
        
        
        let remainder = (1 + arc4random() % 100) % 2
       
        imgArrow.image = UIImage(named: remainder == 0 ? "3dbluearrowdown" : "3dbluuarrowup")
   
        meWin = (remainder == 0)
        
        spinView(vw: imgArrow, duration: 0.1, repeatTimes: 10.0, anKey: animKeyValueArrow)
        
        if (myPrefs.soundOn()) {
            playSoundWithFile(filename: "Drumroll")
            
        }
        
    }
    //MARK:-Game
    func resetSeries() {
        yourScore = 0
        myScore = 0
        settingsButton.isHidden = false
        updateScoreViews()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            spinArrow(self)
        }
    }
    func updateScoreViews() {
        imgMeScore.image=UIImage(named: String(format:"%d",myScore))
        imgYouScore.image=UIImage(named: String(format:"%d",yourScore))
        
            imgYouScore.isHidden = (myPrefs.getNoGames() == 1)
            imgMeScore.isHidden = (myPrefs.getNoGames() == 1)
        
    }
   
    func seriesFinished() -> Bool {
       
            var result = false
            
            if (myPrefs.getNoGames() == 1) {
                if (myScore == 1 || yourScore == 1) {
                    result = true
                }
            }else if (myPrefs.getNoGames() == 3) {
                if (myScore == 2 || yourScore == 2) {
                    result = true
                }
            }else {
                if (myScore == 3 || yourScore == 3) {
                    result = true
                }
            }
            return result;
        
    }
    
    func winnerIsMe() -> Bool {
        var result = false
        
        if seriesFinished() {
            result = myScore > yourScore ? true : false
        }
        return result
    
    }
    
    func winnerIsYou() -> Bool {
        var result = false
    
        if seriesFinished() {
            result = yourScore > myScore ? true : false
        }
        return result
    
    }
    
    //MARK:- Spinning
    func spinView(vw:UIImageView, duration:CFTimeInterval, repeatTimes:Float, anKey:String) {
        let fullRotation = CABasicAnimation(keyPath: animKey)
        fullRotation.delegate = self
        fullRotation.fromValue = 0
        fullRotation.toValue  = ((360 * Double.pi) / 180)
        fullRotation.isCumulative = true
        fullRotation.duration = duration
        fullRotation.repeatCount = repeatTimes
        fullRotation.setValue(anKey, forKey: animKeyDescription)
        vw.layer.add(fullRotation, forKey: anKey)
        
    }
    
    func animationDidStop(_ anim: CAAnimation,
                          finished flag: Bool) {
        
        spinButton.isHidden = false
        let sAnimDesc = anim.value(forKey: animKeyDescription) as! String
        
        if sAnimDesc == animKeyValueArrow {
            if meWin {
                myScore += 1
            }else{
                yourScore += 1
            }
            updateScoreViews()
            
            if seriesFinished() {
                spinView(vw:meWin ? meIconView : youIconView, duration: 0.6, repeatTimes: 6.0, anKey: animKeyValueYOUME)
                if (myPrefs.soundOn()) {
                    if meWin {
                        playSoundWithFile(filename:myPrefs.cheerForMe() ? "cheerbig" : "boobig" )
                    }else{
                        playSoundWithFile(filename:myPrefs.cheerForMe() ? "boobig" : "cheerbig" )
                    }
                    
                }
                showWinner()
                
            }
            
        }else{
            if sAnimDesc == animKeyValueYOUME {
                resetSeries()
            }
        }
    }
    func showWinner() {
       
        if let anView = meWin ? imgMeWinner : imgYouWinner {
            anView.animationImages = winImages
            anView.animationDuration=1.0
            anView.animationRepeatCount = 3
            anView.startAnimating()
        }
        

    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let vc = segue.destination as! SettingsViewController
        

    }
    
}
