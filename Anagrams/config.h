//
//  config.h
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#ifndef configed

//UI defines
#define kScreenWidth [UIScreen mainScreen].bounds.size.height
#define kScreenHeight [UIScreen mainScreen].bounds.size.width
#define kTileMargin 20 
//add more definitions here

#define kFontHUD [UIFont fontWithName:@"comic andy" size:62]
#define kFontHUDBig [UIFont fontWithName:@"comic andy" size:120 ]

//handy math functions
#define rad2deg(x) x * 180 / M_PI
#define deg2rad(x) x * M_PI / 180
#define randomf(minX,maxX) ((float)(arc4random() % (maxX - minX + 1)) + (float)minX)

// audio files
#define kSoundDing @"ding.mp3"
#define kSoundWrong @"wrong.m4a"
#define kSoundWin @"win.mp3"  

#define kAudioEffects @[kSoundDing, kSoundWrong, kSoundWin]


// custom colors

#define kGamePointsColor [UIColor colorWithRed:0.38 green:0.098 blue:0.035 alpha:1]
#define kClearColor [UIColor clearColor]


#define configed 1
#endif
