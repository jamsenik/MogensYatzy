//
//  YatzySet.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 02/07/16.
//
//

import Foundation

class YatzySet{
    let BONUS = 50;
    
    var Rounds: [Round]
    var Left: YatzySet?
    var Right: YatzySet?
    var PlayerName : String = ""
    
    init(){
        Rounds = Array()
        for r in 1...6 {
            Rounds.append(UpperRound(kind: r))
        }
        Rounds.append(PatternRound(pattern: [2]))
        Rounds.append(PatternRound(pattern: [2, 2]))
        Rounds.append(PatternRound(pattern: [2, 2, 2]))
        Rounds.append(PatternRound(pattern: [3]))
        Rounds.append(PatternRound(pattern: [4]))
        Rounds.append(PatternRound(pattern: [3, 3]))
        Rounds.append(FixedRound(pattern: [1, 2, 3, 4, 5]))
        Rounds.append(FixedRound(pattern: [2, 3, 4, 5, 6]))
        Rounds.append(FixedRound(pattern: [1, 2, 3, 4, 5, 6], bonus: 9))
        Rounds.append(PatternRound(pattern: [3, 2]))
        Rounds.append(Round())
        Rounds.append(PatternRound(pattern: [6], bonus: 100))
    }
    
    func Verify() -> Bool {
        let p = RoundsPlayed()
        if (Left != nil && p != 0){
            let l = Left!.RoundsPlayed()
            if (l != p && l != p + 1) {
                return false
            }
        }
        
        
        if (Right != nil){
            let r = Right!.RoundsPlayed()
            if (r != 0){
                if (r != p - 1 && r != p){
                    return false
                }
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
        var bonus : Int = 0;
        for r in Rounds{
            bonus += r.GetBonus()
        }
        return bonus >= 0 && IsTopSet() ? BONUS : 0
    }
    
    
    func IsTopSet() -> Bool {
        return PlayedTopRounds().count == 6
    }
    
    func PlayedRounds() -> [Round] {
        return Rounds.filter({!$0.Blank()})
    }
    
    func PlayedTopRounds() -> [Round] {
        return Rounds[0...5].filter({!$0.Blank()})
    }
    
    class func  MaxInput(play : Int) -> Int {
        return 4
    }
}
