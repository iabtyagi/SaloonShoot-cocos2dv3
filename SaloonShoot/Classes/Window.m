//
//  Window.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//
#import "cocos2d.h"
#import "Window.h"
#import "TuningParams.h"

@implementation Window

// 226 is width of gunman image(with window) and 143 is height in hd (113x71 in sd)

//Points where center of gunman image (with open window) comes when exact overlap on closed window.
//All following are according to hd (960x640)
// p1 =  159 , 202  //bottom left
// p2 =  784 , 202  // bottom right
// p3 =  227 , 451  //top left
// p4 =  730 , 447  //top right

static CGPoint windowPool[WINDOW_MAX] = {0,0};

static BOOL windowFree[WINDOW_MAX] = {YES,YES,YES,YES};


+(CGPoint)getFreeWindow
{
    //first check for initialization
    if (windowPool[0].x == 0)
    {
        //initialize array with values derived from winSize
        CGSize screenSize = [[CCDirector sharedDirector] viewSize];
        float winX = screenSize.width;
        float winY = screenSize.height;
        
        for (int i = 0; i<WINDOW_MAX; i++)
        {
            switch (i)
            {
                case 0:
                    //p1  BL
                    windowPool[i].x = winX / 6.037f;
                    windowPool[i].y = (winY / 3.168f) - Y_DOWN_DUE_TO_AD_BANNER;
                    windowFree[i] = YES;
                    break;
                case 1:
                    //p2  BR
                    windowPool[i].x = winX / 1.224f;
                    windowPool[i].y = (winY / 3.168f) - Y_DOWN_DUE_TO_AD_BANNER;
                    windowFree[i] = YES;
                    break;
                case 2:
                    //p3  TL
                    windowPool[i].x = winX / 4.229f;
                    windowPool[i].y = (winY / 1.419f) - Y_DOWN_DUE_TO_AD_BANNER;
                    windowFree[i] = YES;
                    break;
                case 3:
                    //p4  TR
                    windowPool[i].x = winX / 1.315f;
                    windowPool[i].y = (winY / 1.431f) - Y_DOWN_DUE_TO_AD_BANNER;
                    windowFree[i] = YES;
                    break;
                    
                default:
                    NSLog(@"Something is wrong!!!! check WINDOW_MAX");
                    break;
            }
        }
        
    }
    
    CGPoint p = ccp(0, 0);
    for (int i=0; i<5; i++)
    {
        int randomWindowIndex = arc4random() % WINDOW_MAX;//CCRANDOM_0_1() * WINDOW_MAX;
        
        if (randomWindowIndex >= WINDOW_MAX)
        {
            randomWindowIndex = 1; // taken 1 just to increase its probability
        }
        if (randomWindowIndex < 0)
        {
            randomWindowIndex = 0;
        }
        
        if (windowFree[randomWindowIndex])
        {
            windowFree[randomWindowIndex] = NO;
            p = windowPool[randomWindowIndex];
            break;
        }
        //NSLog(@"Nothing found!!! Going again!!!");
    }
    return p;
}
+(void)releaseWindow:(CGPoint)window
{
    int poolIndex = 99;
    for (int i = 0; i < WINDOW_MAX; i++)
    {
        if (CGPointEqualToPoint(window, windowPool[i]))
        {
            poolIndex = i;
            break;
        }
    }
    
    if (99 == poolIndex)
    {
        NSLog(@" ERROR!!!  Cannot find in array!!!");
        NSLog(@"released window does not match any in array !!");
    }
    else
    {
        windowFree[poolIndex] = YES;
    }
}
+(void)windowGameOver
{
    for (int i = 0; i < WINDOW_MAX; i++)
    {
        windowFree[i] = YES;
    }
}

@end