//
//  SettingsViewController.swift
//  The Decider
//
//  Created by Mick Mossman on 13/11/18.
//  Copyright © 2018 Mick Mossman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let myPrefs = appUserPrefs()
    
    @IBOutlet weak var switchSounds: UISwitch!
    
    //@IBOutlet weak var segGamesInSeries: UISegmentedControl!
    
    @IBOutlet weak var vwSounds: UIView!
    
    @IBOutlet weak var vwGames: UIView!
    @IBOutlet weak var vwCheer: UIView!
    @IBOutlet weak var segGamesInSeries: UISegmentedControl!
    @IBOutlet weak var segCheerFor: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = .flipHorizontal
        navigationController?.navigationBar.isHidden = false
        showSelections()
    }
    
    func showSelections() {
        switchSounds.isOn = myPrefs.soundOn()
        
        //segGamesInSeries.selectedSegmentIndex = 2
        switch myPrefs.getNoGames() {
            case 1:
                segGamesInSeries.selectedSegmentIndex = 0
            case 3:
                segGamesInSeries.selectedSegmentIndex = 1
            case 5:
                segGamesInSeries.selectedSegmentIndex = 2
            default:
                segGamesInSeries.selectedSegmentIndex = 0
        }
        
        if myPrefs.cheerForMe() {
        
            segCheerFor.selectedSegmentIndex = 0
        }else{
            segCheerFor.selectedSegmentIndex = 1
        }
        
    }
    @IBAction func soundsUpdate(_ sender: UISwitch) {
        myPrefs.setSoundPref(pref: sender.isOn)
    }
    
    @IBAction func gamesUpdate(_ sender: UISegmentedControl) {
        var noGames = 1
        switch sender.selectedSegmentIndex {
        case 0:
            noGames = 1
        case 1:
            noGames = 3
        case 2:
            noGames = 5
        default:
            noGames = 1
        }
        myPrefs.setNoGames(nogames: noGames)
    }
    
    @IBAction func cheerUpdate(_ sender: UISegmentedControl) {
        myPrefs.setCheerFor(whocheer: sender.selectedSegmentIndex == 0 ? "ME" : "YOU")
    }
}
