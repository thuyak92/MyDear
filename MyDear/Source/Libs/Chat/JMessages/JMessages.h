//
//  JMessages.h
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMessages : NSObject

@property (strong, nonatomic) NSString *senderID;
@property (strong, nonatomic) NSString *senderDisplayName;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *textMessage;
@property (strong, nonatomic) NSData *mediaData;

- (instancetype)initWithSenderID:(NSString *)senderID displayName:(NSString *)displayName createAtDate:(NSDate *)date textMessage:(NSString *)textMessage mediaData:(NSData *)mediaData;
@end
