//
//  Level.h
//  Anagrams
//
//  Created by Shivani on 12/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject
//properties stored in plist file
@property (assign ,nonatomic) int pointsPerTile ;

@property (assign , nonatomic ) int timeToSolve ;

@property (strong ,nonatomic) NSArray *anagrams ;

@property (assign, nonatomic) int highScore ;

// factory method to load a plist file and initialize the model

+(instancetype)levelWithNum :(int)levelNum ;



@end
