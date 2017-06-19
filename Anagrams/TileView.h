//
//  TileView.h
//  Anagrams
//
//  Created by Shivani on 13/05/17.
//  Copyright © 2017 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TileView;

@protocol TileDragDelegateProtocol <NSObject>

-(void) tileView:(TileView *)tileView didDragToPoint:(CGPoint)point ;

@end

@interface TileView : UIImageView

@property (strong , nonatomic ,readonly) NSString *letter ;

@property (assign , nonatomic ) BOOL isMatched ;

@property (nonatomic ,weak) id <TileDragDelegateProtocol>dragDelegate ;

-(instancetype) initWithLetter:(NSString *)letter andSideLength:(float)sideLength ;

-(void) randomizeTilePosition ;
@end
