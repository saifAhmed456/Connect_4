//
//  Connect_4_goldTest.m
//  Connect 4 goldTest
//
//  Created by Shaik A S on 28/01/19.
//  Copyright © 2019 SHAIK AS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ConnectFourGoldGame.h"

@interface Connect_4_goldTest : XCTestCase
@property (strong,nonatomic) ConnectFourGoldGame * game;
@end

@implementation Connect_4_goldTest
-(ConnectFourGoldGame *) game {
    if (!_game){
        _game = [[ConnectFourGoldGame alloc]init];
    }
    return _game;
}
- (void)setUp {
   // self.game = [[ConnectFourGoldGame alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    self.game = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    for (int i = 36;i<39;i++)
    {
        [self.game updateGameArray:i player:0];
    }
    NSInteger bestMove = [self.game findBestMove];
    XCTAssert(35 == bestMove || 39== bestMove, "this is not the best move");
    self.game = nil;
    for (int i=36;i<40;i++) {
        [self.game updateGameArray:i player:0];
    }
    XCTAssert([self.game isGameOver], "error in Game over function ");
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
