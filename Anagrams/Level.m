//
//  Level.m
//  Anagrams
//
//  Created by Shivani on 12/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import "Level.h"

@implementation Level

+(instancetype)levelWithNum :(int)levelNum
{
    // finding .plist file for the level
    NSString *fileName = [NSString stringWithFormat:@"level%i.plist",levelNum];
    NSString *levelPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
    // loading .plist file
    
    NSDictionary *levelDictionary = [NSDictionary dictionaryWithContentsOfFile:levelPath] ;
    NSAssert(levelDictionary, @"level configeration file not found");
    
    // initializing the object from the dictionary
    
    Level *levelObject = [Level new] ;
    levelObject.pointsPerTile = [levelDictionary[@"pointsPerTile"] intValue];
    levelObject.timeToSolve = [levelDictionary[@"timeToSolve"] intValue] ;
    levelObject.anagrams = levelDictionary[@"anagrams"];
    
    return levelObject ;
    
}


@end
