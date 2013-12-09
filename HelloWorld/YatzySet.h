//
//  YatzySet.h
//  HelloWorld
//
//  Created by Hans Kyndesgaard on 21/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YatzySet : NSObject {
    NSString  *player;
    int nams;
}
-(int) getScore;
-(int) getTopScore;
-(int) getBonus;
-(BOOL) topCompleted;
-(BOOL) setPlay:(int) play score:(int)score;
-(void) unsetPlay:(int) play;
-(BOOL) isSet:(int) play;
-(int) getRoundsPlayed;
-(void) setLeftSet:(YatzySet *) theSet;
-(void) setRightSet:(YatzySet *) theSet;
-(int) getPlayInputColumns:(int) play;
-(int) getPlayInputRows:(int) play column:(int)column;
-(NSString *) getPlayInputText:(int) play column:(int)column row:(int)row;
 @end
