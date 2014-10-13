//
//  Damsel.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "Damsel.h"
#import "TuningParams.h"
#import "SaloonSoundUtils.h"

@implementation Damsel

+(id)damselWithParentNode:(CCNode *)parentNode withSprite:(NSString *)spriteName
{
    NSAssert(spriteName, @"spriteName is nil");
    // FIXME: NSAssert(spriteName == @"", @"spriteName is an empty string");
    return [[self alloc] initWithParentNode:parentNode
                                 withSprite:spriteName
                         withHidingDuration:DURATION_LONG
                        withVisibleDuration:DURATION_LONG];
}
-(void)deathStart
{
    [SaloonSoundUtils playEffect:@"girlscream.caf"];
}
// unschedule & schedule shud be done before minus one life , bcoz on life count zero , all
// scheduled functions will be removed. If put after it, schduleShow will be called after
// unscheduleAll , and will continue.
-(void)deathComplete
{
    [self callMinusoneLifeCount];
}
-(void)hideStart
{
    
}
-(void)hideComplete
{
    
}
@end
