//
//  Window.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Window : NSObject
+(CGPoint)getFreeWindow;
+(void)releaseWindow:(CGPoint)window;
+(void)windowGameOver;
@end
