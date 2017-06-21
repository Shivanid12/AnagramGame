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
#import "GameData.h"

@interface GameController()
@property (nonatomic ,strong) NSMutableArray *tilesArray ;

@property (nonatomic ,strong )NSMutableArray *targetsArray ;

@property (nonatomic)GameData *data ;

@property (nonatomic ,assign) int secondsLeft ;

@property (nonatomic , strong) NSTimer *timer ;

@end
@implementation GameController


-(instancetype) init
{
    self = [super init];
    if(self)
    {
        self.data = [[GameData alloc] init];
        self.data.points = 0 ;
        self.audioController = [[AudioController alloc] init];
        [self.audioController configureAudioEffects:kAudioEffects];
    }
    return  self ;
}

-(void) setHudView:(HUDView *)hudView
{
    
    _hudView = hudView;
    [_hudView.helpButton addTarget:self action:@selector(hintButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
   

    }
-(void)dealRandomAnagram
{
    //check point *
    
    NSAssert(self.level.anagrams, @"no level loaded");
   
    
    // fetching random anagram pair
    
    int randomIndex = arc4random()%[self.level.anagrams count];
    
    NSArray *anagramPair = self.level.anagrams[randomIndex];
    
    NSString *firstAnagram = anagramPair[0];
    NSString *secondAnagram = anagramPair[1] ;
    
    int firstAnagramLength =(int)[firstAnagram length]  ;
    int secondAnagramLength = (int) [secondAnagram length] ;
    
    NSLog( @" anagram 1 : %@ | count : %i",firstAnagram ,firstAnagramLength);
    NSLog( @" anagram 2  : %@ |count: %i ",secondAnagram ,secondAnagramLength) ;
    
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
    self.hudView.helpButton.enabled = YES ;

    [self startStopWatch];
    
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
            [self.audioController playEffect:kSoundDing];
            [self placeTile:tileView atTarget:targetViewTemp];
          self.data.points += self.level.pointsPerTile ;
            [self.hudView.gamePoints countTo:self.data.points withDuration:1.5 ];
            NSLog(@"game points : %d",self.data.points);
            [self checkForSuccess];
            
        }
        else
        {
            NSLog(@"Failure letter doesnt match ");
            [self.audioController playEffect:kSoundWrong];
            self.data.points -= self.level.pointsPerTile ;
            [self.hudView.gamePoints countTo:self.data.points withDuration:1.5];
            NSLog(@"game points : %d",self.data.points);

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
    [self stopStopWatch];
    [self.audioController playEffect:kSoundWin];
    NSLog(@"Game Over ") ;  // TODO : add alert view
    
}
#pragma mark - Timer methods

-(void) startStopWatch
{
    self.secondsLeft = self.level.timeToSolve ;
    [self.hudView.stopwatch setSeconds:self.secondsLeft];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
}

-(void) stopStopWatch
{
    [self.timer invalidate] ;
     self.timer = nil ;
    self.hudView.helpButton.enabled = NO ;
    
}

-(void)tick:(NSTimer*)time
{
    self.secondsLeft -- ;
    [self.hudView.stopwatch setSeconds:self.secondsLeft];
    
    if(self.secondsLeft == 0 )
        [self stopStopWatch] ;
    
}

-(IBAction)hintButtonPressed:(id)sender
{
    NSLog(@" hint button pressed ");
    
   self.hudView.helpButton.userInteractionEnabled = NO ;
    // Find the first unmatched target
    TargetView *target = nil;
    for (TargetView *temp in self.targetsArray)
    {
        if(temp.isMatched ==  NO)
        {
            target = temp ;
            break ;
        }
        
    }
    
    // Find the tile matching the target
    TileView *tile = nil;
    
    for (TileView *temp in self.tilesArray)
    {
        NSLog(@"----> %@",temp.letter);
        
        if(temp.isMatched == NO && [temp.letter isEqualToString:target.letter])
        {
            tile = temp ;
            break ;
        }
        
    }
    
    [self.gameView bringSubviewToFront:tile];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseOut  animations:^{
        tile.center = target.center ;
        [self.gameView setNeedsDisplay];
        [self.gameView layoutIfNeeded] ;
    } completion:^(BOOL finished){
        [self placeTile:tile atTarget:target];
        self.hudView.helpButton.userInteractionEnabled = YES ;
        [self checkForSuccess] ;
        
    }];
    
    // Deduct points from score
    
    self.data.points -= self.level.pointsPerTile/2 ;
    [self.hudView.gamePoints countTo:self.data.points withDuration:1.5];
    
}


@end
