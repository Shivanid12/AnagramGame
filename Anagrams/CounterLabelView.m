//
//  CounterLabelView.m
//  Anagrams
//
//  Created by Shivani on 19/06/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import "CounterLabelView.h"
@interface CounterLabelView()

@property (nonatomic ,assign) int finalValue ;
@property (nonatomic, assign) double delayTime;

@end
@implementation CounterLabelView

+ (instancetype) labelWithFont:(UIFont *)font frame:(CGRect)counterFrame andValue:(int)value
{
    CounterLabelView *counterLabel = [[CounterLabelView alloc] initWithFrame:counterFrame];
    if(counterLabel != nil)
    {
        counterLabel.font = font ;
        counterLabel.value = value ;
    }
    return counterLabel ;
}

- (void)setValue:(int)value
{
    _value = value ;
    self.text = [NSString stringWithFormat:@" %i",self.value];
}

- (void) countTo:(int)countValue withDuration:(int)duration
{
    self.finalValue = countValue ;
    
    self.delayTime =  duration / (abs(self.value- countValue)+1);
    if( self.delayTime < 0.05)
        self.delayTime = 0.05 ;
    
    // cancel previously scheduled actions
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (countValue - self.value >0)
        [self updateValueBy:@1];  //count up (gain points)
    
    else if (countValue - self.value < 0 )
        [self updateValueBy:@(-1)]; //count down (lose points)
    
}
 
- (void) updateValueBy:(NSNumber *)valueChange
{
    self.value += [valueChange intValue];
    
    // If points gained (positive change )
    if([valueChange intValue] > 0)
    {
        if(self.value > self.finalValue)
        {
            self.value = self.finalValue ;
            return ;
        }
    
    }
    // If points lost ( negetive change )
    else
    {
        if(self.value < self.finalValue)
        {
            self.value = self.finalValue ;
            return ;
        }
    }
    
    [self performSelector:@selector(updateValueBy:) withObject:valueChange afterDelay:self.delayTime];
    
    
}
@end
