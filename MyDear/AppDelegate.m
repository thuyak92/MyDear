//
//  AppDelegate.m
//  MyDear
//
//  Created by phuongthuy on 1/7/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "AppDelegate.h"
#import <RestKit/RestKit.h>
#import "LibRestKit.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LoginVC.h"

@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UITabBar appearance] setTintColor:[Lib colorFromHexString:COLOR_TINT]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];

    [GMSServices provideAPIKey:GOOGLE_MAP_API_KEY];
    
    [[LibRestKit share] initRestKit];
    [Fabric with:@[[Twitter class]]];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)switchToTabWithIndex:(NSInteger)index
{
    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
    [tabController setSelectedIndex:index];
    //reload data with flag
}

- (BOOL)checkLogin
{
    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
    UIViewController *vc = [tabController selectedViewController];
    if ([Lib isGuest] || [Lib currentUser]) {
        return TRUE;
    }
    LoginVC * loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:STORY_BOARD_LOGIN];
    [vc presentViewController:loginVC animated:YES completion:nil];
    return FALSE;
}

- (void)showAlertTitle: (NSString *)title message: (NSString *)message
{
    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
    UIViewController *vc = [tabController selectedViewController];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"閉じる" style:UIAlertActionStyleCancel handler:nil]];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
