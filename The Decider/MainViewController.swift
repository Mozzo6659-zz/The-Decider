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
    
    var winImages : [UIImage] = []
    var audioPlayer : AVAudioPlayer!
    
    var winnerisMe = false
    var winnerisYou = false
    var nogames = 1
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
        
        
        spinView(vw: imgArrow, duration: 0.1, repeatTimes: 10.0, anKey: "360")
        
        
//        if (playSound) {
//            [self playSoundOnPlayer:@"Drumroll" ofType:@"m4a"]
//        }
        
    }
    //MARK:-Game
    func resetSeries() {
        yourScore = 0
        myScore = 0
        updateScoreViews()
    }
    
    func updateScoreViews() {
        if nogames > 1 {
            imgMeScore.image=UIImage(contentsOfFile: String(format:"%d",myScore))
            imgYouScore.image=UIImage(contentsOfFile: String(format:"%d",yourScore))
        }else{
            imgMeScore.image=nil
            imgYouScore.image=nil
        }
    }
   
    func seriesFinished() -> Bool {
       
            var result = false
            
            if (nogames == 1) {
                if (myScore == 1 || yourScore == 1) {
                    result = true
                }
            }else if (nogames == 3) {
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
    //MARK:- Spinning
    func spinView(vw:UIImageView, duration:Double, repeatTimes:Float, anKey:String) {
        let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.delegate = self as? CAAnimationDelegate
        fullRotation.fromValue = 0
        fullRotation.toValue  = ((360 * Double.pi) / 180)
        fullRotation.duration = duration
        fullRotation.repeatCount = repeatTimes
        vw.layer.add(fullRotation, forKey: anKey)
    }
}
/*
 -(void)spin {
 //youWinnerView.animationImages = nil;
 
 if (self.seriesFinished) {
 [self resetSeries];
 }
 
 int remainder;
 
 rnd =  1 + arc4random() % 100;
 remainder = rnd % 2;
 
 
 if (remainder == 0) {
 
 if (arrowUpView.superview == nil) {
 arrowUpView.center = arrowDownView.center;
 [arrowDownView removeFromSuperview];
 [self.view addSubview:arrowUpView];
 
 }
 arrowView = arrowUpView;
 isUP = YES;
 }else {
 if (arrowDownView.superview == nil) {
 arrowDownView.center = arrowUpView.center;
 [arrowUpView removeFromSuperview];
 [self.view addSubview:arrowDownView];
 
 }
 arrowView = arrowDownView;
 isUP = NO;
 }
 
 
 CABasicAnimation *fullRotation;
 
 fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
 
 [fullRotation setDelegate:self];
 
 fullRotation.fromValue = [NSNumber numberWithFloat:0];
 
 fullRotation.toValue = [NSNumber numberWithFloat:((360* M_PI)/180)];
 
 fullRotation.duration = 0.1;
 
 fullRotation.repeatCount = 10;
 
 spinningIons = NO;
 [arrowView.layer addAnimation:fullRotation forKey:@"360"];
 
 if (playSound) {
 [self playSoundOnPlayer:@"Drumroll" ofType:@"m4a"];
 }
 */

