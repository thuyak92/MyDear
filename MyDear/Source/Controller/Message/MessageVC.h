//
//  MessageVC.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

@interface MessageVC : UIViewController<UITableViewDataSource, UITableViewDelegate, RestKitLibDelegate>
{
    NSMutableArray *listUsers, *messages;
    UserModel *selectedUser;
}

@end
