//
//  ViewController.m
//  HelloWorld
//
//  Created by Hans Kyndesgaard on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "YatzySet.h"

@interface ViewController ()
{
    NSArray *YSets; 
    NSArray *Bonuses;
    NSArray *Totals;
    NSArray *Plays;
    UIFont *diceFont;
    YatzySet *selectedPlayer;
    int selectedPlay;
    UITextField *selectedBonus;
    UITextField *selectedTotal;
    UIButton *selectedPlayButton;
}

@end

@implementation ViewController
@synthesize entireView;
@synthesize Total1;
@synthesize Total2;
@synthesize Total3;
@synthesize Total4;
@synthesize Total5;
@synthesize Total6;
@synthesize Bonus1;
@synthesize Bonus2;
@synthesize Bonus3;
@synthesize Bonus4;
@synthesize Bonus5;
@synthesize Bonus6;
@synthesize Play0;
@synthesize Play1;
@synthesize Play2;
@synthesize Play3;
@synthesize Play4;
@synthesize Play5;
@synthesize Play6;
@synthesize Play7;
@synthesize Play8;
@synthesize Play9;
@synthesize Play10;
@synthesize Play11;
@synthesize Play12;
@synthesize Play13;
@synthesize Play14;
@synthesize Play15;
@synthesize Play16;
@synthesize Play17;
@synthesize Play18;
@synthesize DicePicker;
@synthesize allPlayButtons;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reset];
    
    Bonuses = [NSArray arrayWithObjects: Bonus1, Bonus2, Bonus3, Bonus4, Bonus5, Bonus6,nil];
    Totals = [NSArray arrayWithObjects: Total1, Total2, Total3, Total4, Total5, Total6, nil];
    Plays = [NSArray arrayWithObjects: Play0, Play1, Play2, Play3, Play4, Play5, Play6, Play7,
             Play8, Play9, Play10, Play11, Play12, Play13, Play14, Play15, Play16, Play17, Play18, nil];    

 	// Do any additional setup after loading the view, typically from a nib.
    diceFont = [UIFont fontWithName:@"dice" size:36];
    
}

