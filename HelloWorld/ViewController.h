//
//  ViewController.h
//  HelloWorld
//
//  Created by Hans Kyndesgaard on 20/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate, UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *Player1;
@property (weak, nonatomic) IBOutlet UILabel *Total1;
@property (weak, nonatomic) IBOutlet UILabel *Total2;
@property (weak, nonatomic) IBOutlet UILabel *Total3;
@property (weak, nonatomic) IBOutlet UILabel *Total4;
@property (weak, nonatomic) IBOutlet UILabel *Total5;
@property (weak, nonatomic) IBOutlet UILabel *Total6;
@property (weak, nonatomic) IBOutlet UITextField *Bonus1;
@property (weak, nonatomic) IBOutlet UITextField *Bonus2;
@property (weak, nonatomic) IBOutlet UITextField *Bonus3;
@property (weak, nonatomic) IBOutlet UITextField *Bonus4;
@property (weak, nonatomic) IBOutlet UITextField *Bonus5;
@property (weak, nonatomic) IBOutlet UITextField *Bonus6;
@property (weak, nonatomic) IBOutlet UILabel *Play0;
@property (weak, nonatomic) IBOutlet UILabel *Play1;
@property (weak, nonatomic) IBOutlet UILabel *Play2;
@property (weak, nonatomic) IBOutlet UILabel *Play3;
@property (weak, nonatomic) IBOutlet UILabel *Play4;
@property (weak, nonatomic) IBOutlet UILabel *Play5;
@property (weak, nonatomic) IBOutlet UILabel *Play6;
@property (weak, nonatomic) IBOutlet UILabel *Play7;
@property (weak, nonatomic) IBOutlet UILabel *Play8;
@property (weak, nonatomic) IBOutlet UILabel *Play9;
@property (weak, nonatomic) IBOutlet UILabel *Play10;
@property (weak, nonatomic) IBOutlet UILabel *Play11;
@property (weak, nonatomic) IBOutlet UILabel *Play12;
@property (weak, nonatomic) IBOutlet UILabel *Play13;
@property (weak, nonatomic) IBOutlet UILabel *Play14;
@property (weak, nonatomic) IBOutlet UIImageView *Play15;
@property (weak, nonatomic) IBOutlet UILabel *Play16;
@property (weak, nonatomic) IBOutlet UILabel *Play17;
@property (weak, nonatomic) IBOutlet UILabel *Play18;
- (IBAction)newGame:(id)sender;
- (IBAction)playChosen:(UIButton *)sender;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allPlayButtons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *entireView;
@property (strong, nonatomic) IBOutlet UIPickerView *DicePicker;
@end
