//
//  YatzySet.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 02/07/16.
//
//

import Foundation

class YatzySet{
    let MAX_PLAYS = 19;
    let BONUS = 50;
    let BONUS_LIMIT = 0;
        
    var Rounds: [YatzyRound]
    var Left: YatzySet?
    var Right: YatzySet?
    var PlayerName : String = ""
    
    init(){
        Rounds = Array()
        for r in 0...MAX_PLAYS {
            Rounds.append(YatzyRound(round: r))
        }
    }
    
    func Verify() -> Bool {
        if (Left != nil){
            if (Left!.RoundsPlayed() != RoundsPlayed()) {
                return false
            }
        }
        if (Right != nil && Right?.PlayedRounds().count != 0){
            if (Right!.RoundsPlayed() != RoundsPlayed() - 1){
                return false
            }
        }
        return true
    }
    
    func RoundsPlayed() -> Int {
        return PlayedRounds().count
    }
    
    func GetScore() -> Int {
        return PlayedRounds().reduce(0) {$0 + ($1.Score())} + GetBonus()
    }

    func GetBonus() -> Int {
        return GetTopScore() >= BONUS_LIMIT ? BONUS : 0
    }

    
    func GetTopScore() -> Int {
        return PlayedTopRounds().reduce(0) {$0 + ($1.Score())}
    }

    
    func IsTopSet() -> Bool {
        return PlayedTopRounds().count == 6
    }
    
    func PlayedRounds() -> [YatzyRound] {
        return Rounds.filter({!$0.Blank()})
    }

    func PlayedTopRounds() -> [YatzyRound] {
        return Rounds[0...5].filter({!$0.Blank()})
    }

    class func  MaxInput(play : Int) -> Int {
        return 4
    }
}
