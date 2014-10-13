//
//  SaloonDemoScene.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "SaloonDemoScene.h"
#import "SaloonLoadingScene.h"
#import "TuningParams.h"

@implementation SaloonDemoScene

+(id)scene
{
    return [SaloonDemoScene node];
}

-(id)init
{
    if ((self = [super init]))
    {
        CGSize screenSize = [[CCDirector sharedDirector] viewSize];
        
        CCSprite* demoBg = [CCSprite spriteWithImageNamed:@"demo_bg.png"];
        [self addChild:demoBg];
        demoBg.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        CCButton *rightArrowButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"right_arrow.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"right_arrow_pressed.png"] disabledSpriteFrame:nil];
        rightArrowButton.positionType = CCPositionTypeNormalized;
        rightArrowButton.position = ccp(0.85f, 0.68f);
        [rightArrowButton setTarget:self selector:@selector(dismissSaloonDemo:)];
        [self addChild:rightArrowButton];
        
        
        //menu.position = CGPointMake(convertX568(420.0f) , 220.0f );
        
    }
    return self;
}

-(void)dismissSaloonDemo:(id)sender
{
    SaloonLoadingScene* scene = [SaloonLoadingScene sceneWithTargetScene:TargetSaloonMenuScene];
    [[CCDirector sharedDirector] replaceScene:scene];
}

@end
