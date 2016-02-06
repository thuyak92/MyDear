//
//  UserModel.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.facebookId forKey:@"facebookId"];
    [aCoder encodeObject:self.twiterId forKey:@"twiterId"];
    [aCoder encodeObject:self.avatarUrl forKey:@"avatarUrl"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.comment forKey:@"comment"];
    [aCoder encodeObject:self.mySpot forKey:@"mySpot"];
    [aCoder encodeInteger:self.searchId forKey:@"searchId"];
    [aCoder encodeInteger:self.searchLocation forKey:@"searchLocation"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userId = [aDecoder decodeIntegerForKey:@"userId"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.facebookId = [aDecoder decodeObjectForKey:@"facebookId"];
        self.twiterId = [aDecoder decodeObjectForKey:@"twiterId"];
        self.avatarUrl = [aDecoder decodeObjectForKey:@"avatarUrl"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.comment = [aDecoder decodeObjectForKey:@"comment"];
        self.mySpot = [aDecoder decodeObjectForKey:@"mySpot"];
        self.searchId = [aDecoder decodeIntegerForKey:@"searchId"];
        self.searchLocation = [aDecoder decodeIntegerForKey:@"searchLocation"];
    }
    return self;
}

@end
