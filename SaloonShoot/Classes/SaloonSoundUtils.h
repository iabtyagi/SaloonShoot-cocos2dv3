//
//  SaloonSoundUtils.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaloonSoundUtils : NSObject

+(void)initSoundUtils;
+(void)preLoadEffect:(NSString*)fileName;
+(void)playEffect:(NSString*)fileName;
+(void)playBackground:(NSString*)fileName withLoop:(BOOL)loop;
+(void)stopBackground;

@end
