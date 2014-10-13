//
//  GunLayer.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "GunLayer.h"
#import "SaloonSoundUtils.h"
#import "ParticleEffectMuzzleFlash.h"
#import "TuningParams.h"

@implementation GunLayer

-(id)init
{
    if ((self = [super init]))
    {
        
        [self setUserInteractionEnabled:YES];
        //keeping priority higher than Gunman class ,  so that touch reaches this layer first,
        // so that it can point gun,run gunfire anim,play sound and after that touch goes to gunman.
        
        CGSize screenSize = [[CCDirector sharedDirector] viewSize];
        screenWidth = screenSize.width;
        screenOneThird = screenWidth/3;
        
        screenTwoThird = screenOneThird * 2;
        
        screenOneThird += 10;    // +10 to narrow down centre a lil bit..will depend
        // on the actual graphics used.
        screenTwoThird -= 10;
        
        [self setContentSize:screenSize];
        
        theGunLeft = [CCSprite spriteWithImageNamed:@"prl_gun_left.png"];
        theGunRight = [CCSprite spriteWithImageNamed:@"prl_gun_right.png"];
        [theGunLeft setVisible:YES]; //Initially anyone shud be visible.
        [theGunRight setVisible:NO];
        
        [self addChild:theGunLeft];
        [self addChild:theGunRight];
        
        theGunLeft.position = ccp(0.337 * screenWidth, 30 - Y_DOWN_DUE_TO_AD_BANNER);
        
        theGunRight.position = ccp(0.66 * screenWidth, 30 - Y_DOWN_DUE_TO_AD_BANNER);
        
        muzzlePosLeft = ccp(0.29 * screenWidth, 64 - Y_DOWN_DUE_TO_AD_BANNER);
        muzzlePosRight = ccp(0.71 * screenWidth, 64 - Y_DOWN_DUE_TO_AD_BANNER);
        
    }
    return self;
}

//-(void)dealloc
//{
//    NSLog(@"GunLayer dealloc!!");
//}

-(void)onExit
{
    [super onExit];
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //play gun shot sound
    [SaloonSoundUtils playEffect:@"gunshot2.caf"];
    
    CCParticleSystem* muzzleFlash = [ParticleEffectMuzzleFlash node];
    
    CGPoint pos = [self locationFromTouch:touch];
    int posX = pos.x;
    
    if (posX < screenOneThird)
    {
        //Show gun left
        [theGunRight setVisible:NO];
        [theGunLeft setVisible:YES];
        
        //GunFire Left
        muzzleFlash.position = muzzlePosLeft;
    }
    else if(posX >= screenOneThird && posX <= screenTwoThird)
    {
        //Show gun Center
        //GunFire Center
    }
    else if(posX > screenTwoThird)
    {
        //Show gun right
        [theGunLeft setVisible:NO];
        [theGunRight setVisible:YES];
        
        //GunFire Right
        //335  204
        muzzleFlash.position = muzzlePosRight;
    }
    
    [self addChild:muzzleFlash z:7];
    
    //NSLog(@"GunLayer Touched!! %f,%f",pos.x,pos.y);
    
    [super touchBegan:touch withEvent:event]; // to relay touch
}

-(CGPoint)locationFromTouch:(UITouch *)touch
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

@end