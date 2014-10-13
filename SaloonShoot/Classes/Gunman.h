//
//  Gunman.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "Player.h"

@interface Gunman : Player
{
    NSString* shootAnimName;
}
+(id)gunmanWithParentNode:(CCNode*)parentNode;
+(id)gunmanWithParentNode:(CCNode*)parentNode withSprite:(NSString*)spriteName;
-(id)initGunman:(CCNode*)parentNode withSprite:(NSString*)spriteName;

@end
