//
//  ConnectFourGoldGame.m
//  Connect 4 gold
//
//  Created by Shaik A S on 04/12/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "ConnectFourGoldGame.h"
 const int ROWS =6;
const int COLUMNS = 7;
const int WINCOUNT = 4;
#define WINNER  10
const int  DEFAULT = -1;
const int PLAYER1 = 0;
const int  PLAYER2 = 1;
NSInteger game[ROWS][COLUMNS];
@interface ConnectFourGoldGame ()
@property (nonatomic) BOOL isEvaluateBoard;
@end
@implementation ConnectFourGoldGame
/////////////////////////////////DISPLAY GAME ARRAY//////////////////////////////////////////////////////////////////////////
-(void)displayGameArray{
    for (int i=0;i<ROWS;i++)
    {
        for (int j=0;j<COLUMNS;j++)
        {   NSLog(@"%ld ",game[i][j]);
        }
        NSLog(@".........");
    }
    NSLog(@"end of matrix............");
}  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct Move {
    int row;
    int col;
};
-(NSInteger) getValueForRow : (NSInteger)row : (NSInteger)col
{
    return game[row][col];
}
/////////////////////////////////BEST MOVE FUNCTION//////////////////////////////////////////////////////////////////////////
-(NSInteger)findBestMove
{     NSInteger bestMove = -1;
    NSInteger bestVal = -1000;
    for (int i=0;i<ROWS;i++)
    {
        for (int j=0;j<COLUMNS;j++)
        {     //NSLog(@"[%d][%d] ",i,j);
            if ( [self isValidMove:i*COLUMNS + j])
            {  //NSLog(@"valid move......[%d][%d] ",i,j);
                game [i][j] = PLAYER1;
                NSInteger currentValue =  [self minmax : 0 : false : -1000 : 1000];
                NSLog(@"[%d][%d] = %ld",i,j,currentValue);
                
                if (currentValue > bestVal)
                {
                    bestVal = currentValue;
                    bestMove = i * COLUMNS +j;
                }
                 game[i][j] = -1;
            }
        }
    }
    self.winner = 0;
    return bestMove;
}



-(NSInteger) minmax : (NSInteger)depth : (BOOL)isMax : (NSInteger)alpha : (NSInteger)beta
{
    NSInteger best = 0;
    NSInteger score = [self evaluateBoard];
    if (score == 10 || score == -10)
    {
        return score;
    }
    if ([self areMovesLeft] == false)
        return 0;
    if (depth == 6)
        return score;
    if (isMax) {
         best = -1000;
    for (int i=0;i<ROWS;i++)
    {
        for (int j =0;j<COLUMNS;j++)
        {
            if ([self isValidMove: i*COLUMNS + j])
            {
                game[i][j] = PLAYER1;
                NSInteger value = [self minmax:depth+1 :!isMax : alpha : beta];
                if (value >best)
                {
                    best = value - depth ;
                    
                }
                alpha =  alpha>best ? alpha : best;
                game[i][j] = -1;
                if (alpha>=beta)
                    break;
            }
        }
    }
    }
    else {
         best = 1000;
        for (int i=0;i<ROWS;i++)
        {
            for (int j =0;j<COLUMNS;j++)
            {
                if ([self isValidMove: i*COLUMNS + j])
                {
                    game[i][j] = PLAYER2;
                    NSInteger value = [self minmax:depth+1 :!isMax : alpha : beta];
                    if (value<best)
                    {
                        best = value + depth ;
                        
                    }
                    beta = beta<best ? beta : best;
                    game[i][j] = -1;
                    if (alpha>= beta)
                        break;
                }
            }
        }
        
    }
    return best;
}



////////////////////////////////////////////////EVALUATE BOARD////////////////////////////////////////////////////////////




-(NSInteger) evaluateBoard
{   self.isEvaluateBoard = true;
    int col = 0; int row = ROWS -1;
    for (int i = ROWS -1 ;i>=0;i--)
    {
        
        BOOL Result =  [self horizantal : i : col : WINCOUNT : WINCOUNT]  ;
        
        if (Result)
        {      self.isEvaluateBoard = false;
            return  self.winner == 1 ? 10 : -10;
        }
    }
    for (int i= COLUMNS-1; i>=0;i--)
    {
        int result = [self vertical:row :i :WINCOUNT :WINCOUNT];
        if (result) {
            self.isEvaluateBoard = false;
            return  self.winner == 1 ? 10 : -10;
        }
    }
    return [self isGameOverDiagonally];
}



-(NSInteger)isGameOverDiagonally
{
    BOOL diagonalResult = [self findRowDiagonally];
    self.isEvaluateBoard = false;
    if (diagonalResult)
        return  self.winner == 1 ? 10 : -10;
    
    return 0;
    
}


-(BOOL) areMovesLeft
{
    for (int i=0;i<ROWS;i++)
    {
        for (int j =0;j<COLUMNS;j++)
        {
            if (game[i][j] == -1)
                return true;
        }
    }
    return false;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
        {
            return result;
        }
          i==ROWS-1 ? j++ : j;
        i<ROWS-1 ? i++ : i;
    }
    
    for (int i = 0,j=COLUMNS-1; i<ROWS && j>=0;)
    {       int result = [self lowerDiagonal :i:j:WINCOUNT:WINCOUNT];
        //NSLog(@" %d,%d LD result = %d",i,j,result);
        if(result)
        {
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
    if (self.isEvaluateBoard == false){
    for (int k=0;k<WINCOUNT;k++) {
        i--; j--;
        game[i][j] = WINNER;
    }
    }
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
    if (self.isEvaluateBoard == false) {
    for (int k=0;k<WINCOUNT;k++) {
        i++;j--;
        game[i][j] = WINNER;
    }
    }
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
{        int col = 0; int row = ROWS -1;
    for (int i = ROWS -1 ;i>=0;i--)
    {
        
        int Result =  [self horizantal : i : col : WINCOUNT : WINCOUNT]  ;
        
        if (Result)
        {
            return Result;
        }
    }
    for (int i= COLUMNS-1; i>=0;i--)
    {
        int result = [self vertical:row :i :WINCOUNT :WINCOUNT];
        if (result)
            return result;
    }
    return 0;
}
-(BOOL) vertical : (int) i : (int) j : (int) player1Count : (int)player2Count
{     if(player2Count == 0 || player1Count == 0)
{          self.winner = (player2Count == 0) ? 2 : 1;
    int row = i+1; int col = j;
    if (self.isEvaluateBoard == false) {
    for (int k =0;k<WINCOUNT;k++,row++)
        game[row][col] = WINNER;
    }
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
        if (self.isEvaluateBoard == false) {
        for (int k =0;k<WINCOUNT;k++,col--)
            game[row][col] = WINNER;
        }
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
        for(int j=0;j<COLUMNS;j++)
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
       // NSLog(@"index = %ld, row = %ld, column = %ld",indexPath,indexPath/COLUMNS,indexPath%COLUMNS);
    }
    return YES;
}
-(BOOL) isValidMove : (NSInteger) index
{    NSInteger columnNum = index % COLUMNS;
    //NSLog(@"index = %d columns = %d",index,columnNum);
    for(NSInteger i = (index/COLUMNS)+1;i<ROWS;i++)
    {
        if(game[i][columnNum] == -1)
            return NO;
    }
   
    return  game[index/COLUMNS][columnNum] == -1  ;
   
}
@end
