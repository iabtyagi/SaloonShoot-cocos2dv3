//
//  SaloonMenuScene.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 21/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "SaloonMenuScene.h"
#import "SaloonLoadingScene.h"
#import "TuningParams.h"
#import "SaloonSoundUtils.h"
#import "CreditsLayer.h"

@implementation SaloonMenuScene

+(id)scene
{
    return [SaloonMenuScene node];
}

-(id)init
{
    if ((self = [super init]))
    {
        CGSize screenSize = [[CCDirector sharedDirector] viewSize];
        
        CCSprite* menuBg = [CCSprite spriteWithImageNamed:@"menu_bg.png"];
        [self addChild:menuBg];
        menuBg.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        
        CCButton *playButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"play_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"play_button_pressed.png"] disabledSpriteFrame:nil];
        playButton.positionType = CCPositionTypeNormalized;
        playButton.position = ccp(0.5f, 0.512f);
        [playButton setTarget:self selector:@selector(playButtonTouched:)];
        [self addChild:playButton];
        
        
        CCButton *soundToggleButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"sound_on.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"sound_on.png"] disabledSpriteFrame:nil];
        [soundToggleButton setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"sound_off.png"] forState:CCControlStateSelected];
        soundToggleButton.togglesSelectedState = YES;
        soundToggleButton.positionType = CCPositionTypeNormalized;
        soundToggleButton.position = ccp(0.1f, 0.15f);
        [soundToggleButton setTarget:self selector:@selector(soundsToggleTouched:)];
        [self addChild:soundToggleButton];
        
        BOOL soundON = [[NSUserDefaults standardUserDefaults] boolForKey:SOUNDON_KEY];

        [soundToggleButton setSelected:!soundON];
        
        CCButton *infoButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"info_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"info_button_pressed.png"] disabledSpriteFrame:nil];
        infoButton.positionType = CCPositionTypeNormalized;
        infoButton.position = ccp(0.9f, 0.36f);
        [infoButton setTarget:self selector:@selector(showCredits:)];
        [self addChild:infoButton];
        
        CCButton *helpButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"help_button.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"help_button_pressed.png"] disabledSpriteFrame:nil];
        helpButton.positionType = CCPositionTypeNormalized;
        helpButton.position = ccp(0.9f, 0.15f);
        [helpButton setTarget:self selector:@selector(showHowToPlay:)];
        [self addChild:helpButton];
        
        [SaloonSoundUtils playBackground:@"menu44_stereo.mp3" withLoop:YES];
        
    }
    return self;
}

-(void)playButtonTouched:(id)sender
{
    [SaloonSoundUtils stopBackground];
    SaloonLoadingScene* scene = [SaloonLoadingScene sceneWithTargetScene:TargetSaloonGameScene];
    [[CCDirector sharedDirector] replaceScene:scene];
}

-(void)soundsToggleTouched:(id)sender
{
	CCButton* toggleButton = (CCButton*)sender;
	
	//CCLOG(@"Sounds Toggle touched: %@ - selected index: %i", sender, index);
    
    if (!toggleButton.selected)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SOUNDON_KEY];
        [SaloonSoundUtils initSoundUtils];
        [SaloonSoundUtils playBackground:@"menu44_stereo.mp3" withLoop:YES];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SOUNDON_KEY];
        [SaloonSoundUtils initSoundUtils];
        [SaloonSoundUtils stopBackground];
    }
}

-(void)showCredits:(id)sender
{
    CreditsLayer* credits = [CreditsLayer node];
    [self addChild:credits z:10]; // to consume touch , higher z order
}

-(void)showHowToPlay:(id)sender
{
    SaloonLoadingScene* scene = [SaloonLoadingScene sceneWithTargetScene:TargetSaloonDemoScene];
    [[CCDirector sharedDirector] replaceScene:scene];
}

//-(void)dealloc
//{
//    NSLog(@"MenuScene dealloc!!");
//}
@end
