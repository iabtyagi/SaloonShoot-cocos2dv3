//
//  Player.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "Player.h"
#import "Window.h"
#import "SaloonScene.h"
#import "TuningParams.h"

//#define DIE_ANIM_NAME   @"gunmandieanim"

@implementation Player

-(id)initWithParentNode:(CCNode *)parentNode withSprite:(NSString *)spriteName withHidingDuration:(PlayerDurationType_t)hidingDuration withVisibleDuration:(PlayerDurationType_t)visibleDuration
{
    NSAssert(spriteName, @"spriteName is nil");
    if ((self = [super init]))
    {
        hideDur = hidingDuration;
        visiDur = visibleDuration;
        
        [self setUserInteractionEnabled:YES];
        
        [parentNode addChild:self];
        
        playerSprite = [CCSprite spriteWithImageNamed:spriteName];
        [self addChild:playerSprite];
        
        [self setContentSize:[[CCDirector sharedDirector] viewSize]];
        
        [playerSprite setVisible:NO];
        float interval = INTVL_INITIAL_HIDE_DUR_SHORT;
        if (hidingDuration == DURATION_LONG)
        {
            interval = INTVL_INITIAL_HIDE_DUR_LONG;
        }
        
        [self scheduleOnce:@selector(showPlayer:) delay:interval];
        
        //Creating dieing animation
        //deleting path extension .png from spritename
        dieAnimName =[NSString stringWithFormat:@"%@dieanim",[spriteName stringByDeletingPathExtension]];
        CCAnimation* anim = [CCAnimation animationWithFile:dieAnimName
                                                frameCount:DIE_ANIM_FRAME_COUNT
                                                     delay:INTVL_DIE_ANIM_FRAME_DELAY];
        [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:dieAnimName];
    }
    return self;
}

//-(void)dealloc
//{
//    NSLog(@"Player dealloc!!");
//}

-(void)onExit
{
    [super onExit];
}


