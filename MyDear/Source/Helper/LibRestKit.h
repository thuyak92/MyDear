//
//  LibRestKit.h
//  MyDear
//
//  Created by phuongthuy on 1/31/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lib.h"

@class LibRestKit;

#pragma mark - Delegate
@protocol RestKitLibDelegate <NSObject>

@optional
- (void)onError: (LibRestKit *)controller;

//Login and Register
- (void)onLoginSuccess: (LibRestKit *)controller;
- (void)onRegisterSuccess: (LibRestKit *)controller;

//Service
- (void)onGetObjectsSuccess: (LibRestKit *)controller data: (NSArray *)objects;
- (void)onPostObjectSuccess: (LibRestKit *)controller data: (id)object;

@required

@end

#pragma mark - LibRestKit

@interface LibRestKit : UIViewController

+ (LibRestKit *) share;
@property (nonatomic, weak) id <RestKitLibDelegate> delegate;

#pragma mark - init
- (AFHTTPClient *)connectToHost: (NSString *)host;
- (void)initRestKit;

#pragma mark - mapping
- (RKObjectMapping *)rkObjMappingForClass: (NSString *)className;

#pragma mark - descriptor
- (RKRequestDescriptor *)rkDescRequestForClass: (NSString *)className;
- (RKResponseDescriptor *)rkDescResponseForClass: (NSString *)className;
- (RKResponseDescriptor *)rkDescResponseForClass: (NSString *)class1 relationshipClass: (NSString *)class2 fromKey: (NSString *)key1 toKey: (NSString *)key2;

#pragma mark - request
- (RKObjectRequestOperation *)rkObjRequestUrl: (NSString *)url forClass: (NSString *)className;

#pragma mark - service
- (void)getObjectsAtPath: (NSString *)path forClass: (NSString *)className;
- (void)postObject: (id)object toPath: (NSString *)path forClass: (NSString *)className;
- (void)postObject: (id)object toPath: (NSString *)path method: (RKRequestMethod)method withData: (NSData *)data fileName: (NSString *)fileName forClass: (NSString *)className;

@end
