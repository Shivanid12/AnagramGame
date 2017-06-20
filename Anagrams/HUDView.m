//
//  HUDView.m
//  Anagrams
//
//  Created by Shivani on 19/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import "HUDView.h"
#import "config.h"

#define pointsLabelText @" Points"

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
    hudView.userInteractionEnabled = NO ;
    
    // adding the stopwatch
    hudView.stopwatch = [[StopwatchView alloc] initWithFrame:CGRectMake(hudView.center.x/2 , 0 , 300, 100)] ;
    [hudView.stopwatch setSeconds:10];
    [hudView addSubview:hudView.stopwatch];
    
    // adding the points label
    
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(hudView.center.x+hudView.center.x/2,30,140,70)];
    pointsLabel.backgroundColor = kClearColor ;
    pointsLabel.font =kFontHUD ;
    pointsLabel.text = pointsLabelText;
    [hudView addSubview:pointsLabel];
    
    //the dynamic points label
    
    hudView.gamePoints = [CounterLabelView labelWithFont:kFontHUD frame:CGRectMake(pointsLabel.frame.origin.x+pointsLabel.frame.size.width+15,30,200,70) andValue:0];
    hudView.gamePoints.textColor = kGamePointsColor ;
    
    [hudView addSubview: hudView.gamePoints];

    
    return hudView ;

}


@end
