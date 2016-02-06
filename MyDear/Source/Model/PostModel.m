//
//  PostModel.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostModel.h"
#import "UserModel.h"
//#import <RestKit/RestKit.h>

@implementation PostModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.postId forKey:@"postId"];
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.textContent forKey:@"textContent"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.thumbnailUrl forKey:@"thumbnailUrl"];
    [aCoder encodeDouble:self.longitude forKey:@"longitude"];
    [aCoder encodeDouble:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.locationName forKey:@"locationName"];
    [aCoder encodeInteger:self.likeNum forKey:@"likeNum"];
    [aCoder encodeObject:self.deliverTime forKey:@"deliverTime"];
    [aCoder encodeInteger:self.privacySetup forKey:@"privacySetup"];
    [aCoder encodeInteger:self.categoryId forKey:@"categoryId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.postId = [aDecoder decodeIntegerForKey:@"postId"];
        self.userId = [aDecoder decodeIntegerForKey:@"userId"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
        self.textContent = [aDecoder decodeObjectForKey:@"textContent"];
        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        self.thumbnailUrl = [aDecoder decodeObjectForKey:@"thumbnailUrl"];
        self.longitude = [aDecoder decodeDoubleForKey:@"longitude"];
        self.latitude = [aDecoder decodeDoubleForKey:@"latitude"];
        self.locationName = [aDecoder decodeObjectForKey:@"locationName"];
        self.likeNum = [aDecoder decodeIntegerForKey:@"likeNum"];
        self.deliverTime = [aDecoder decodeObjectForKey:@"deliverTime"];
        self.privacySetup = [aDecoder decodeIntegerForKey:@"privacySetup"];
        self.categoryId = [aDecoder decodeIntegerForKey:@"categoryId"];
    }
    return self;
}

@end
