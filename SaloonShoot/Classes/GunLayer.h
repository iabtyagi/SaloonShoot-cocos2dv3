//
//  GunLayer.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface GunLayer : CCNode
{
    float screenWidth;
    int screenOneThird;
    int screenTwoThird;
    CCSprite* theGunLeft;
    CCSprite* theGunRight;
    CGPoint muzzlePosLeft;
    CGPoint muzzlePosRight;
}

-(CGPoint)locationFromTouch:(UITouch *)touch;
@end
