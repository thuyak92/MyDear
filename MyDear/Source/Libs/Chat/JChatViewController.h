//
//  JChatViewController.h
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

@interface JChatViewController : UIViewController<RestKitLibDelegate>

@property (strong, nonatomic) NSMutableArray *messagesArray;
@property (strong, nonatomic) UIImage *guestAvatar;
@end
