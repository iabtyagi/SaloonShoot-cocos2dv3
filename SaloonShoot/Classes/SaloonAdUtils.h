//
//  SaloonAdUtils.h
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <iAd/iAd.h>
#import "GADBannerView.h"

@interface SaloonAdUtils : NSObject <ADBannerViewDelegate, GADBannerViewDelegate>

+(void)initAdUtils;
+(void)showAdBanner;
+(void)hideAdBanner;
@end
