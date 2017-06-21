//
//  TileView.m
//  Anagrams
//
//  Created by Shivani on 13/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import "TileView.h"
#import "config.h"

@interface TileView()
{
    CGAffineTransform tempTransform ;
}


@end
@implementation TileView

-(id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"Use initWithLetter: andSideLengrth: instead ");
    return nil ;
}

-(instancetype) initWithLetter:(NSString *)letter andSideLength:(float)sideLength
{
    UIImage *tileImage = [UIImage imageNamed:@"tile.png"];
    self = [super initWithImage:tileImage];
    if(self)
    {
        // resize the tiles
        float scale = sideLength/tileImage.size.width ;
        self.frame = CGRectMake(0, 0, tileImage.size.width*scale, tileImage.size.height*scale);
        
        UILabel *textlabel = [[UILabel alloc] initWithFrame:self.bounds ];
        textlabel.textAlignment = NSTextAlignmentCenter ;
        textlabel.backgroundColor = kClearColor;
        textlabel.textColor = [UIColor whiteColor] ;
        textlabel.font = [UIFont fontWithName:@"Verdana-Bold" size:78*scale] ;
        textlabel.text = [letter uppercaseString];
        [self addSubview:textlabel];
        self.userInteractionEnabled = YES ;
        self.isMatched = NO ;
        _letter = letter ;
        
        // adding shadow
        
        self.layer.shadowColor = [UIColor blackColor].CGColor ;
        self.layer.shadowOpacity = 0 ;
        self.layer.shadowOffset = CGSizeMake(10.0, 10.0);
        self.layer.shadowRadius = 15.0f ;
        self.layer.masksToBounds = NO ;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds] ;
        self.layer.shadowPath = path.CGPath ;
    }
    return self ;
    
}

-(void) randomizeTilePosition
{
    // to rotate the tile b/w -0.2 to 0.3 radians
    
    float rotation = randomf(0, 50)/100.0 - 0.2 ;
    self.transform = CGAffineTransformMakeRotation(rotation) ;
    
    // move randomly upwards
    
    int yOffset = (arc4random() % 10 ) - 10 ;
    self.center = CGPointMake(self.center.x, self.center.y +yOffset) ;
    
}

#pragma mark - dragging the tile

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self] ;
    // add shadow and Increase tile size
    self.layer.shadowOpacity = 0.8 ;
    tempTransform = self.transform ;
    self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
    
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.superview] ;
    self.center = CGPointMake(point.x , point.y);
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event] ;
    
    // hide shadow and resize to original
    self.layer.shadowOpacity = 0 ;
    self.transform = tempTransform ;
    if(self.dragDelegate)
    {
        [self.dragDelegate tileView:self didDragToPoint:self.center];
        
    }
}

@end
