//
//  SaloonLoadingScene.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 21/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "SaloonLoadingScene.h"
#import "SaloonScene.h"
#import "SaloonMenuScene.h"
#import "SaloonDemoScene.h"
#import "SaloonGameOverScene.h"
#import "TuningParams.h"

@implementation SaloonLoadingScene

+(id)scene
{
    return [[self alloc] initWithTargetScene:TargetSaloonMenuScene];
}

+(id)sceneWithTargetScene:(TargetScenes)targetScene
{
    return [[self alloc] initWithTargetScene:targetScene];
}

-(id)initWithTargetScene:(TargetScenes)targetScene
{
    if ((self = [super init]))
	{
		targetScene_ = targetScene;
        
        CGSize screenSize = [[CCDirector sharedDirector] viewSize];
        
        CCColor* bgColor;
        
        if (targetScene == TargetSaloonGameOverScene)
        {
            bgColor = [CCColor colorWithRed:0.784f green:0.196f blue:0.196f alpha:1.0f];
        }
        else
        {
            bgColor = [CCColor blackColor];
        }
        
        CCNodeColor* bgLayer = [CCNodeColor nodeWithColor:bgColor width:screenSize.width height:screenSize.height];
        bgLayer.position = ccp(0, 0);
        
        [self addChild:bgLayer];
        
		// Must wait one frame before loading the target scene!
		// Two reasons: first, it would crash if not. Second, the Loading label wouldn't be displayed.
        //[self scheduleUpdate]; // in v3 not needed, if 'update' method is defined it will be called
        // every frame
        
        [self scheduleOnce:@selector(loadNewScene:) delay:0.1f];
        
	}
	
	return self;
}

//-(void)update:(CCTime)delta
-(void)loadNewScene:(CCTime)delta
{
    // removing unscheduleAll as in v3 default update method seems to be not getting unscheduled
    // so we used scheduleOnce
    //[self unscheduleAllSelectors];
    
    switch (targetScene_)
	{
        case TargetSaloonGameScene:
            
            [[CCDirector sharedDirector] replaceScene:[SaloonScene scene]];
			break;
            
		case TargetSaloonMenuScene:
            [[CCDirector sharedDirector] replaceScene:[SaloonMenuScene scene]];
			break;
            
        case TargetSaloonDemoScene:
            [[CCDirector sharedDirector] replaceScene:[SaloonDemoScene scene]];
			break;
            
		case TargetSaloonGameOverScene:
            // Important note: if you create new local variables within a case block, it must be put in brackets.
            // Otherwise you'll receive a compilation error "Expected expression before ..."
            
        {
            //CCColor* transColor = [CCColor colorWithRed:0.784f green:0.196f blue:0.196f alpha:1.0f];
            CCColor* transColor = [CCColor blackColor];
            
            CCTransition* transition = [CCTransition transitionFadeWithColor:transColor duration:1.0];
			[[CCDirector sharedDirector] replaceScene:[SaloonGameOverScene scene] withTransition:transition];
            //[[CCDirector sharedDirector] replaceScene:[SaloonGameOverScene scene]];
			break;
        }
		default:
			// Always warn if an unspecified enum value was used. It's a reminder for yourself to update the switch
			// whenever you add more enum values.
			NSAssert2(nil, @"%@: unsupported TargetScene %i", NSStringFromSelector(_cmd), targetScene_);
			break;
	}
    
}

//-(void)dealloc
//{
//    NSLog(@"LoadingScene dealloc!!");
//}

@end