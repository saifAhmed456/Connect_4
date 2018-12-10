//
//  ViewController.m
//  Connect 4 gold
//
//  Created by Shaik A S on 23/11/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "ViewController.h"
#import "GridView.h"
#import "ConnectFourGoldGame.h"
@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *gameOverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *ResetButton;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (strong,nonatomic) GridView * gridview;
@property(strong,nonatomic)ConnectFourGoldGame * game;
@end

@implementation ViewController
static int i = 0;
-(ConnectFourGoldGame *)game
{
    if(!_game)
    {
        _game = [[ConnectFourGoldGame alloc] init];
    }
    return _game;
}
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.collectionView.bounds.size.width;
    return  CGSizeMake ( (width/NUM ) - 6 , (width/NUM)  -6 );
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.ResetButton.hidden = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = [UIImage imageNamed:@"roseImage"];
    self.gameOverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.gameOverImageView.image = [UIImage imageNamed:@"gameOverImage"];
    self.gameOverImageView.hidden = YES;
    
   
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.game isValidMove:indexPath.row] )
    {
        [self.game updateGameArray:indexPath.row player:i%2];
        UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
        UIImageView * cellView = [[UIImageView alloc] initWithFrame:cell.contentView.frame];
        cellView.image =  [self getColorForPlayer:i%2];
        cellView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:cellView];
       // cell.contentView.backgroundColor = [self getColorForPlayer : i%2];
    
        i++;
        if([self.game isGameOver])
        { NSLog(@"game over");
            [self gameOverUI];
        }
    }
}
- (IBAction)RestartGame:(id)sender {
    self.game = nil;
    i = 0;
    self.ResetButton.hidden = YES;
    self.gameOverImageView.hidden =YES;
    for ( NSInteger i=0;i<25;i++)
    {
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewCell * cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        UIView * view  = [[cell.contentView subviews] firstObject] ;
        if ([view isKindOfClass:[UIImageView class] ])
        {
            UIImageView * imageView = (UIImageView *) view;
            [imageView removeFromSuperview];
        }
    }
        
    }
}
-(void) gameOverUI
{   self.ResetButton.hidden = NO;
    self.gameOverImageView.hidden =NO;
    for ( NSInteger i=0;i<25;i++)
    {   if ([self.game getValueForRow:i/5 :i%5] != 10)
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewCell * cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        UIView * view  = [[cell.contentView subviews] firstObject] ;
         if ([view isKindOfClass:[UIImageView class] ])
         {
             UIImageView * imageView = (UIImageView *) view;
             [imageView removeFromSuperview];
         }
    }
        
    }
}
-(UIImage *) getColorForPlayer : (int) player
{
    switch (player)
    {
        case 0 :  return  [UIImage imageNamed:@"BabyTomImage"];
        case 1 :  return [UIImage imageNamed:@"JerryImage"];
        default :  return  [UIImage imageNamed:@""];
     }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 25;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Game cell" forIndexPath:indexPath];
    cell.contentView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //cell.contentView.layer.cornerRadius = cell.contentView.frame.size.width/2;
    cell.contentView.layer.borderWidth = 1.5f;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
