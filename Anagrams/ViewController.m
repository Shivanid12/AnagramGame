//
//  ViewController.m
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "config.h"
#import "ViewController.h"
#import "Level.h"
#import "GameController.h"
#import "HUDView.h"

@interface ViewController ()
@property (nonatomic ,strong) GameController *gameController ;

@end

@implementation ViewController

-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self != nil)
    {
        self.gameController = [GameController new] ;
        
        
    }
    return self ;
    
}
//setup the view and instantiate the game controller
- (void)viewDidLoad
{
    [super viewDidLoad];
    Level *level1 = [Level levelWithNum:1] ;
    NSLog(@" anagrams : %@",level1.anagrams) ;
    
    UIView *gameLayer = [[UIView alloc] initWithFrame:CGRectMake(0 ,0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:gameLayer] ;
    self.gameController.gameView = gameLayer ;
    
    self.gameController.level = level1 ;
    [self.gameController dealRandomAnagram] ;
    
    
    HUDView *hud = [HUDView viewWithRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)] ;
    self.gameController.hudView = hud ;
  
        [self.view addSubview:hud];
    
    
    

    
}

@end
