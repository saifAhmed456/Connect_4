//
//  ConnectFourGoldGame.h
//  Connect 4 gold
//
//  Created by Shaik A S on 04/12/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectFourGoldGame : NSObject
-(BOOL) isValidMove : (NSInteger) index;
-(BOOL)updateGameArray:(NSInteger)indexPath player : (NSInteger)player;
@property (nonatomic) NSInteger winner;
-(BOOL) isGameOver;
-(NSInteger) getValueForRow : (NSInteger)row : (NSInteger)col;
@end
