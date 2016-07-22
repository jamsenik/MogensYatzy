//
//  UpperYatzyRound.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 12/07/16.
//
//

import Foundation

class UpperRound : Round{
    let kind : Int
    
    init(kind: Int) {
        self.kind = kind
        super.init()
    }
    
     override func Add(dice:Int){
        if (dice == kind) {
            super.Add(dice)
        }
    }
    
    override func Score() -> Int {
        
        return super.Score() - 4 * kind
    }
    
    override func GetBonus() -> Int {
        return Score()
    }

    override func CanBeNext(v : Int) -> Bool{
        return super.CanBeNext(v) && v == kind;
    }

    override func IsIncomplete() -> Bool{
        return false
    }
}