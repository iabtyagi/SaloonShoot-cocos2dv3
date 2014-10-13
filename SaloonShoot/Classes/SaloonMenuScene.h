//
//  SaloonMenuScene.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 21/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface SaloonMenuScene : CCScene

+(id)scene;
-(void)playButtonTouched:(id)sender;
-(void)soundsToggleTouched:(id)sender;
-(void)showCredits:(id)sender;
-(void)showHowToPlay:(id)sender;
@end
