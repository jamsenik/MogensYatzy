//
//  YatzySet.m
//  HelloWorld
//
//  Created by Hans Kyndesgaard on 21/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YatzySet.h"
const int MAX_PLAYS = 20;
const int BONUS = 50;
const int BONUS_LIMIT = 0;
const int INPUT_COLUMNS[] = {1, 1, 1, 1, 1, 1, 0,
                             1, 2, 3, 1, 1, 2,
                             1, 1, 1, 2, 6, 1};


@implementation YatzySet{
    int scores[MAX_PLAYS];
    BOOL set[MAX_PLAYS];
    int roundsPlayed;
    YatzySet *left;
    YatzySet *right;
}
-(id) init{
    self = [super init];
    for (int i = 0; i < MAX_PLAYS; i++) {
        scores[i] = 0;
        set[i] = NO;
    }
    roundsPlayed = 0;
    return self;
}

-(int)getScore{
    int score = 0;
    for (int i = 0; i < MAX_PLAYS; i++) {
        score += scores[i];
    } 
    return score;
}

-(int)getTopScore{
    int score = 0;
    for (int i = 0; i < 6; i++) {
        score += scores[i];
    }
    return score;
}

-(int)getBonus{
    return scores[6];
}

-(BOOL) setPlay:(int) play score:(int)score{
    if (play < 0 || play >= MAX_PLAYS || play == 6){
        return NO;
    }
    
    if (!set[play] && left != nil && [left getRoundsPlayed] != [self getRoundsPlayed] + 1){
        return NO;
    }

    if (right != nil){
        int rightPlayed = [right getRoundsPlayed];
        if (!set[play] && rightPlayed != roundsPlayed && rightPlayed != 0){
        return NO;
        }
    }
    
    if(!set[play]){
        roundsPlayed++;
        set[play] = YES;
    }
    scores[play] = score;
    
    if (set[0] && set[1] && set[2] && set[3] && set[4] && set[5]){
        if (scores[0] + scores[1] + scores[2] +scores[3] + scores[4] + scores[5] >= BONUS_LIMIT){
            scores[6] = BONUS;
        } else {
            scores[6] = 0;
        };
        set[6] = YES;
    }
    
    return YES;
}

-(void) setPlayer:(NSString *)name{
    player = name;
}

-(void) unsetPlay:(int) play {
    if (play < 0 || play >= MAX_PLAYS || play == 6){
        return;
    }
    if(set[play]){
        scores[play] = 0;
        set[play] = NO;
        roundsPlayed--;
    }
    
    if (set[6] && play < 6) {
        scores[6] = 0;
        set[6] = NO;
    }
}

-(BOOL) isSet:(int) play;{
    return set[play];
}

-(BOOL) topCompleted{
    return set[0] && set[1] && set[2] && set[3] && set[4] && set[5];
}

-(int) getRoundsPlayed{
    return roundsPlayed;
}

-(void) setLeftSet:(YatzySet*) theSet{
    left = theSet;
}

-(void) setRightSet:(YatzySet*) theSet{
    right = theSet;
}

-(int) getPlayInputColumns:(int) play{
    return INPUT_COLUMNS[play];
}

-(int) getPlayInputRows:(int) play column:(int)column{
    int rows = 0;
    if (column == 0){
        rows = 2;
    }
    if (play == 13 || play == 14 || play == 15){
        rows += 1;
    } else {
        rows += 6;
    }
    return rows;
}

-(NSString *) getPlayInputText:(int) play column:(int)column row:(int)row{
    NSString *result = @"";
    if( column == 0){
        if (row == 0){
            return @" ";
        } else if (row == 1){
            return @"X";
        } else {
            row -= 2;
        }
    
    }
    if (play < 6){
        for(int i = 0; i <= row; i++){
            result = [result stringByAppendingString: [NSString stringWithFormat:@"%d", play+1]];
        }
    } else if (play == 7 || play == 8 || play == 9 || (play == 16 && column == 0)){
        result = [result stringByAppendingString: [NSString stringWithFormat:@"%d%d", row+1, row+1]];
    } else if (play == 10 || play == 12 || (play == 16 && column == 1)){
        result = [result stringByAppendingString: [NSString stringWithFormat:@"%d%d%d", row+1, row+1, row+1]];
    } else if (play == 11){
        result = [result stringByAppendingString: [NSString stringWithFormat:@"%d%d%d%d", row+1, row+1, row+1, row+1]];
    } else if (play == 11){
        result = [result stringByAppendingString: [NSString stringWithFormat:@"%d%d%d%d", row+1, row+1, row+1, row+1]];
    } else if (play == 13){
        result = @"12345";
    } else if (play == 14){
        result = @"23456";
    } else if (play == 15){
        result = @"123456";
    } else if (play == 17){
        result = [NSString stringWithFormat:@"%d", row+1];
    } else if (play == 18){
        result = [NSString stringWithFormat:@"%d%d%d%d%d%d", row+1, row+1, row+1, row+1, row+1, row+1];
    } else {
        result = [NSString stringWithFormat:@"%d%d%d", play, column, row];
    }
    return result;
}

@end
