//
//  CreditsLayer.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface CreditsLayer : CCNodeColor
{
    CCSprite *iconfb;
    CCSprite *iconwww;
}

-(CGPoint)locationFromTouch:(UITouch *)touch;

@end
