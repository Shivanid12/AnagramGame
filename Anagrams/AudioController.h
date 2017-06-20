//
//  AudioController.h
//  Anagrams
//
//  Created by Shivani on 20/06/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioController : NSObject

-(void)configureAudioEffects:(NSArray *)audioEffectFileNamesArray
 ;

-(void) playEffect:(NSString *)audioFileName ;

@end
