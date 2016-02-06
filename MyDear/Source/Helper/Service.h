//
//  Service.h
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Constants.h"

@interface Service : NSObject

+ (void)uploadImage:(NSData *)imageData fileName:(NSString *)fileName callback:(void (^)(BOOL))callback;
+ (void)getImageFromUrl:(NSString *)url callback:(void (^)(NSData *data))callback;

+ (void)getDataFromUrl:(NSString *)url callback:(void (^)(NSString *response))callback;
+ (void)postData:(id)data toUrl:(NSString *)url callback:(void (^)(id))callback;

@end
