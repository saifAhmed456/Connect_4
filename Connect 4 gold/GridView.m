//
//  GridView.m
//  Connect 4 gold
//
//  Created by Shaik A S on 23/11/18.
//  Copyright © 2018 SHAIK AS. All rights reserved.
//

#import "GridView.h"
@interface GridView()
@end
@implementation GridView

#define OFFSETFORX  15
#define OFFSETFORY 40
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawGrid];
    [self setNeedsDisplay];
}
-(void) drawGrid
{ NSLog(@"in drawGrid method");
    UIBezierPath * path = [[UIBezierPath alloc] init];
   // [[UIColor redColor] setFill];
    [[UIColor redColor] setStroke];
    path.lineWidth = 2.0;
    CGPoint initialPoint = CGPointMake(self.superview.frame.size.width/10 ,self.superview.frame.size.height/10);
    [path moveToPoint:initialPoint];
    CGPoint corner1 = CGPointMake(self.superview.frame.size.width-initialPoint.x, initialPoint.y);
    [path addLineToPoint:corner1];
    CGPoint corner2 = CGPointMake(corner1.x, self.superview.frame.size.height-initialPoint.y*2);
    [path addLineToPoint:corner2];
    CGPoint corner3 = CGPointMake(initialPoint.x, corner2.y);
    [path addLineToPoint:corner3];
    [path addLineToPoint:initialPoint];
    [path stroke];
    
}
-(instancetype)initWithFrame:(CGRect)frame
{ NSLog(@"in init");
    self  = [super initWithFrame:frame];
    
    self.contentMode = UIViewContentModeRedraw;
    return self;
}
@end