-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint pos = [self locationFromTouch:touch];
    
    BOOL isPlayerKilled = ( CGRectContainsPoint(
                                                CGRectInset ([playerSprite boundingBox],
                                                             25.0f, // dx  removing the window doors area.
                                                             0.0f   //dy
                                                             ),
                                                pos)
                           && playerSprite.visible
                           && ([playerSprite numberOfRunningActions]==0)
                           );
    if(isPlayerKilled)
    {
        [self unschedule:@selector(hidePlayer:)]; //Unschedule it first..it shud not get called now
        
        CCAnimation* dieAnim = [[CCAnimationCache sharedAnimationCache] animationByName:dieAnimName];
        
        //CCAnimate* animate = [CCAnimate actionWithAnimation:dieAnim restoreOriginalFrame:YES];
        // '--> Deprecated api , the below one takes care
        dieAnim.restoreOriginalFrame = YES;
        CCActionAnimate* animate = [CCActionAnimate actionWithAnimation:dieAnim];
        
        
        //[self runAction:animate]; only sprites can run Animation i guess (this was crashing with
        // exception 'NSInvalidArgumentException', reason: '-[Gunman displayedFrame]  )
        CCActionCallFunc* func = [CCActionCallFunc actionWithTarget:self selector:@selector(finalizePlayerDeath)];
        [self deathStart];
        CCActionSequence* seq = [CCActionSequence actions:animate,func, nil];
        
        [playerSprite runAction:seq];
    }
    
    if (!isPlayerKilled)
    {
        [super touchBegan:touch withEvent:event]; // to relay touch , bcoz each player's content size is
                                                  // now full screen
    }
}
-(void)finalizePlayerDeath
{
    [playerSprite setVisible:NO];
    [Window releaseWindow:playerSprite.position];
    //[self unschedule:@selector(hideGunman:)]; To be unscheduled b4 anim...bcoz it will fire up
    // while anim is running
    [self scheduleShowPlayer];
    //To be called in last...bcoz minus one can also be called here..in that case..
    // unschedule & schedule shud be done before minus one life , bcoz on life count zero , all
    // scheduled functions will be removed. If put after it, schduleShow will be called after
    // unscheduleAll , and will continue.
    [self deathComplete];
}
-(void)deathComplete
{
    // call plusone or minusone as applicable
}
-(void)deathStart
{
    // any thing to be done before/with death animation
}
-(CGPoint)locationFromTouch:(UITouch *)touch
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}
-(void)showPlayer:(CCTime)delta
{
    CGPoint pos = [Window getFreeWindow];
    
    if (pos.x == 0 || pos.y == 0)
    {
        NSLog(@" OOPS !!! Position empty!!!"); //Probably no free window
        [self unschedule:_cmd]; // to supress the warning
        [self scheduleShowPlayer];
        return;
    }
    
    playerSprite.position = pos;
    
    [playerSprite setVisible:YES];
    //[self unschedule:_cmd];
    float interval = INTVL_VISIBLE_DURATION_SHORT;
    if (visiDur == DURATION_LONG)
    {
        interval = INTVL_VISIBLE_DURATION_LONG;
    }
    [self scheduleOnce:@selector(hidePlayer:) delay:interval];
}
-(void)scheduleShowPlayer
{
    float rand = CCRANDOM_0_1();
    float interval;
    if (hideDur == DURATION_SHORT)
    {
        interval = rand + INTVL_HIDE_DUR_SHORT_ADDITIVE;
        
        if (interval > INTVL_MAX_HIDE_DURATION)
        {
            interval = INTVL_MAX_HIDE_DURATION;
        }
    }
    else
    {
        interval = (rand*2) + INTVL_HIDE_DUR_LONG_ADDITIVE;
    }
    
    [self scheduleOnce:@selector(showPlayer:) delay:interval];
}
-(void)hidePlayer:(CCTime)delta
{
    //[self unschedule:_cmd];
    
    // unschedule & schedule shud be done before minus one life , bcoz on life count zero , all
    // scheduled functions will be removed. If put after it, schduleShow will be called after
    // unscheduleAll , and will continue.
    
    CCActionCallFunc* func1 = [CCActionCallFunc actionWithTarget:self selector:@selector(hideStart)];
    CCActionCallFunc* func2 = [CCActionCallFunc actionWithTarget:self selector:@selector(hideReleaseSchedule)];
    CCActionCallFunc* func3 = [CCActionCallFunc actionWithTarget:self selector:@selector(hideComplete)];
    CCActionDelay* delayTimeAction = [CCActionDelay actionWithDuration:(SHOOT_ANIM_FRAME_COUNT+1) * (INTVL_SHOOT_ANIM_FRAME_DELAY)]; //without +1 window closes very soon.
    CCActionSequence* seq = [CCActionSequence actions:func1,delayTimeAction, func2,func3, nil];
    [self runAction:seq];
}
-(void)hideStart
{}
-(void)hideReleaseSchedule
{
    [playerSprite setVisible:NO];
    [Window releaseWindow:playerSprite.position];
    
    [self scheduleShowPlayer];
}
-(void)hideComplete
{}
-(void)callPlusoneScoreHit
{
    SaloonScene* parentScene = (SaloonScene*)[self parent];
    [parentScene plusoneScoreHit];
    [parentScene updateScores];
}
-(void)callMinusoneLifeCount
{
    SaloonScene* parentScene = (SaloonScene*)[self parent];
    [parentScene minusoneLifeCount];
    [parentScene updateScores];
}
-(void)playerGameOver
{
    [playerSprite setVisible:NO];
    [self stopAllActions];
    [self unscheduleAllSelectors];
}
@end


@implementation CCAnimation (PlayerAnimHelper)

//same thing is implemented in kobold in similar way, just as explained in book. "animationWithFiles"
+(CCAnimation*)animationWithFile:(NSString *)name frameCount:(int)frameCount delay:(float)delay
{
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    for (int i=0; i < frameCount; i++)
    {
        NSString* file = [NSString stringWithFormat:@"%@%i.png",name,i];
        
        CCSpriteFrame* frame = [CCSpriteFrame frameWithImageNamed:file];
        [frames addObject:frame];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFrame:frame name:file];
    }
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

@end