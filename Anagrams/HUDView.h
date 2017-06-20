//
//  HUDView.h
//  Anagrams
//
//  Created by Shivani on 19/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StopwatchView.h"
#import "CounterLabelView.h"


@interface HUDView : UIView

@property (nonatomic, strong) StopwatchView *stopwatch ;

@property (nonatomic,weak) CounterLabelView *gamePoints ;

+(instancetype)viewWithRect : (CGRect)rect ;


@end
