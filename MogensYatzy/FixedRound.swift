//
//  FixedRound.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 13/07/16.
//
//

import Foundation

class FixedRound : Round{
    let pattern : [Int]
    var set = false
    var bonus = 0
    
    init(pattern: [Int], bonus : Int = 0) {
        self.pattern = pattern
        self.bonus = bonus
        super.init()
    }
    
    override func Add(dice:Int){
        if (!pattern.contains(dice) || set){
            return
        }
        for d in pattern{
            super.Add(d)
        }
        set = true
    }
    
    override func CanBeNext(v : Int) -> Bool{
        return !set && pattern.contains(v)
    }
    
    
    override func Clear(){
        super.Clear()
        set = false
    }
    
    override func Back(){
        for _ in pattern {
            super.Back()
        }
        set = false
    }
    
    override func Scratch() {
        super.Scratch()
        set = false
    }
    
    override func Score() -> Int {
        return (set ? bonus : 0) + super.Score()
    }
    
    override func IsIncomplete() -> Bool{
        return false
    }
    
}