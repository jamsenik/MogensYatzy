//
//  YatzyRound.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 02/07/16.
//
//

import Foundation

class Round{
    var Cubes: [Int] = Array()
    var Scratched = false
   
    init(){
    }
    
    func Score() -> Int {
        if Scratched {
            return 0
        }
        var score = 0
        for c in Cubes {
            score += c
        }
        return score
    }
    
    func Blank() -> Bool{
        return Cubes.count == 0 && !Scratched;
    }
    
    func Add(dice:Int){
        Cubes.append(dice)
        Scratched = false
    }
    
    func Scratch() {
        Cubes = Array()
        Scratched = true;
    }
    
    func Clear(){
        Cubes = Array()
        Scratched = false;
    }
    
    func Back(){
        if (Cubes.count > 0){
            Cubes.removeLast()            
        }
        if (Scratched){
            Clear()
        }
    }
    
    func ToString() -> String {
        if Scratched {
            return "X"
        }
        return Cubes.map({String($0)}).reduce("", combine: {$0 + String($1)})
    }
    
    func GetBonus() -> Int {
        return 0
    }
    
    func CanBeNext(v : Int) -> Bool{
        return Cubes.count < 6
    }
    
    func IsIncomplete() -> Bool{
        return (Cubes.count > 0) && (Cubes.count < 6)
    }
}
