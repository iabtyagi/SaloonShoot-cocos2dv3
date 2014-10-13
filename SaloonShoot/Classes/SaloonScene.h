//
//  SaloonScene.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface SaloonScene : CCScene
{
    NSInteger scoreHit;
    NSInteger lifeCount;
    CCLabelTTF* scoreLabelHits;
    //CCSprite* lifeIcons[3];
    NSNumber* score_mutex;
    NSNumber* life_mutex;
    
}
@property NSInteger scoreHit;
@property NSInteger lifeCount;

+(id)scene;
-(void)updateScores;
-(void)plusoneScoreHit;
-(void)minusoneLifeCount;
-(void)createNewGunman:(CCTime)delta;
-(void)myAppResignActive;

@end
