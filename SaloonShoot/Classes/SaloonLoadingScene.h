//
//  SaloonLoadingScene.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 21/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

typedef enum
{
	TargetSceneINVALID = 0,
    TargetSaloonDemoScene,
	TargetSaloonMenuScene,
	TargetSaloonGameScene,
	TargetSaloonGameOverScene,
	TargetSceneMAX,
} TargetScenes;


@interface SaloonLoadingScene : CCScene
{
    TargetScenes targetScene_;
}

+(id)scene;
+(id)sceneWithTargetScene:(TargetScenes)targetScene;
-(id)initWithTargetScene:(TargetScenes)targetScene;

@end
