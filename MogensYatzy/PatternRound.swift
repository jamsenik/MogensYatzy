//
//  PatternRound.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 12/07/16.
//
//

import Foundation

class PatternRound : Round{
    let pattern : [Int]
    var kind : [Int]
    var index = 0
    var bonus = 0
    
    init(pattern: [Int], bonus : Int = 0) {
        self.pattern = pattern
        kind = Array(count: pattern.count, repeatedValue: 0)
        self.bonus = bonus
        super.init()
    }
    
    override func Add(dice:Int){
        if (IsAPreviousValue(dice) || index >= pattern.count){
            return
        }
        for _ in 1 ... pattern[index]{
            super.Add(dice)
        }
        kind[index] = dice
        index += 1
    }
    
    override func CanBeNext(v : Int) -> Bool{
        return super.CanBeNext(v) && !IsAPreviousValue(v) && index < pattern.count
    }
    
    func IsAPreviousValue(d : Int) -> Bool {
        return kind.contains(d)
    }
    
    override func Clear(){
        super.Clear()
        kind = Array(count: pattern.count, repeatedValue: 0)
        index = 0
    }
    
    override func Back(){
        if (index ==  0){
            Clear()
            return
        }
        index -= 1
        kind[index] = 0
        for _ in 1...pattern[index] {
            super.Back()
        }
    }
    
    override func Score() -> Int {
        return (index == pattern.count ? bonus : 0 ) + super.Score()
    }

    override func Scratch() {
        Clear()
        super.Scratch()
    }
    
    override func IsIncomplete() -> Bool{
        return index != 0 && index < pattern.count
    }
    
}