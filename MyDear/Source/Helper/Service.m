//
//  Service.m
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "Service.h"

@implementation Service

#pragma mark - Data

+ (void)getDataFromUrl:(NSString *)url callback:(void (^)(NSString *))callback
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSError* error = nil;
        NSString *urlString = [NSString stringWithFormat:@"%@/%@", HOST, url];
        NSString * imageData = [NSString stringWithContentsOfURL:[NSURL URLWithString: urlString] encoding:NSUTF8StringEncoding error:&error];
        NSLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(imageData);
            NSLog(@"Error: %@", error);
        });
    });
}

+ (void)postData:(id)data toUrl:(NSString *)url callback:(void (^)(id))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/%@", HOST, url] parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(error);
    }];
}

#pragma mark - Image
+ (void)uploadImage:(NSData *)imageData fileName:(NSString *)fileName callback:(void (^)(BOOL))callback
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:[NSString stringWithFormat:@"http://%@/uploadAvatar/", HOST] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"userPhoto" fileName:[NSString stringWithFormat:@"%@.png", fileName] mimeType:@"png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        callback(YES);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        callback(NO);
    }];
}

+ (void)getImageFromUrl:(NSString *)url callback:(void (^)(NSData *))callback
{
    NSString *imageUrl = [NSString stringWithFormat:@"%@", url];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString: imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(imageData);
        });
    });
}

@end
