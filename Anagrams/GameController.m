//
//  GameController.m
//  Anagrams
//
//  Created by Shivani on 12/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import "GameController.h"
#import "config.h"
#import "TargetView.h"
#import "HUDView.h"

@interface GameController()
@property (nonatomic ,strong) NSMutableArray *tilesArray ;

@property (nonatomic ,strong )NSMutableArray *targetsArray ;

@end
@implementation GameController

-(void)dealRandomAnagram
{
    //check point *
    
    NSAssert(self.level.anagrams, @"no level loaded");
    
    int randomIndex = arc4random()%[self.level.anagrams count];
    
    NSArray *anagramPair = self.level.anagrams[randomIndex];
    
    NSString *firstAnagram = anagramPair[0];
    NSString *secondAnagram = anagramPair[1] ;
    
    int firstAnagramLength =(int)[firstAnagram length]  ;
    int secondAnagramLength = (int) [secondAnagram length] ;
    
    NSLog( @" anagram 1 : %@ | count : %i",firstAnagram ,firstAnagramLength);
    NSLog(@" anagram 2  : %@ |count: %i ",secondAnagram ,secondAnagramLength) ;
    
    // calculate tile side
    float tileSide = ceilf(kScreenWidth*0.9/MAX(firstAnagramLength, secondAnagramLength)) -kTileMargin ;
    // to get left margin for the first tile 
    float xOffset = kScreenWidth - MAX(firstAnagramLength, secondAnagramLength)* (tileSide +kTileMargin) ;
    
    // for adjustment w.r.t tile's center
    xOffset += tileSide/2 ;
    
    self.tilesArray = [NSMutableArray arrayWithCapacity:firstAnagramLength];
    
    for (int i =0 ; i< firstAnagramLength ; i++)
    {
        NSString *letter  = [firstAnagram substringWithRange:NSMakeRange(i, 1)] ;
        
        if (![letter isEqualToString:@" "])
        {
            TileView* tile = [[TileView alloc] initWithLetter:letter andSideLength:tileSide];
            tile.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/2);
            [tile randomizeTilePosition];
            tile.dragDelegate = self ;
            
            [self.gameView addSubview:tile];
            [self.tilesArray addObject: tile];
            
        }
    }
    
    
    // initialize target tile
    
    self.targetsArray = [NSMutableArray arrayWithCapacity:secondAnagramLength] ;
    
    for (int i =0 ; i < secondAnagramLength ; i++)
    {
        NSString *targetLetter = [secondAnagram substringWithRange:NSMakeRange(i, 1)];
        
        if(![targetLetter isEqualToString:@" " ])
        {
            TargetView *target = [[TargetView alloc] initWithLetter:targetLetter andSideLength:tileSide ] ;
            target.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/4);
            [self.gameView addSubview:target];
            [ self.targetsArray addObject:target];
            
        }
    }
    
}

# pragma mark - tile drag protocol

-(void) tileView:(TileView *)tileView didDragToPoint:(CGPoint)point
{
    TargetView *targetViewTemp = nil ;
    
    for (TargetView *tv in self.targetsArray)
    {
        if(CGRectContainsPoint(tv.frame, point))
        {
            targetViewTemp = tv ;
            break ;
        }
    }
    
    if(targetViewTemp != nil)
    {
        if([targetViewTemp.letter isEqualToString:tileView.letter])
        {
            NSLog(@" Success ,letter matches ");
            [self placeTile:tileView atTarget:targetViewTemp];
            [self checkForSuccess];
        }
        else
        {
            NSLog(@"Failure letter doesnt match ");
            
            [tileView randomizeTilePosition];
            
            [UIView animateWithDuration:0.35
                                  delay:0.00
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 tileView.center = CGPointMake(tileView.center.x + randomf(-20, 20),
                                                               tileView.center.y + randomf(20, 30));
                             } completion:nil];
        }
    }
}


-(void) placeTile:(TileView *)tileView atTarget:(TargetView *)targetView
{
    tileView.isMatched = YES ;
    targetView.isMatched = YES ;
    
    //disable User Interaction
    
    tileView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseOut                     animations:^{
        tileView.center = targetView.center ;
        tileView.transform = CGAffineTransformIdentity ;
    }
                     completion:^(BOOL finished)
     {
         targetView.hidden = YES ;
     }];
}

-(void) checkForSuccess
{
    for (TargetView *target in self.targetsArray)
    {
        if(target.isMatched == NO)
            return ;
    }
    NSLog(@"Game Over ") ;  // TODO : add alert view
    
}
@end
