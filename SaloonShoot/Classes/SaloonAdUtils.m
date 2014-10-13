//
//  SaloonAdUtils.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 22/02/14.
//  Copyright (c) 2014 Abhinav Tyagi. All rights reserved.
//

#import "SaloonAdUtils.h"
#import "TuningParams.h"


// http://www.mwebb.me.uk/2013/08/adding-iads-to-cocos2d-x-on-ios.html

// https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/iAd_Guide/WorkingwithBannerViews/WorkingwithBannerViews.html

@interface SaloonAdUtils ()

@property (nonatomic) BOOL iAdBannerIsVisible;

@property (nonatomic) BOOL googleBannerIsVisible;

@property GADBannerView *googleBannerView;

@end


@implementation SaloonAdUtils

+(void)initAdUtils
{

    CGSize screenSize = [[CCDirector sharedDirector] viewSize];
    
    static SaloonAdUtils* salooniadUtil = nil;
    if (!salooniadUtil)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            salooniadUtil = [[SaloonAdUtils alloc] init];
            ADBannerView *adView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
            
            adView.delegate = salooniadUtil;
            
            adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
            adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
            
            [[[CCDirector sharedDirector] view] addSubview:adView];
            
            CGRect bannerFrame = adView.frame;
            bannerFrame.origin.y = -adView.frame.size.height;
            bannerFrame.origin.x = [[CCDirector sharedDirector] view].bounds.size.width - adView.frame.size.width;
            
            adView.frame = bannerFrame;
            
            if (adView.bannerLoaded)
            {
                //inside
                // Assumes the banner view is just off the bottom of the screen.
                adView.frame = CGRectOffset(adView.frame, 0, adView.frame.size.height);
                salooniadUtil.iAdBannerIsVisible = YES;
            }
            else
            {
                salooniadUtil.iAdBannerIsVisible = NO;
            }
            
            // Google banner
            CGPoint origin = ccp(screenSize.width - CGSizeFromGADAdSize(kGADAdSizeBanner).width ,0);
            
            salooniadUtil.googleBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:origin];
            
            salooniadUtil.googleBannerView.adUnitID = ADMOB_PUBLISHER_ID_IOS; //ADMOB_MEDIATION_ID;
            
            salooniadUtil.googleBannerView.rootViewController = [CCDirector sharedDirector];
            
            salooniadUtil.googleBannerView.delegate = salooniadUtil;
            salooniadUtil.googleBannerIsVisible = NO;
            
        });
    }
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    //NSLog(@"Banner view is beginning an ad action");
    
    if (!willLeave)
    {
        // insert code here to suspend any services that might conflict with the advertisement
        [[CCDirector sharedDirector] pause];
    }
    return YES;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.iAdBannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        self.iAdBannerIsVisible = YES;
    }
    
    if (self.googleBannerIsVisible)
    {
        [self.googleBannerView removeFromSuperview];
        self.googleBannerIsVisible = NO;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"iAd error: %@", error.description);
    if (self.iAdBannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
        self.iAdBannerIsVisible = NO;
    }
    
    // add google banner
    if (!self.googleBannerIsVisible)
    {
        [[CCDirector sharedDirector].view addSubview:self.googleBannerView];
        GADRequest *request = [GADRequest request];
        
        request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID,nil];
        
        [self.googleBannerView loadRequest:request];
        self.googleBannerIsVisible = YES;
    }
    
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    [[CCDirector sharedDirector] resume];
}

-(void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"Google Ad error. %@", error.description);
    [self.googleBannerView removeFromSuperview];
    self.googleBannerIsVisible = NO;
}

+(void)showAdBanner
{
}

+(void)hideAdBanner
{
}

@end