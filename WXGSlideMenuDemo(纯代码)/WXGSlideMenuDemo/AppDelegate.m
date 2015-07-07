//
//  AppDelegate.m
//  WXGSlideMenuDemo
//
//  Created by Nicholas Chow on 15/7/6.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "AppDelegate.h"
#import "WXGMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    WXGMainViewController *mainVC = [[WXGMainViewController alloc] init];
    
    self.window.rootViewController = mainVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
