//
//  AppDelegate.h
//  MyDear
//
//  Created by phuongthuy on 1/7/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)switchToTabWithIndex:(NSInteger)index;
- (BOOL)checkLogin;
- (void)showAlertTitle: (NSString *)title message: (NSString *)message;

@end

