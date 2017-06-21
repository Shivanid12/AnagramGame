//
//  GameController.h
//  Anagrams
//
//  Created by Shivani on 12/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"
#import "TileView.h"
#import "HUDView.h"
#import "AudioController.h"
#import "GameData.h"

typedef void(^ChallengeUpdationBlock) (BOOL gameWon);

@interface GameController : NSObject<TileDragDelegateProtocol>
//view to add game elements to
@property (nonatomic ,weak) UIView *gameView ;

//to display current game level
@property (nonatomic ,strong) Level *level ;

@property (nonatomic , strong) HUDView *hudView ;

@property (nonatomic, strong) AudioController *audioController ;

@property (nonatomic)GameData *gameData ;

// Block property -> gets executed after game completion
@property ChallengeUpdationBlock onAnagramSolved ;

-(void) dealRandomAnagram ;



@end
