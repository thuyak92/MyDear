//
//  Lib.m
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "Lib.h"
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"

@implementation Lib

#pragma mark - NSUserDefault

+ (id)loadDataWithKey:(NSString *)key
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    id ret = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return ret;
}

+ (void)saveData:(id)data forKey:(NSString *)key
{
    NSData *obj = [NSKeyedArchiver archivedDataWithRootObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (SearchModel *)setSearchDefault
{
    SearchModel *search = [[SearchModel alloc] init];
    search.name = @"";
    search.distance = 10;
    search.category = [[NSMutableArray alloc] initWithCapacity:12];
    search.orderKey = @"order_time";
    search.orderValue = @"desc";
    return search;
}

+ (UserModel *)currentUser
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:CLASS_USER];
    UserModel *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user;
}

+ (void)setCurrentUser:(UserModel *)user
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:CLASS_USER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Color

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

#pragma mark - Date

+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSString *)convertDate:(NSDate *)date {
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    NSString *timeString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    return [[dateString stringByAppendingString:@" "] stringByAppendingString:timeString];
}

#pragma mark - Image

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

+ (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    //CGRect CropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+15);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGRect) rectImage
{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    
    UIGraphicsBeginImageContextWithOptions(rectImage.size, NO, 0.0);
    
    float f = image.size.width/rectImage.size.width;
    float g = image.size.height/rectImage.size.height;
    
    if (f <1 && g< 1) {
        return image;
    }
    
    float newSize;
    float originY;
    float originX;
    if (f > g) {
        newSize= image.size.height/f;
        originY = (rectImage.size.height - newSize)/2.0f; // get center
        [image drawInRect:CGRectMake(0, originY, rectImage.size.width, newSize)];
    } else{
        newSize = image.size.width/g;
        originX = (rectImage.size.width - newSize)/2.0f;  // get center
        [image drawInRect:CGRectMake(originX, 0, newSize, rectImage.size.height)];
    }
    
    
    //    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * image.size.width) + delta,
                                 (ratio * image.size.height) + delta);
    
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma Handle String

+ (void)handleError:(id)error forController:(UIViewController *)ctrl
{
    NSString *err = @"";
    if ([error isKindOfClass:[NSArray class]]) {
        for (NSString *str in error) {
            err = [NSString stringWithFormat:@"%@\n%@", err, str];
        }
    } else {
        err = error;
    }
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app showAlertTitle:@"エラー" message:err];
}

+ (NSString *)sha256:(NSString *)input
{
//    K1p8doj7jAFgTNktiVjOdB8Bw8lQ03X+Gj0i1IwIhgM=
//    Digest::SHA256.base64digest
//    mYdEaRaPi-DeV2016
//    secret_key
    
    
//    NSString* key = @"secret_key";
//    NSString* data = @"mYdEaRaPi-DeV2016";
//    
//    const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
//    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
//    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
//    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
//    NSData *hash = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
//    
//    NSLog(@"%@", hash);
//    
//    NSString* s = [AppDelegate base64forData:hash];
//    NSLog(s);
    
//    const char *s=[input cStringUsingEncoding:NSASCIIStringEncoding];
//    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
//    
//    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
//    CC_SHA256(keyData.bytes, keyData.length, digest);
//    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
//    NSString *hash=[out description];
//    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
//    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
//    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
//    return hash;
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

+ (BOOL)checkEmailValid:(NSString *)email
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *result = [regex matchesInString:email options:0 range:NSMakeRange(0, email.length)];
    return (result.count > 0);
}

+(NSString*)urlEscapeString:(NSString *)unencodedString
{
    CFStringRef originalStringRef = (__bridge_retained CFStringRef)unencodedString;
    NSString *s = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,originalStringRef, NULL, NULL,kCFStringEncodingUTF8);
    CFRelease(originalStringRef);
    return s;
}


+(NSString*)addQueryStringToUrlString:(NSString *)urlString withDictionary:(NSDictionary *)dictionary
{
    NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:urlString];
    
    for (id key in dictionary) {
        NSString *keyString = [key description];
        NSString *valueString = [[dictionary objectForKey:key] description];
        
        if ([urlWithQuerystring rangeOfString:@"?"].location == NSNotFound) {
            [urlWithQuerystring appendFormat:@"?%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        } else {
            [urlWithQuerystring appendFormat:@"&%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        }
    }
    return urlWithQuerystring;
}

#pragma mark - Config Model
+ (NSDictionary *)configModels
{
    return [NSDictionary dictionaryWithObjectsAndKeys:[PostModel class], CLASS_POST, [UserModel class], CLASS_USER, nil];
}

+ (NSDictionary *)dictForClass:(NSString *)className request:(BOOL)request
{
    NSDictionary *dict;
    if ([className isEqualToString:CLASS_POST]) {
        dict = @{
                 @"id"              : @"postId",
                 @"user_id"         : @"userId",
                 @"content"         : @"textContent",
                 @"image"           : @"imageUrl",
                 @"thumbnail"       : @"thumbnailUrl",
                 @"longitude"       : @"longitude",
                 @"latitude"        : @"latitude",
                 @"location_name"   : @"locationName",
                 @"liked_count"     : @"likeNum",
                 @"deliver_time"    : @"deliverTime",
                 @"privacy_setup"   : @"privacySetup",
                 @"category_id"     : @"categoryId",
                 @"errors"          : @"error"
                 };
        if (request) {
            NSArray *keys = [dict allKeys];
            NSArray *values = [dict allValues];
            dict = [NSDictionary dictionaryWithObjects:keys forKeys:values];
        }
        return dict;
    }
    if ([className isEqualToString:CLASS_USER]) {
        dict = @{
                 @"id"            : @"userId",
                 @"nick_name"     : @"nickname",
                 @"mail"          : @"email",
                 @"password"      : @"password",
                 @"avatar"        : @"avatarUrl",
                 @"facebook_id"   : @"facebookId",
                 @"twiter_id"     : @"twiterId",
                 @"desc"          : @"comment",
                 @"address"       : @"mySpot",
                 @"errors"        : @"error"
                 };
        if (request) {
            NSArray *keys = [dict allKeys];
            NSArray *values = [dict allValues];
            dict = [NSDictionary dictionaryWithObjects:keys forKeys:values];
        }
        return dict;
    }
    return nil;
}

+ (BOOL)isGuest
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_LOGIN_AS_GUEST];
}

+ (void)setGuest:(BOOL)guest
{
    [[NSUserDefaults standardUserDefaults] setBool:guest forKey:KEY_LOGIN_AS_GUEST];
}

+ (void)logout
{
    [Lib setCurrentUser:nil];
    [Lib setGuest:FALSE];
}

@end
