//
//  Gunman.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "Gunman.h"
#import "SaloonSoundUtils.h"
#import "TuningParams.h"

@implementation Gunman

static int currentImgNmbr = 1;

+(id)gunmanWithParentNode:(CCNode *)parentNode
{
    NSString* spriteName = nil;
    
    spriteName = [NSString stringWithFormat:@"gunman%i.png",currentImgNmbr];
    currentImgNmbr++;
    if (currentImgNmbr > GUNMAN_IMG_COUNT)
    {
        currentImgNmbr = 1;
    }
    
    return [self gunmanWithParentNode:parentNode withSprite:spriteName];
}

+(id)gunmanWithParentNode:(CCNode *)parentNode withSprite:(NSString *)spriteName
{
    // if spriteName is nil , random image is selected.
    if(spriteName == nil)
    {
        int imgNumber = (arc4random() % GUNMAN_IMG_COUNT) + 1;
        spriteName = [NSString stringWithFormat:@"gunman%i.png",imgNumber];
    }
    
    return [[self alloc] initGunman:parentNode
                         withSprite:spriteName];
}

-(id)initGunman:(CCNode *)parentNode withSprite:(NSString *)spriteName
{
    if (self = [super initWithParentNode:parentNode withSprite:spriteName
                      withHidingDuration:DURATION_SHORT
                     withVisibleDuration:DURATION_SHORT])
    {
        //Creating shoot animation
        //deleting path extension .png from spritename
        shootAnimName =[NSString stringWithFormat:@"%@shootanim",[spriteName stringByDeletingPathExtension]];
        CCAnimation* anim = [CCAnimation animationWithFile:shootAnimName
                                                 frameCount:SHOOT_ANIM_FRAME_COUNT
                                                      delay:INTVL_SHOOT_ANIM_FRAME_DELAY];
        [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:shootAnimName];
    }
    
    return self;
}
// unschedule & schedule shud be done before minus one life , bcoz on life count zero , all
// scheduled functions will be removed. If put after it, schduleShow will be called after
// unscheduleAll , and will continue.
-(void)deathComplete
{
    [self callPlusoneScoreHit];
}
-(void)hideStart
{
    CCAnimation* shootAnim = [[CCAnimationCache sharedAnimationCache] animationByName:shootAnimName];
    
    //CCAnimate* animate = [CCAnimate actionWithAnimation:dieAnim restoreOriginalFrame:YES];
    // '--> Deprecated api , the below one takes care
    shootAnim.restoreOriginalFrame = YES;
    CCActionAnimate* animate = [CCActionAnimate actionWithAnimation:shootAnim];
    [playerSprite runAction:animate];
    [SaloonSoundUtils playEffect:@"gunshot_gunman.caf"];
}
-(void)hideComplete
{
    [self callMinusoneLifeCount];
}
@end