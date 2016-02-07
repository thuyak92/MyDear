//
//  Lib.h
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <RestKit/RestKit.h>
#import "MBProgressHUD.h"
#import "Constants.h"

#import "UserModel.h"
#import "GroupModel.h"
#import "FriendModel.h"
#import "GroupMemberModel.h"
#import "PostModel.h"
#import "LocationModel.h"
#import "CategoryModel.h"
#import "MessageModel.h"
#import "ActionModel.h"
#import "SearchModel.h"

@interface Lib : NSObject

#pragma mark - NSUserDefault
+ (id)loadDataWithKey:(NSString *)key;
+ (void)saveData:(id)data forKey:(NSString *)key;
+ (SearchModel *)setSearchDefault;
+ (UserModel *)currentUser;
+ (void)setCurrentUser:(UserModel *)user;

#pragma mark - Color
+ (UIColor *)colorFromHexString:(NSString *)hexString;

#pragma mark - Date
+ (NSString *)stringFromDate: (NSDate *)date formatter: (NSString *)format;
+ (NSString *)convertDate:(NSDate *)date;

#pragma mark - Image
+ (void)getImageFromUrl:(NSString *)url callback:(void (^)(NSData *))callback;
+ (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGRect) rectImage;
+ (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

#pragma mark - Handle String
+ (void)handleError: (id)error forController: (UIViewController *)ctrl;
+ (NSString *)sha256: (NSString *)input;

+ (BOOL)checkEmailValid:(NSString *)email;

+(NSString*)urlEscapeString:(NSString *)unencodedString;
+(NSString*)addQueryStringToUrlString:(NSString *)urlString withDictionary:(NSDictionary *)dictionary;

#pragma mark - Config Model
+ (NSDictionary *)configModels;
+ (NSDictionary *)dictForClass: (NSString *)className request: (BOOL)request;

#pragma mark - Login
+ (BOOL)isGuest;
+ (void)setGuest: (BOOL)guest;
+ (void)logout;

@end
