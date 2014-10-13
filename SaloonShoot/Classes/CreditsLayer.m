//
//  CreditsLayer.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "CreditsLayer.h"
#import "TuningParams.h"

@implementation CreditsLayer

-(id)init
{
    
    if ((self=[super initWithColor:[CCColor colorWithRed:0 green:0 blue:0 alpha:0.705f]])) //fadingTo:ccc4(64, 64, 64, 255)]))
    {
        //CFBundleVersion   : build
        //CFBundleShortVersionString   :  version
        //CFBundleDisplayName
        //CFBundleName
        
        self.userInteractionEnabled = YES;
        
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        //NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
        //CCLabelTTF* gameName = [CCLabelTTF labelWithString:name fontName:@"Edmunds" fontSize:24];

        CCLabelTTF* nameSaloon = [CCLabelTTF labelWithString:@"SALOON" fontName:@"Edmunds" fontSize:48];
        
        CCLabelTTF* nameShoot = [CCLabelTTF labelWithString:@"SHOOT" fontName:@"Edmunds" fontSize:42];
        
        CCLabelTTF* gameVer =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"v %@",version] fontName:@"Marker Felt" fontSize:24];
        [self addChild:nameSaloon];
        [self addChild:nameShoot];
        [self addChild:gameVer];
        
        nameSaloon.position = ccp(110.0f, 235.0f);
        nameShoot.position = ccp(110.0f, 195.0f);
        gameVer.position = ccp(110.0f, 160.0f);
        
        //CCLabelTTF* teamCredits = [CCLabelTTF labelWithString:@"Credits" fontName:@"Marker Felt" fontSize:24];
        //[self addChild:teamCredits];
        
        CCLabelTTF* abhinav = [CCLabelTTF labelWithString:@"Abhinav Tyagi" fontName:@"Marker Felt" fontSize:24];
        [self addChild:abhinav];
        
        CCLabelTTF* parul = [CCLabelTTF labelWithString:@"Parul Gupta" fontName:@"Marker Felt" fontSize:24];
        [self addChild:parul];

        
        abhinav.anchorPoint = parul.anchorPoint = ccp(0.0f, 0.5f);
        
        abhinav.positionType = parul.positionType = CCPositionTypeNormalized;
        
        abhinav.position = ccp(0.67, 0.73);
        parul.position = ccp(0.67, 0.58);
        
        
        CCSprite *iconCoder = [CCSprite spriteWithImageNamed:@"icon_coder24.png"];
        [self addChild:iconCoder];
        iconCoder.positionType = CCPositionTypeNormalized;
        iconCoder.position = ccp(0.58, 0.73);
        
        CCSprite *iconDesigner = [CCSprite spriteWithImageNamed:@"icon_designer24.png"];
        [self addChild:iconDesigner];
        iconDesigner.positionType = CCPositionTypeNormalized;
        iconDesigner.position = ccp(0.58, 0.57);
        
        iconfb = [CCSprite spriteWithImageNamed:@"icon_fb.png"];
        [self addChild:iconfb];
        iconfb.anchorPoint = ccp(0.0f, 0.5f);
        iconfb.position = ccp(15.0f, 86.0f);
        
        iconwww = [CCSprite spriteWithImageNamed:@"icon_www.png"];
        [self addChild:iconwww];
        iconwww.anchorPoint = ccp(0.0f, 0.5f);
        iconwww.position = ccp(15.0f, 35.0f);
        
    }
    return self;
}

-(void)onEnter
{
    [super onEnter];
    //Priority used by menu items is -128 defined in CCMenu.h kCCMenuHandlerPriority = -128
    //so use less than that to completely swallow touches.
    //[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:-129 swallowsTouches:YES];
    
    //NSLog(@"Entering Credits layer");
}

-(void)onExit
{
    //[[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    
    //NSLog(@"exiting Credits layer!!");
    [super onExit];
}

//-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint pos = [self locationFromTouch:touch];
    
    if (CGRectContainsPoint([iconfb boundingBox], pos))
    {
        NSURL *webUrl = [NSURL URLWithString:@"http://www.facebook.com/SaloonShoot"];
        NSURL *appUrl = [NSURL URLWithString:@"fb://profile/540901779293808"];
        
        if ([[UIApplication sharedApplication] canOpenURL:appUrl])
        {
            [[UIApplication sharedApplication] openURL:appUrl];
        }
        else if ([[UIApplication sharedApplication] canOpenURL:webUrl])
        {
            [[UIApplication sharedApplication] openURL:webUrl];
        }
    }
    else if (CGRectContainsPoint([iconwww boundingBox], pos))
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.dholinteractive.com"]];
    }
    else
    {
        [self removeFromParent];
    }
    
    //to relay touch call
    //[super touchBegan:touch withEvent:event];
    //but we are consuming touch, so not calling
}

-(CGPoint)locationFromTouch:(UITouch *)touch
{
    CGPoint touchLocation = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

@end
