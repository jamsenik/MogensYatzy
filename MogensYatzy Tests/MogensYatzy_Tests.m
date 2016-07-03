//
//  MogensYatzy_Tests.m
//  MogensYatzy Tests
//
//  Created by Hans Kyndesgaard on 31/01/14.
//
//

#import <XCTest/XCTest.h>
#import "YatzySet.h"

@interface MogensYatzy_Tests : XCTestCase

@end

@implementation MogensYatzy_Tests



- (void)setUp
{
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFillAll
{
    BOOL res;
    YatzySet *ys;
    
    ys = [[YatzySet alloc] init];
    XCTAssertTrue([ys getScore] == 0);
    
    int scores[] =
    {0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0,
        0, 0};
    
    
    for (int play = 0; play < 20; play++) {
        if (play != 6){
            res = [ys setPlay:play score:scores[play]];
            XCTAssertTrue([ys getTopScore] == 0, @"Top score not zero. Top score is: %i", [ys getTopScore]);
            XCTAssertTrue(res, @"Setting top score failed for play %i", play);
            if (play >= 5){
                XCTAssertTrue([ys getBonus] == 50);
                XCTAssertTrue([ys getScore] == 50, @"Score not fifty. Score is: %i", [ys getScore]);
                XCTAssert([ys topCompleted], @"Top is marked as not complete");
            } else {
                XCTAssertTrue([ys getBonus] == 0);
                XCTAssertTrue([ys getScore] == 0, @"Score not zero. Score is: %i", [ys getScore]);
                XCTAssert(![ys topCompleted], @"Top is marked as complete");
            }
        }
    }
    
    
    
    
    
}

@end
