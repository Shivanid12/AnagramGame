//
//  TargetView.h
//  Anagrams
//
//  Created by Shivani on 13/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TargetView : UIImageView

@property (nonatomic , strong , readonly) NSString *letter ;
@property (nonatomic ,assign) BOOL isMatched ;

-(instancetype) initWithLetter:(NSString *)letter andSideLength:(float)sideLength ;

@end
