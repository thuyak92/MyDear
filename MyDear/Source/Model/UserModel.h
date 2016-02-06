//
//  UserModel.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (assign, nonatomic) NSInteger userId;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *facebookId;
@property (strong, nonatomic) NSString *twiterId;
@property (strong, nonatomic) NSString *avatarUrl;
@property (strong, nonatomic) NSData *avatar;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *mySpot;
@property (assign, nonatomic) NSInteger searchId;
@property (assign, nonatomic) NSInteger searchLocation;
@property (assign, nonatomic) id error;

@end
