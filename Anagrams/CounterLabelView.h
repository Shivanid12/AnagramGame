//
//  CounterLabelView.h
//  Anagrams
//
//  Created by Shivani on 19/06/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterLabelView : UILabel

+(instancetype)labelWithFont:(UIFont *)font frame:(CGRect)counterFrame andValue:(int)value ;

-(void)countTo:(int)countValue withDuration:(int)duration ;

@property (assign, nonatomic) int value;

@end