- (void) reset{
    YSets = [NSArray arrayWithObjects:[YatzySet alloc], [YatzySet alloc],
             [YatzySet alloc], [YatzySet alloc], [YatzySet alloc], [YatzySet alloc],nil];
    
    YatzySet *prev = nil;
    for (YatzySet *current in YSets) {
        [current init];
        [current setLeftSet:prev];
        if (prev != nil) {
            [prev setRightSet:current];
        }
        prev = current;
        
    }
    
    for (UIButton *button in allPlayButtons) {
        [button setTitle:@" " forState:UIControlStateNormal];
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    //Set bonus
    for (UITextField *bonus in Bonuses){
        bonus.text = @"0";
        bonus.layer.cornerRadius = 2;
        bonus.layer.borderWidth = 1;
        bonus.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
    //Set total
    for (UITextField *total in Totals){
        total.text = @"0";
    }
    
    //Highlight plays
    for (UITextField *play in Plays){
        play.highlighted = YES;
    }

}

- (void)viewDidUnload
{
    [self setTotal1:nil];
    [self setBonus1:nil];
    [self setBonus2:nil];
    [self setBonus3:nil];
    [self setBonus4:nil];
    [self setBonus5:nil];
    [self setBonus6:nil];
    [self setTotal2:nil];
    [self setTotal3:nil];
    [self setTotal4:nil];
    [self setTotal5:nil];
    [self setTotal6:nil];
    [self setPlay0:nil];
    [self setPlay15:nil];
    [self setEntireView:nil];
    [self setAllPlayButtons:nil];
    [self setDicePicker:nil];
    [self setPlayer1:nil];
    [self setAllPlayButtons:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}


- (IBAction)newGame:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Ægte nyt spil?"
                          message: @"Det gamle spil forsvinder altså"
                          delegate: self
                          cancelButtonTitle:@"Nårh, nej"
                          otherButtonTitles:@"Ægte!",nil];
    [alert show];
}

- (IBAction)playChosen:(UIButton *)sender {
    [self.view endEditing:YES];
    
    selectedPlayButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    selectedPlayButton.layer.borderWidth = 1;

    //selectedPlayButton.selected = NO;
    
    DicePicker.hidden = NO;
    
    int player = (sender.tag / 100) - 1 ;
    int play = sender.tag % 100;

    selectedPlayer = [YSets objectAtIndex:player];
    selectedPlay = play;
    selectedBonus = [Bonuses objectAtIndex:player];
    selectedTotal = [Totals objectAtIndex:player];
    selectedPlayButton = sender;

    selectedPlayButton.layer.borderColor = [UIColor redColor].CGColor;
    selectedPlayButton.layer.borderWidth = 3;
    //selectedPlayButton.selected = YES;
    
    for (int i = 0; i < 19; i++){
        UILabel *playLabel = [Plays objectAtIndex:i];
        BOOL isset = [selectedPlayer isSet:i];
        BOOL toHighlight = !isset;
        [playLabel setHighlighted:toHighlight];
    
    }
    
    if ([selectedPlayer isSet:15]){
        Play15.alpha = 0;
    } else{
        Play15.alpha = 1;
    }
    [DicePicker reloadAllComponents];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 1){
        return;
    }
    [self reset];    
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (selectedPlayer == Nil) {
        return 0;
    } else {
        return [selectedPlayer getPlayInputColumns:selectedPlay];
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (selectedPlayer == Nil) {
        return 0;
    } else {
        return [selectedPlayer getPlayInputRows:selectedPlay column:component];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    int score = 0;
    NSString *title;
    
    if (component == 0 && row == 0){
        score = 0;
        [selectedPlayer unsetPlay:selectedPlay];
        title = @"";
    } else {
        
        if (component == 0 && row == 1){
            score = 0;
            if (selectedPlay < 5){
                score = -4 * (selectedPlay +1);
            }
            title = @"X";
        } else {
            for (int c = 0; c < [selectedPlayer getPlayInputColumns:selectedPlay]; c++){
                NSString *dices = [selectedPlayer getPlayInputText:selectedPlay column:c row:[pickerView selectedRowInComponent:c]];
                for (int d = 0; d < dices.length; d++) {
                    score += [dices characterAtIndex:d] - '0';
                }
            }
            if (selectedPlay < 6){
                score -= 4 * (selectedPlay + 1);
            }
            if (selectedPlay == 15){
                score = 30;
            }
            if (selectedPlay == 18){
                score += 100;
            }
            title = [NSString stringWithFormat:@"%d", score];
        }
        
        if (![selectedPlayer setPlay:selectedPlay score:score]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Wait"
                                  message:@"Noget er galt med rækkefølgen"
                                  delegate:self cancelButtonTitle:@"Den fikser jeg lige"
                                  otherButtonTitles:nil];
            [alert show];
        };
        
        
    }

    
    
    [selectedPlayButton setTitle:title forState:UIControlStateNormal];
    [selectedTotal setText:[NSString stringWithFormat:@"%d", [selectedPlayer getScore]]];
    if ([selectedPlayer topCompleted]){
        int bonus = [selectedPlayer getBonus];
        [selectedBonus setText:[NSString stringWithFormat:@"%d", bonus]];
    } else {
        int bonus = [selectedPlayer getTopScore];
        [selectedBonus setText:[NSString stringWithFormat:@"(%d)", bonus]];
    }

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        tView.font = diceFont;
        
    };
    
    tView.text = [selectedPlayer getPlayInputText:selectedPlay column:component row:row];
    // Fill the label text here
    return tView;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textfield{
    [textfield resignFirstResponder];
    return YES;
}
@end
