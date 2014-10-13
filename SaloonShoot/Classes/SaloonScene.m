//
//  SaloonScene.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "SaloonScene.h"
#import "GunLayer.h"
#import "Gunman.h"
#import "Damsel.h"
#import "Window.h"
#import "SaloonLoadingScene.h"
#import "SaloonSoundUtils.h"
#import "TuningParams.h"
#import "SaloonAdUtils.h"


@implementation SaloonScene

static int gunmanCreated = 0;

-(NSInteger)scoreHit
{
    NSInteger theScore;
    @synchronized(score_mutex)
    {
        theScore = scoreHit;
    }
    return theScore;
}
-(void)setScoreHit:(NSInteger)newScore
{
    @synchronized(score_mutex)
    {
        scoreHit = newScore;
    }
}
-(NSInteger)lifeCount
{
    NSInteger theLife;
    @synchronized(life_mutex)
    {
        theLife = lifeCount;
    }
    return theLife;
}
-(void)setLifeCount:(NSInteger)newLife
{
    @synchronized(life_mutex)
    {
        lifeCount = newLife;
    }
}

+(id)scene
{
    return [SaloonScene node];
}

-(id) init
{
	if ((self = [super init]))
	{
        //[self setUserInteractionEnabled:YES];
        
        CGSize screenSize = [[CCDirector sharedDirector] viewSize];
		CCSprite* background = [CCSprite spriteWithImageNamed:@"saloon_bg.png"];
        [self addChild:background];
        background.position = ccp(screenSize.width/2, screenSize.height/2 - Y_DOWN_DUE_TO_AD_BANNER);

        //NSLog(@"width: %f  height: %f",screenSize.width,screenSize.height);
        
        GunLayer* gunLayer = [GunLayer node];
        [self addChild:gunLayer z:ZO_GUN_LAYER name:NAME_GUN_LAYER];
        
        
        NSInteger max_life_count = [[NSUserDefaults standardUserDefaults] integerForKey:MAX_LIFE_COUNT];
        
        [self setLifeCount:max_life_count];
        [self setScoreHit:0];
        //.588
        CCNodeColor* scoreLayer = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0 green:0 blue:0 alpha:0.650f] width:screenSize.width height:screenSize.height/8];
        scoreLayer.position = ccp(0, screenSize.height - scoreLayer.contentSize.height);
        
        [self addChild:scoreLayer z:ZO_SCORE_LAYER];
        
        scoreLabelHits = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:24];
        
        scoreLabelHits.position = ccp(50, 20);
        
        CCSprite* scoreHitIcon = [CCSprite spriteWithImageNamed:@"score_hit.png"];
        
        scoreHitIcon.position = ccp(20, 20);
        
        [scoreLayer addChild:scoreLabelHits];
        [scoreLayer addChild:scoreHitIcon];
        
/*
 
// life icons
        for (int i = 0; i < (max_life_count-1); i++)
        {
            lifeIcons[i] = [CCSprite spriteWithImageNamed:@"life_count.png"];
            
            lifeIcons[i].position = ccp((convertX568(140) + (i*35)), 20);  // (140, 20) , (175, 20) , (210, 20)  // x=140 for 480
            
            [scoreLayer addChild:lifeIcons[i]];
        }
*/
        
        score_mutex = [NSNumber numberWithInt:1];
        life_mutex = [NSNumber numberWithInt:2];

        [SaloonSoundUtils preLoadEffect:@"gunshot2.caf"];
        
        [SaloonSoundUtils playEffect:@"gun_cocking.caf"];
        
        //NSLog(@"GAME STARTS!!!!");
        
        [Damsel damselWithParentNode:self withSprite:@"damsel.png"];

        [self scheduleOnce:@selector(createNewGunman:) delay:INTVL_CREATE_NEW_GUNMAN];
        
	}
    
	return self;
}

-(void)updateScores
{
    [scoreLabelHits setString:[NSString stringWithFormat:@"%li",(long)scoreHit]];
    
    if (lifeCount < 1)  //(lifeCount == 0)
    {
        //Cleanup moved to 'onExit'
        
        [[NSUserDefaults standardUserDefaults] setInteger:scoreHit forKey:CURRENT_SCORE];
        
        //bring GAME OVER Scene
        [self scheduleOnce:@selector(callGameOverScene:) delay:0.3];
    }
}

-(void)callGameOverScene:(CCTime)delta
{
    SaloonLoadingScene* scene = [SaloonLoadingScene sceneWithTargetScene:TargetSaloonGameOverScene];
    [[CCDirector sharedDirector] replaceScene:scene];
}

-(void)createNewGunman:(CCTime)delta
{
    [self unschedule:_cmd]; // to supress warning
                        // http://forum.cocos2d-iphone.org/t/schedule-selector-cocos2d-v2-vs-v3/13099/5
    
    
    if (gunmanCreated < MAX_CREATE_GUNMAN_COUNT)  // limiting count to 5
    {
        [Gunman gunmanWithParentNode:self];// withSprite:@"gunman1.png"];
        gunmanCreated++;
        
        delta += INTVL_NEW_GUNMAN_CREATION_DELTA;
        
        if (gunmanCreated > 1)
        {
            delta += 15;
        }
        
        [self scheduleOnce:@selector(createNewGunman:) delay:delta];
    }
    //NSLog(@"Gunman no: %d", gunmanCreated);
}

-(void)plusoneScoreHit
{
    @synchronized(score_mutex)
    {
        scoreHit++;
    }
}
-(void)minusoneLifeCount
{
    @synchronized(life_mutex)
    {
        lifeCount--;
    }
    
/*
 
 // life badge poof animation
 
    CCActionEaseInOut* scaleup = [CCActionEaseInOut actionWithAction:[CCActionScaleTo actionWithDuration:0.2f scale:2.0] rate:2.0f];
    CCActionEaseInOut* scaledown = [CCActionEaseInOut actionWithAction:[CCActionScaleTo actionWithDuration:0.5f scale:0.2] rate:2.0f];
    CCActionSequence* poof = [CCActionSequence actions:scaleup,scaledown, nil];
    
    if (lifeCount > 0 && lifeCount < 4)
    {
        [lifeIcons[lifeCount-1] runAction:poof];
    }
 */

}

-(void)myAppResignActive
{
    //[pauseBtn pauseButtonTouched:self];
}

-(void)onExit
{
    //NSLog(@"onExit of Scene!!");
    
    ///////// Cleanup
    
    [self unschedule:@selector(createNewGunman:)];
    
    NSArray* children = [self children];
    //int childCount = [children count];
    //for (int i = 0; i < childCount; i++)
    for (CCNode* child in children)
    {
        //CCNode* child = [children objectAtIndex:i];
        if ([child isKindOfClass:[Player class]])
        {
            //NSLog(@"Player found!!!");
            Player* player = (Player*)child;
            [player playerGameOver];
        }
    }
    [Window windowGameOver];
    gunmanCreated = 0;
    
    ////////

    [super onExit];
}

-(void)onEnter
{
    [super onEnter];

    //NSLog(@"onEnter of Scene!!");
}



//-(void)dealloc
//{
//    NSLog(@"SaloonScene dealloc!!");
//}

@end
