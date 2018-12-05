//
//  ConnectFourGoldGame.m
//  Connect 4 gold
//
//  Created by Shaik A S on 04/12/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "ConnectFourGoldGame.h"
#define ROWS 5
#define COLUMNS 5
#define WINCOUNT 4
#define WINNER  10
const int  DEFAULT = -1;
const int PLAYER1 = 0;
const int  PLAYER2 = 1;
NSInteger game[ROWS][COLUMNS];
@implementation ConnectFourGoldGame


-(NSInteger) getValueForRow : (NSInteger)row : (NSInteger)col
{
    return game[row][col];
}
/////////////////////////////////GAME OVER FUNCTIONS/////////////////////////////////////////////////////////////////////////
-(BOOL) isGameOver
{     
    return  [self findRowHorizantallyAndVertically] || [self findRowDiagonally]  ;
}
-(BOOL) findRowDiagonally
{
    for (int i = 0,j=0; i<ROWS && j<COLUMNS;)
    {     int result =  [self UpperDiagonal :i:j:WINCOUNT:WINCOUNT];
       //NSLog(@" %d,%d UD result = %d",i,j,result);
        if(result)
        {      for (int k=0;k<4;k++,i--,j++)
            game[i][j] = WINNER;
            return result;
        }
          i==ROWS-1 ? j++ : j;
        i<ROWS-1 ? i++ : i;
    }
    
    for (int i = 0,j=COLUMNS-1; i<ROWS && j>=0;)
    {       int result = [self lowerDiagonal :i:j:WINCOUNT:WINCOUNT];
        //NSLog(@" %d,%d LD result = %d",i,j,result);
        if(result)
        {  for (int k=0;k<4;k++,i++,j++)
            game[i][j] = WINNER;
            return result;
        }
         j==0 ? i++ : i;
         j>0 ? j-- : j;
        
    }
    return NO;
}
-(BOOL) lowerDiagonal : (int) i : (int) j : (int) player1Count : (int)player2Count
{    if(player2Count == 0 || player1Count == 0)
{          self.winner = (player2Count == 0) ? 2 : 1;
    return YES;
}
    if(i == ROWS || j== COLUMNS)
        return NO;
    if(game[i][j] == PLAYER1)
    {
        player1Count--;
        player2Count = WINCOUNT;
    }
    else if(game[i][j] == PLAYER2)
    {
        player2Count--;
        player1Count = WINCOUNT;
    }
    else if (game[i][j] == DEFAULT)
    {
        player1Count = WINCOUNT;
        player2Count = WINCOUNT;
    }
    return [self lowerDiagonal:i+1 :j+1 :player1Count :player2Count];
}
-(BOOL) UpperDiagonal : (int) i : (int) j : (int) player1Count : (int)player2Count
{   if(player2Count == 0 || player1Count == 0)
{          self.winner = (player2Count == 0) ? 2 : 1;
    return YES;
}
    if(i == -1 || j== COLUMNS)
        return NO;
    if(game[i][j] == PLAYER1)
    {
        player1Count--;
        player2Count = WINCOUNT;
    }
    else if(game[i][j] == PLAYER2)
    {
        player2Count--;
        player1Count = WINCOUNT;
    }
    else if (game[i][j] == DEFAULT)
    {
        player1Count = WINCOUNT;
        player2Count = WINCOUNT;
    }
    return [self UpperDiagonal:i-1 :j+1 :player1Count :player2Count];
}
-(BOOL) findRowHorizantallyAndVertically
{        int j = 0;
    for (int i = ROWS -1 ;i>=0;i--)
    {
        
        int Result =  [self horizantal : i : j : WINCOUNT : WINCOUNT]  || [self vertical : j+ROWS-1 : ROWS-1-i : WINCOUNT : WINCOUNT];
        
        if (Result)
        {
            return Result;
        }
    }
    return 0;
}
-(BOOL) vertical : (int) i : (int) j : (int) player1Count : (int)player2Count
{     if(player2Count == 0 || player1Count == 0)
{          self.winner = (player2Count == 0) ? 2 : 1;
    int row = i+1; int col = j;
    for (int k =0;k<4;k++,row++)
        game[row][col] = WINNER;
    return YES;
}
    
    if(i == -1 || game[i][j] == DEFAULT)
        return 0;
    if(game[i][j] == PLAYER1)
    {
        player1Count--;
        player2Count = WINCOUNT;
    }
    else if(game[i][j] == PLAYER2)
    {
        player2Count--;
        player1Count = WINCOUNT;
    }
    return [self vertical:i-1 :j :player1Count :player2Count];
}
-(BOOL) horizantal : (int) i : (int) j : (int) player1Count : (int)player2Count
{
    if(player2Count == 0 || player1Count == 0)
    {    self.winner = (player2Count == 0) ? 2 : 1;
        int row = i; int col = j-1;
        for (int k =0;k<4;k++,col--)
            game[row][col] = WINNER;
        return YES;
    }
    if(j==COLUMNS)
        return 0;
    if(game[i][j] == PLAYER1)
    {
        player1Count--;
        player2Count = WINCOUNT;
    }
    else if(game[i][j] == PLAYER2)
    {
        player2Count--;
        player1Count = WINCOUNT;
    }
    else if (game[i][j] == DEFAULT)
    {
        player1Count = WINCOUNT;
        player2Count = WINCOUNT;
    }
    return [self horizantal:i :j+1 :player1Count :player2Count];
}
///////////////////////////////////////////////////////////////END OF GAME OVER FUNCTIONS////////////////////////////////////
-(instancetype)init
{
    self = [super init];
    for(int i=0;i<ROWS;i++)
    {    self.winner = 0;
        for(int j=0;j<ROWS;j++)
        {
            game[i][j] = -1;
        }
    }
    return self;
}
-(BOOL)updateGameArray:(NSInteger)indexPath player : (NSInteger)player
{
    if([self isValidMove:indexPath])
    {
        game[indexPath/COLUMNS] [indexPath % COLUMNS] = player;
        NSLog(@"index = %ld, row = %ld, column = %ld",indexPath,indexPath/COLUMNS,indexPath%COLUMNS);
    }
    return YES;
}
-(BOOL) isValidMove : (NSInteger) index
{    NSInteger columnNum = index % COLUMNS;
    for(NSInteger i = (index/COLUMNS)+1;i<COLUMNS;i++)
    {
        if(game[i][columnNum] == -1)
            return NO;
    }
    return  game[index/COLUMNS][columnNum] == -1  && self.winner==0;
}
@end
