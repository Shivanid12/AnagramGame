//
//  TargetView.m
//  Anagrams
//
//  Created by Shivani on 13/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import "TargetView.h"

@implementation TargetView

-(id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @" use initWithLetter: andSideLength: instead");
    return nil ;
}
-(instancetype) initWithLetter:(NSString *)letterValue andSideLength:(float)sideLength
{
    UIImage *image = [UIImage imageNamed:@"slot"];
    
    self = [super initWithImage:image];
    if(self)
    {
        self.isMatched = NO ;
        float scale = sideLength /image.size.width ;
        self.frame = CGRectMake(0, 0,image.size.width*scale, image.size.height *scale);
        _letter = letterValue ;
        
    }
    return self ;
    
}

@end
