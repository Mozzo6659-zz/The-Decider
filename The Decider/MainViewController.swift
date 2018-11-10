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
    
    @IBOutlet weak var youIconView: UIImageView!
    
    @IBOutlet weak var meIconView: UIImageView!
    
    @IBOutlet weak var imgMeScore: UIImageView!
    
    @IBOutlet weak var imgYouWinner: UIImageView!
    
    @IBOutlet weak var imgMeWinner: UIImageView!
    
    @IBOutlet weak var imgArrow: UIImageView!
    let animKey = "transform.rotation"
    
    let animKeyValueArrow = "360"
    
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
        loadImages()
        resetSeries()
        // Do any additional setup after loading the view, typically from a nib.
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
            //winImages.append(String(format: "winner%d", i))
            winImages.append(UIImage(contentsOfFile: String(format: "winner%d", i))!)
        }
    }
    //MARK:- IBActions
    
    @IBAction func spinArrow(_ sender: Any) {
        if seriesFinished() {
            resetSeries()
        }
        
        
        let remainder = (1 + arc4random() % 100) % 2
       
        imgArrow.image = UIImage(contentsOfFile: remainder == 0 ? "3dblueuarrowdown" : "3dbluuarrowup")
   
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
        updateScoreViews()
    }
    
    func updateScoreViews() {
        if myPrefs.getNoGames() > 1 {
            imgMeScore.image=UIImage(contentsOfFile: String(format:"%d",myScore))
            imgYouScore.image=UIImage(contentsOfFile: String(format:"%d",yourScore))
        }else{
            imgMeScore.image=nil
            imgYouScore.image=nil
        }
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
    func spinView(vw:UIImageView, duration:Double, repeatTimes:Float, anKey:String) {
        let fullRotation = CABasicAnimation(keyPath: animKey)
        fullRotation.delegate = self as? CAAnimationDelegate
        fullRotation.fromValue = 0
        fullRotation.toValue  = ((360 * Double.pi) / 180)
        fullRotation.duration = duration
        fullRotation.repeatCount = repeatTimes
        vw.layer.add(fullRotation, forKey: anKey)
    }
    
    func animationDidStop(_ anim: CAAnimation,
                          finished flag: Bool) {
        if anim.value(forKey: animKey) as! String == animKeyValueArrow {
            if meWin {
                myScore += 1
            }else{
                yourScore += 1
            }
            updateScoreViews()
            
            if seriesFinished() {
                
            }
            
        }
    }
}
/*
 -(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
 
 if (!spinningIons) {
 if (isUP) {
 yourScore += 1;
 [self updateYouView];
 }else {
 myScore += 1;
 [self updatemeView];
 }
 
 
 
 if (self.seriesFinished) {
 
 spinningIons = YES;
 [spinButton setHidden:YES];
 
 
[self spinView:meIconView];


if (playSound) {
    [self playSoundOnPlayer:!cheerForYou?  @"cheerbig": @"boobig" ofType:@"m4a"];
}

}else {
 
    [self spinView:youIconView];
    
    
    if (playSound) {
        [self playSoundOnPlayer:cheerForYou? @"cheerbig": @"boobig" ofType:@"m4a"];
    }
}

[self showWinner];

}else {
    
    if (playSound) {
        
        /*this is the yay or boo*/
        [self playSound:isUP];
    }
    
}


}else {
    
    [self resetSeries];
}
}
*/
