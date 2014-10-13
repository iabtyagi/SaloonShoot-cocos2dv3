//
//  SaloonGameOverScene.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "SaloonGameOverScene.h"
#import "SaloonLoadingScene.h"
#import "TuningParams.h"

@implementation SaloonGameOverScene

+(id)scene
{
    return [SaloonGameOverScene node];
}

-(id)init
{
    if ((self = [super init]))
    {
        CGSize screenSize = [[CCDirector sharedDirector] viewSize];
        
        CCSprite* gameOvrBg = [CCSprite spriteWithImageNamed:@"menu_bg.png"];
        [self addChild:gameOvrBg];
        gameOvrBg.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        NSString* font = @"Marker Felt";
        int fontSizeScore = 40;
        int fontSizeHighScore = 28;
        //CGPoint badgePosition = ccp(convertX568(115.0f), 203.0f);
        float highScoreLbl_Y = 245.0f;
        
        NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
        
        NSInteger currentScore = [prefs integerForKey:CURRENT_SCORE];
        NSInteger highScore = [prefs integerForKey:HIGH_SCORE];
        
        if (currentScore > highScore)
        {
            //New High Score Badge
            CCSprite* newHighScoreBadge = [CCSprite spriteWithImageNamed:@"new_high_score.png"];
            [self addChild:newHighScoreBadge];
            newHighScoreBadge.positionType = CCPositionTypeNormalized;
            
            newHighScoreBadge.position = ccp(0.2, 0.65);
            
            [prefs setInteger:currentScore forKey:HIGH_SCORE];
            highScore = currentScore;
        }
        
        
        CCLabelTTF* lblHighScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:NSLocalizedString(@"High Score: %i",nil),highScore] fontName:font fontSize:fontSizeHighScore];
        
        //CGPoint highScorePos = ccp(360.0f, 245.0f);
        CGPoint highScorePos = ccp(screenSize.width - (lblHighScore.contentSize.width/2) - 12, highScoreLbl_Y);
        
        CCLabelTTF* score = [CCLabelTTF labelWithString:[NSString stringWithFormat:NSLocalizedString(@"Score: %i",nil),currentScore] fontName:font fontSize:fontSizeScore];
        
        CCButton *menuButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"home_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"home_button_pressed.png"] disabledSpriteFrame:nil];
        menuButton.positionType = CCPositionTypeNormalized;
        menuButton.position = ccp(0.21f, 0.2f);
        [menuButton setTarget:self selector:@selector(gotoMainMenu:)];
        [self addChild:menuButton];
        
        
        CCButton *playAgainButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"shootagainbutton.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"shootagain_pressed.png"] disabledSpriteFrame:nil];
        playAgainButton.positionType = CCPositionTypeNormalized;
        playAgainButton.position = ccp(0.7f, 0.2f);
        [playAgainButton setTarget:self selector:@selector(shootAgain:)];
        [self addChild:playAgainButton];
        
        
        [self addChild:lblHighScore];
        [self addChild:score];
        
        lblHighScore.position = highScorePos;
        score.position = ccp(screenSize.width/2, screenSize.height/2 - 10.0f);
    }
    return self;
}

-(void)gotoMainMenu:(id)sender
{
    SaloonLoadingScene* loadMenuScene = [SaloonLoadingScene sceneWithTargetScene:TargetSaloonMenuScene];
    [[CCDirector sharedDirector] replaceScene:loadMenuScene];
}
-(void)shootAgain:(id)sender
{
    SaloonLoadingScene* scene = [SaloonLoadingScene sceneWithTargetScene:TargetSaloonGameScene];
    [[CCDirector sharedDirector] replaceScene:scene];
}

//-(void)dealloc
//{
//    NSLog(@"GameOverScene dealloc!!");
//}

@end
