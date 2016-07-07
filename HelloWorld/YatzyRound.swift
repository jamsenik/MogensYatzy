//
//  YatzyRound.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 02/07/16.
//
//

import Foundation

class YatzyRound{
    var Cubes: [Int] = Array()
    var Scratched = false
    var round : Int
    
    init(round : Int){
        self.round = round
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
    }
    
    func ToString() -> String {
        if Scratched {
            return "X"
        }
        return Cubes.map({String($0)}).reduce("", combine: {$0 + String($1)})
    }
}
