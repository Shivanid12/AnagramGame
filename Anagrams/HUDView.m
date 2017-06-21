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


+(instancetype) viewWithRect : (CGRect)rect
{
    
    HUDView *hudView = [[HUDView alloc] initWithFrame:rect];
    hudView.userInteractionEnabled = YES ;
    
    // adding the stopwatch
    hudView.stopwatch = [[StopwatchView alloc] initWithFrame:CGRectMake(hudView.center.x-50 , 0 , 300, 100)] ;
    [hudView.stopwatch setSeconds:10];
    [hudView addSubview:hudView.stopwatch];
    
    // adding the points label
    
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(hudView.stopwatch.frame.origin.x + hudView.stopwatch.frame.size.width+50,30,140,70)];
    pointsLabel.backgroundColor = kClearColor ;
    pointsLabel.font =kFontHUD ;
    pointsLabel.text = pointsLabelText;
    [hudView addSubview:pointsLabel];
    
    //the dynamic points label
    
    hudView.gamePoints = [CounterLabelView labelWithFont:kFontHUD frame:CGRectMake(pointsLabel.frame.origin.x+pointsLabel.frame.size.width+15,30,200,70) andValue:0];
    hudView.gamePoints.textColor = kGamePointsColor ;
    
    [hudView addSubview: hudView.gamePoints];
    // Hint Button
    UIImage *buttonImage = [UIImage imageNamed:@"btn"];
    
    hudView.hintButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [hudView.hintButton setTitle:@"Hint!" forState:UIControlStateNormal] ;
    hudView.hintButton.titleLabel.font = kFontHUD;
    [hudView.hintButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    hudView.hintButton.frame = CGRectMake(30, 30, buttonImage.size.width, buttonImage.size.height);
    hudView.hintButton.alpha = 0.8 ;
    [hudView addSubview:hudView.hintButton];
    
    // Number of hints label
    
    hudView.hintsRemainingLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, hudView.hintButton.bounds.origin.y+ hudView.hintButton.bounds.size.height+25, 400, 60)];
    hudView.hintsRemainingLabel.text = @" 3 Hints Remaining ";
    hudView.hintsRemainingLabel.font =kFontHUD ;
    [hudView addSubview:hudView.hintsRemainingLabel];
    
    
    return hudView ;
    
}

// Method to selectively respond to only button view touches in HUD

-(id) hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event
{
    UIView *hitView = (UIView *)[super hitTest:point withEvent:event];
    
    if([hitView isKindOfClass:[UIButton class]])
        return hitView ;
    
    return nil ;
}
@end
