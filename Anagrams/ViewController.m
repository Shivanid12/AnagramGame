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

@interface ViewController () <UIActionSheetDelegate>

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
    UIView *gameLayer = [[UIView alloc] initWithFrame:CGRectMake(0 ,0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:gameLayer] ;
    self.gameController.gameView = gameLayer ;
    
    HUDView *hud = [HUDView viewWithRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)] ;
    self.gameController.hudView = hud ;
    
    [self.view addSubview:hud];
    
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showLevelMenu];
    
}

-(void)showLevelMenu
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Difficulty Level" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Easy",@"Medium",@"Hard", nil];
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == -1)
    {
        [self showLevelMenu];
        return ;
    }
    
    int levelIndex = buttonIndex+1;
    self.gameController.level = [Level levelWithNum:levelIndex] ;
    [self.gameController dealRandomAnagram] ;
    
}
@end
