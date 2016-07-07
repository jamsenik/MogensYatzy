//
//  SViewController.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 02/07/16.
//
//

import Foundation
import UIKit

class SViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var currentRound: UILabel?
    @IBOutlet weak var Total1: UILabel?
    @IBOutlet weak var Total2: UILabel?
    @IBOutlet weak var Total3: UILabel?
    @IBOutlet weak var Total4: UILabel?
    @IBOutlet weak var Total5: UILabel?
    @IBOutlet weak var Total6: UILabel?
    @IBOutlet weak var Player1: UITextField?
    @IBOutlet weak var Player2: UITextField?
    @IBOutlet weak var Player3: UITextField?
    @IBOutlet weak var Player4: UITextField?
    @IBOutlet weak var Player5: UITextField?
    @IBOutlet weak var Player6: UITextField?
    @IBOutlet weak var Bonus1: UITextField?
    @IBOutlet weak var Bonus2: UITextField?
    @IBOutlet weak var Bonus3: UITextField?
    @IBOutlet weak var Bonus4: UITextField?
    @IBOutlet weak var Bonus5: UITextField?
    @IBOutlet weak var Bonus6: UITextField?
    @IBOutlet weak var Ones: UILabel?
    @IBOutlet weak var Twos: UILabel?
    @IBOutlet weak var Threes: UILabel?
    @IBOutlet weak var Fours: UILabel?
    @IBOutlet weak var Fives: UILabel?
    @IBOutlet weak var Sixes: UILabel?
    @IBOutlet weak var OnePair: UILabel?
    @IBOutlet weak var TwoPairs: UILabel?
    @IBOutlet weak var ThreePairs: UILabel?
    @IBOutlet weak var ThreeOfAKind: UILabel?
    @IBOutlet weak var FourOfAKind: UILabel?
    @IBOutlet weak var Castle: UILabel?
    @IBOutlet weak var SmallStright: UILabel?
    @IBOutlet weak var LargeStright: UILabel?
    @IBOutlet weak var Mogens: UIImageView?
    @IBOutlet weak var FullHouse: UILabel?
    @IBOutlet weak var Chance: UILabel?
    @IBOutlet weak var Yatzy: UILabel?
    @IBOutlet var allPlayButtons: [UIButton]?
    @IBOutlet var allDiceButtons: [UIButton]?
    
    
    var YatzySets : [YatzySet]
    var selectedPlayer : YatzySet;
    var selectedPlay : Int = 0;
    var selectedPlayButton : UIButton?
    var selectedBonus : UITextField?
    var selectedTotal : UILabel?
    var selectedNameLabel : UITextField?
    var currentPlay = YatzyRound(round: 0)
    var plays : [UIView]?
    
    required init?(coder aDecoder: NSCoder) {
        YatzySets = Array<YatzySet>();
        selectedPlayer = YatzySet()
        super.init(coder: aDecoder)
        Reset()
        
    }
    
    func Reset() -> Void {
        var prev : YatzySet? = nil;
        for _ in 0...5 {
            let current = YatzySet()
            YatzySets.append(current)
            current.Left = prev
            if (prev != nil) {
                prev!.Right = current
            }
            prev = current
        }
        selectedPlayer = YatzySets[0]
        
    }
    override func viewWillAppear(animated: Bool) {
        for button in allPlayButtons! {
            button.setTitle("", forState: .Normal)
            button.layer.cornerRadius = 4
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
        var p : [UIView] = Array()
        p.append(Ones!)
        p.append(Twos!)
        p.append(Threes!)
        p.append(Fours!)
        p.append(Fives!)
        p.append(Sixes!)
        p.append(OnePair!)
        p.append(TwoPairs!)
        p.append(ThreePairs!)
        p.append(ThreeOfAKind!)
        p.append(FourOfAKind!)
        p.append(Castle!)
        p.append(SmallStright!)
        p.append(LargeStright!)
        p.append(Mogens!)
        p.append(FullHouse!)
        p.append(Chance!)
        p.append(Yatzy!)
        plays = p
    }
    
    
    
    override func beginAppearanceTransition(isAppearing: Bool, animated: Bool) {
    }
    
    @IBAction func newGame(sender: UIButton) {
        // Initialize Alert View
        let alertView = UIAlertView(title: "Ægte nyt spil?",
                                    message: "Spillet forsvinder altså",
                                    delegate: self,
                                    cancelButtonTitle: "Nårh, nej",
                                    otherButtonTitles: "Ægte!")
        
        // Configure Alert View
        alertView.tag = 1
        
        // Show Alert View
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 1 {
            if buttonIndex == 1 {
                Reset()
            }
        }
    }
    
    @IBAction func playChosen(sender: UIButton) {
        if selectedPlayButton != nil {
            selectedPlayButton!.layer.borderColor = UIColor.lightGrayColor().CGColor
            selectedPlayButton!.layer.borderWidth = 1
            selectedPlayButton?.selected = false
        }
        
        let player = (sender.tag / 100) - 1
        let play = sender.tag % 100
        
        selectedPlayer = YatzySets[player]
        selectedPlay = play
        currentPlay = selectedPlayer.Rounds[play]
        currentRound?.text? = currentPlay.ToString()
        selectedBonus = GetBonus(player)
        selectedTotal = GetTotal(player)
        selectedNameLabel = GetNameLabel(player)
        
        selectedPlayButton = sender;
        selectedPlayButton!.layer.borderColor = UIColor.redColor().CGColor
        selectedPlayButton!.layer.borderWidth = 3
        selectedPlayButton?.selected = true
        DimSetPlays()
        
    }
    
    func DimSetPlays() {
        for i in 0..<18 {
            plays![i].alpha = selectedPlayer.Rounds[i].Blank() ? 1 : 0
        }
    }
    
    @IBAction func diceAdded(diceButton: UIButton) {
        let dice = Int(diceButton.currentTitle!)!
        currentPlay.Add(dice)
        
        updateScore()
    }
    
    @IBAction func scratch(dice: UIButton) {
        currentPlay.Scratch()
        updateScore()
    }
    
    @IBAction func backdice(dice: UIButton) {
        currentPlay.Back()
        updateScore()
    }
    
    func updateScore(){
        currentRound?.text? = currentPlay.ToString()
        let score : String = currentPlay.Blank() ? "" : currentPlay.Scratched ? "X" : String(currentPlay.Score())
        selectedPlayButton?.setTitle(score, forState: .Normal)
        selectedBonus?.text = String(selectedPlayer.GetBonus())
        selectedTotal?.text = String(selectedPlayer.GetScore())
        if (!selectedPlayer.Verify()){
            selectedNameLabel?.backgroundColor = UIColor.redColor()
        } else {
            selectedNameLabel?.backgroundColor = UIColor.whiteColor()
        }
        
    }
    
    func GetBonus(player : Int) -> UITextField {
        switch player {
        case 1:
            return Bonus1!
        case 2:
            return Bonus2!
        case 3:
            return Bonus3!
        case 4:
            return Bonus4!
        case 5:
            return Bonus5!
        case 6:
            return Bonus6!
        default:
            return Bonus1!
        }
    }
    
    func GetTotal(player : Int) -> UILabel {
        switch player {
        case 1:
            return Total1!
        case 2:
            return Total2!
        case 3:
            return Total3!
        case 4:
            return Total4!
        case 5:
            return Total5!
        case 6:
            return Total6!
        default:
            return Total1!
        }
    }
    
    func GetNameLabel(player : Int) -> UITextField {
        switch player {
        case 1:
            return Player1!
        case 2:
            return Player2!
        case 3:
            return Player3!
        case 4:
            return Player4!
        case 5:
            return Player5!
        case 6:
            return Player6!
        default:
            return Player1!
        }
    }

}
