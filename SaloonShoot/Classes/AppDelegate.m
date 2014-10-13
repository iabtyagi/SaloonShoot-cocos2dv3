//
//  AppDelegate.m
//  SaloonShoot
//
//  Created by Abhinav Tyagi on 21/02/14.
//  Copyright Abhinav Tyagi 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "SaloonLoadingScene.h"
#import "TuningParams.h"
#import "SaloonAdUtils.h"
#import "SaloonSoundUtils.h"

@implementation AppDelegate

// 
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
    
	
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(NO),
		
		// More examples of options you might want to fiddle with:
		// (See CCAppDelegate.h for more information)
		
		// Use a 16 bit color buffer: 
//		CCSetupPixelFormat: kEAGLColorFormatRGB565,
		// Use a simplified coordinate system that is shared across devices.
//		CCSetupScreenMode: CCScreenModeFixed,
		// Run in portrait mode.
//		CCSetupScreenOrientation: CCScreenOrientationPortrait,
		// Run at a reduced framerate.
//		CCSetupAnimationInterval: @(1.0/30.0),
		// Run the fixed timestep extra fast.
//		CCSetupFixedUpdateInterval: @(1.0/180.0),
		// Make iPad's act like they run at a 2x content scale. (iPad retina 4x)
//		CCSetupTabletScale2X: @(YES),
	}];
    
    
// migrating from v2 to v3  http://www.learn-cocos2d.com/2014/03/migrating-cocos2diphone-v3-tips-tricks/
    
    
    //Setting default values, if not existing..
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs objectForKey:SOUNDON_KEY] == nil)
    {
        [prefs setBool:YES forKey:SOUNDON_KEY];
    }
    if ([prefs objectForKey:CURRENT_SCORE] == nil)
    {
        [prefs setInteger:0 forKey:CURRENT_SCORE];
    }
    if ([prefs objectForKey:HIGH_SCORE] == nil)
    {
        [prefs setInteger:0 forKey:HIGH_SCORE];
    }
    if ([prefs objectForKey:MAX_LIFE_COUNT] == nil)
    {
        [prefs setInteger:1 forKey:MAX_LIFE_COUNT];
        //NSLog(@"Comes here only once!!!");
    }
    
    //Initing sound utils
    [SaloonSoundUtils initSoundUtils];
    
    // Enable pre multiplied alpha for PVR textures to avoid artifacts
    //Should be done b4 first scene runs.
    //[CCTexture PVRImagesHavePremultipliedAlpha:YES];
    
    [SaloonAdUtils initAdUtils];
    [SaloonAdUtils showAdBanner];

	
	return YES;
}

-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
	return [SaloonLoadingScene scene];
}

-(void)applicationWillResignActive:(UIApplication *)application
{
    //NSLog(@"Resign Active!!");
    
    [[CCDirector sharedDirector] pause];
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] resume];
    
    //NSLog(@"Become Active!!");
}

@end
