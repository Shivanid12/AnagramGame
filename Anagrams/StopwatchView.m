//
//  StopwatchView.m
//  Anagrams
//
//  Created by Shivani on 19/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.

#import "StopwatchView.h"
#import "config.h"

@implementation StopwatchView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = kClearColor;
        self.font = kFontHUDBig ;
    }
    
    return self ;

    }

-(void) setSeconds:(int)seconds
{
    self.text = [NSString stringWithFormat:@" %02.f : %02i" , round(seconds/60) , seconds%60];
}

@end
