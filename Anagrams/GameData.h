//
//  GameData.h
//  Anagrams
//
//  Created by Shivani on 19/06/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property (nonatomic, assign) int points;
// 3 challenges for each level
@property (nonatomic , assign) int challengeLevelCounter ;

@property (nonatomic, assign) int highScore;
// ? add high score property

@end
