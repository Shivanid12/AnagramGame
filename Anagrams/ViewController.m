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

@interface ViewController () <UIActionSheetDelegate, UIAlertViewDelegate>

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
    
    // alert view after game over
    __weak ViewController *weakSelf = self ;
    self.gameController.onAnagramSolved = ^(BOOL gameWon){
        if(gameWon)
            [weakSelf showChallengeWonAlert:YES];
        else
            [weakSelf showGameLostAlert];
    };
    
    
}

-(void)showChallengeWonAlert:(BOOL)updateFlag
{
    static int challengeNumberFlag = 0 ;
    if (challengeNumberFlag < 3)
    {
        if(updateFlag)
            challengeNumberFlag++ ;
        UIActionSheet *gameOverAlert = [[UIActionSheet alloc] initWithTitle:@"congratulations, Challenge Won" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Quit" otherButtonTitles:@"Go to next challenge", nil];
        gameOverAlert.tag = 100 ;
        [gameOverAlert showInView:self.view];
        
    }
    else
    {
        [self showGameWonAlert];
        challengeNumberFlag = 0;
    }
    
 self.gameController.gameData.challengeLevelCounter = challengeNumberFlag ;

}

-(void) showGameWonAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You Won The Game !!" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Play Again", nil];
    
    alertView.tag = 150 ;
    alertView.delegate = self ;
    [alertView show];
}
-(void)showGameLostAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You Lost!" message:@"There is always next time!!" delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:@"Play Again", nil];
    alertView.tag = 200 ;
    [alertView show];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showLevelMenu];
    
}

-(void)showLevelMenu
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Difficulty Level" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Easy",@"Medium",@"Hard",@"Exit Game", nil];
    actionSheet.tag = 300 ;
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
  // main menu action sheet
    if (actionSheet.tag == 300)
    {
        if(buttonIndex == -1)
        {
            [self showLevelMenu];
            return ;
        }
        else if (buttonIndex == 3)
        {
            //  Exit Game
            exit(0);
        }
        
        int levelIndex = buttonIndex+1;
        self.gameController.level = [Level levelWithNum:levelIndex] ;
        [self.gameController dealRandomAnagram] ;
    }
// Challenge won action sheet
    else if (actionSheet.tag == 100)
    {
        if(buttonIndex == -1)
        {
            [self showChallengeWonAlert:NO];
            return ;
            
        }
        
        [self.gameController dealRandomAnagram];
    }
    
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
        switch(buttonIndex)
        {
            case -1:if(alertView.tag == 150)
                        [self showGameWonAlert];
                    else if(alertView.tag == 200)
                        [self showGameLostAlert];
                break;
            case 0:exit(0);
                break;
            case 1:[self showLevelMenu];
                break;
        }
    
    
}
@end
