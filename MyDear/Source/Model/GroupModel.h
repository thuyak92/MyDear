//
//  GroupModel.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject

@property (nonatomic, assign) NSInteger postId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *deliver_time;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) NSInteger liked_count;
@property (nonatomic, assign) NSInteger location_id;
@property (nonatomic, assign) NSInteger lshigwaeg;
@property (nonatomic, assign) NSInteger privacy_setup;
@property (nonatomic, strong) NSString *updated_at;
@property (nonatomic, assign) NSInteger user_id;


//[@"id", @"user_id", @"content", @"image", @"location_id", @"liked_count", @"deliver_time", @"privacy_setup", @"category_id", @"lock_version", @"created_at", @"updated_at"]];

//@"id" : @"postId",
//@"created_at" : @"createdAt",
//@"content" : @"text",
//@"image" : @"imageUrl"
@end
