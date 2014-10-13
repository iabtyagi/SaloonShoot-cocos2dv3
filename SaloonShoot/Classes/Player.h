//
//  Player.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "CCAnimation.h"
#import "CCAnimationCache.h"

typedef enum
{
    DURATION_SHORT,
    DURATION_LONG
} PlayerDurationType_t;

@interface Player : CCNode
{
    CCSprite* playerSprite;
    PlayerDurationType_t hideDur;
    PlayerDurationType_t visiDur;
    NSString* dieAnimName;
}

-(id)initWithParentNode:(CCNode*)parentNode withSprite:(NSString*)spriteName
     withHidingDuration:(PlayerDurationType_t)hidingDuration
    withVisibleDuration:(PlayerDurationType_t)visibleDuration;

-(CGPoint)locationFromTouch:(UITouch *)touch;
-(void)showPlayer:(CCTime)delta;
-(void)scheduleShowPlayer;
-(void)hidePlayer:(CCTime)delta;
-(void)hideStart;
-(void)hideReleaseSchedule;
-(void)hideComplete;
-(void)finalizePlayerDeath;
-(void)deathStart;
-(void)deathComplete;
-(void)callPlusoneScoreHit;
-(void)callMinusoneLifeCount;
-(void)playerGameOver;

@end

//Animation helper...ObjC "Category"
@interface CCAnimation (PlayerAnimHelper)

//animationWithFiles is already provided from Kobold in CCAnimation in same way i.e. Category.
//still writing own to understand Categories...

+(CCAnimation*)animationWithFile:(NSString *)name frameCount:(int)frameCount delay:(float)delay;

@end