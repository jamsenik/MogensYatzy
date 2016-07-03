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
    @IBOutlet weak var Bonus1: UITextField?
    @IBOutlet weak var Bonus2: UITextField?
    @IBOutlet weak var Bonus3: UITextField?
    @IBOutlet weak var Bonus4: UITextField?
    @IBOutlet weak var Bonus5: UITextField?
    @IBOutlet weak var Bonus6: UITextField?
    @IBOutlet weak var Play0: UILabel?
    @IBOutlet weak var Play1: UILabel?
    @IBOutlet weak var Play2: UILabel?
    @IBOutlet weak var Play3: UILabel?
    @IBOutlet weak var Play4: UILabel?
    @IBOutlet weak var Play5: UILabel?
    @IBOutlet weak var Play6: UILabel?
    @IBOutlet weak var Play7: UILabel?
    @IBOutlet weak var Play8: UILabel?
    @IBOutlet weak var Play9: UILabel?
    @IBOutlet weak var Play10: UILabel?
    @IBOutlet weak var Play11: UILabel?
    @IBOutlet weak var Play12: UILabel?
    @IBOutlet weak var Play13: UILabel?
    @IBOutlet weak var Play14: UILabel?
    @IBOutlet weak var Play15: UIImageView?
    @IBOutlet weak var Play16: UILabel?
    @IBOutlet weak var Play17: UILabel?
    @IBOutlet weak var Play18: UILabel?
    @IBOutlet var allPlayButtons: [UIButton]?
    @IBOutlet var allDiceButtons: [UIButton]?
    
    
    var YatzySets : [YatzySet]
    var selectedPlayer : YatzySet;
    var selectedPlay : Int = 0;
    var selectedPlayButton : UIButton?
    var selectedBonus : UITextField?
    var selectedTotal : UILabel?
    var currentPlay = YatzyRound(round: 0)
    
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
        
        //DicePicker.hidden = NO;
        
        let player = (sender.tag / 100) - 1 ;
        let play = sender.tag % 100;
        
        selectedPlayer = YatzySets[player]
        selectedPlay = play
        currentPlay = selectedPlayer.Rounds[play]
        currentRound?.text? = currentPlay.ToString()
        selectedBonus = GetBonus(player)
        selectedTotal = GetTotal(player)
        //selectedBonus = [Bonuses objectAtIndex:player];
        //selectedTotal = [Totals objectAtIndex:player];
        
        selectedPlayButton = sender;
        selectedPlayButton!.layer.borderColor = UIColor.redColor().CGColor
        selectedPlayButton!.layer.borderWidth = 3
        selectedPlayButton?.selected = true
        
        //        for (int i = 0; i < 19; i++){
        //            UILabel *playLabel = [Plays objectAtIndex:i];
        //            BOOL isset = [selectedPlayer isSet:i];
        //            BOOL toHighlight = !isset;
        //            [playLabel setHighlighted:toHighlight];
        //
        //        }
        //
        //        if ([selectedPlayer isSet:15]){
        //            Play15.alpha = 0;
        //        } else{
        //            Play15.alpha = 1;
        //        }
        //        [DicePicker reloadAllComponents];
        //        for (int i = 0; i < DicePicker.numberOfComponents; i++) {
        //            [DicePicker selectRow:0 inComponent:i animated:true];
        //        }
        
    }
    
    @IBAction func diceAdded(diceButton: UIButton) {
        let dice = Int(diceButton.currentTitle!)!
        currentPlay.Add(dice)
        if (!selectedPlayer.Verify()){
            currentPlay.Clear()
        }
        updateScore()
    }
    
    @IBAction func scratch(dice: UIButton) {
        currentPlay.Scratch()
        if (!selectedPlayer.Verify()){
            currentPlay.Clear()
        }
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

}
