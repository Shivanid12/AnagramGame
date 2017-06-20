//
//  AudioController.m
//  Anagrams
//
//  Created by Shivani on 20/06/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import "AudioController.h"

@interface AudioController ()

@property (nonatomic, strong) NSMutableDictionary *audioDictionary ;
@end

@implementation AudioController

-(void) configureAudioEffects:(NSArray *)audioEffectFileNamesArray
{
    self.audioDictionary = [NSMutableDictionary dictionaryWithCapacity:audioEffectFileNamesArray.count];
    
    for (NSString *effect in audioEffectFileNamesArray)
    {
        NSString *soundPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:effect];
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        NSError *loadingError = nil ;
        
        //loading sound file in player
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&loadingError];
    
        NSAssert(loadingError == nil, @"Error loading Sound file");
        
        audioPlayer.numberOfLoops = 0;
        
        //preloading the audio buffer for the sound
        [audioPlayer prepareToPlay];
        self.audioDictionary[effect] = audioPlayer ;
        
    }
}

-(void) playEffect:(NSString *)audioFileName
{
    NSAssert(self.audioDictionary[audioFileName], @" Audio effect not found");
    
    AVAudioPlayer *player = (AVAudioPlayer *)self.audioDictionary[audioFileName];
    
    if(player.isPlaying)
    {
        player.currentTime = 0 ; //rewind if audio currently playing ;
        
    }
    else
        [player play];
}

@end
