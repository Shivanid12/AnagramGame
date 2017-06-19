//
//  HUDView.m
//  Anagrams
//
//  Created by Shivani on 19/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import "HUDView.h"
#import "config.h"
@implementation HUDView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype) viewWithRect : (CGRect)rect
{
    
    HUDView *hudView = [[HUDView alloc] initWithFrame:rect];
    
    hudView.stopwatch = [[StopwatchView alloc] initWithFrame:CGRectMake(hudView.center.x-150 , 0 , 300, 100)] ;
    [hudView.stopwatch setSeconds:0];
    
    [hudView addSubview:hudView.stopwatch];
    return hudView ;

}


@end
