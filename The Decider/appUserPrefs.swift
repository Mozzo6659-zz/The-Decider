//
//  appUserPrefs.swift
//  The Decider
//
//  Created by Mick Mossman on 10/11/18.
//  Copyright © 2018 Mick Mossman. All rights reserved.
//

import Foundation

class appUserPrefs {
    var defaults = UserDefaults.standard
    
    let DEFAULT_SOUND_PREF  = true
    let SOUND_KEY  = "SOUND"
    let NOGAME_KEY  = "NOGAMES"
    let DEFAULT_NOGAME_PREF = 1
    let CHEERFOR_KEY = "CHEERFOR"
    let DEFAULT_CHEERFOR_PREF  = "ME"


    func setSoundPref(pref:Bool) {
        defaults.set(pref, forKey: SOUND_KEY)
    }
    func soundOn() ->Bool {
        var soundpref = DEFAULT_SOUND_PREF
        
        if let usersoundpref  = defaults.object(forKey: SOUND_KEY) as? Bool {
            soundpref = usersoundpref
        }
        
        return soundpref

    }
    
    func setNoGames(nogames:Int) {
        defaults.set(nogames, forKey: NOGAME_KEY)
    }
    
    func getNoGames() -> Int {
        var nogames = DEFAULT_NOGAME_PREF
        
        if let usernogames = defaults.object(forKey: NOGAME_KEY) as? Int {
            nogames = usernogames
        }
        return nogames
    }
    
    func setCheerFor(whocheer:String) {
        defaults.set(whocheer, forKey: CHEERFOR_KEY)
    }
    
    func cheerForMe() -> Bool {
        if let cheerfor = defaults.object(forKey: CHEERFOR_KEY) as? String {
            return (cheerfor == "ME")
        }else{
            return true
        }
    }
}
