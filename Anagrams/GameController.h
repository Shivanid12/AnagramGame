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


@interface GameController : NSObject<TileDragDelegateProtocol>
//view to add game elements to
@property (nonatomic ,weak) UIView *gameView ;

//to display current game level
@property (nonatomic ,strong) Level *level ;

@property (nonatomic , strong) HUDView *hudView ;

-(void) dealRandomAnagram ;

@end
