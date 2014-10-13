//
//  SaloonSoundUtils.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "SaloonSoundUtils.h"
#import "ObjectAL.h"
#import "TuningParams.h"


static BOOL soundON;

@implementation SaloonSoundUtils

+(void)initSoundUtils
{
    soundON = [[NSUserDefaults standardUserDefaults] boolForKey:SOUNDON_KEY];
    
    [OALSimpleAudio sharedInstance].allowIpod = YES;
    [OALSimpleAudio sharedInstance].honorSilentSwitch = YES;
}

+(void)preLoadEffect:(NSString *)fileName
{
    if (soundON)
    {
        [[OALSimpleAudio sharedInstance] preloadEffect:fileName];
    }
}

+(void)playEffect:(NSString *)fileName
{

    if (soundON)
    {
        [[OALSimpleAudio sharedInstance] playEffect:fileName];
    }

}

+(void)playBackground:(NSString *)fileName withLoop:(BOOL)loop
{

    if (soundON)
    {
        [[OALSimpleAudio sharedInstance] playBg:fileName loop:loop];
    }
    //[OALSimpleAudio sharedInstance] backgroundTrack;
    // [OALSimpleAudio sharedInstance] bgPlaying

}

+(void)stopBackground
{
    [[OALSimpleAudio sharedInstance] stopBg];
}


@end
