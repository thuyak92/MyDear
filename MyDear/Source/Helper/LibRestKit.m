//
//  LibRestKit.m
//  MyDear
//
//  Created by phuongthuy on 1/31/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "LibRestKit.h"

@interface LibRestKit ()

@end

@implementation LibRestKit

static LibRestKit *share = nil;

+ (LibRestKit *) share
{
    @synchronized (self)
    {
        if (share == nil){
            share = [[LibRestKit alloc] init];
        }
        
    }
    return share;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init RestKit
- (AFHTTPClient *)connectToHost:(NSString *)host
{
    //let AFNetworking manage the activity indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // Initialize HTTPClient
    NSURL *baseURL = [NSURL URLWithString:host];
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    return client;
}

- (void)initRestKit
{
    RKObjectManager *manager = [[RKObjectManager alloc] initWithHTTPClient:[self connectToHost:HOST]];
    //Add Response Descriptor
//    [manager addResponseDescriptor:[self rkDescResponseForClass:CLASS_POST]];
//    [manager addResponseDescriptor:[self rkDescResponseForClass:CLASS_USER]];
//    [manager addResponseDescriptor:[self rkDescResponseForClass:CLASS_POST relationshipClass:CLASS_USER fromKey:@"user" toKey:@"user"]];
//    [manager addResponseDescriptorsFromArray:[NSArray arrayWithObjects:[self rkDescResponseForClass:CLASS_POST], [self rkDescResponseForClass:CLASS_POST relationshipClass:CLASS_USER fromKey:@"user" toKey:@"user"], [self rkDescResponseForClass:CLASS_USER], nil]];
    
    //Add Request Descriptor
    [manager addRequestDescriptor:[self rkDescRequestForClass:CLASS_POST]];
    [manager addRequestDescriptor:[self rkDescRequestForClass:CLASS_USER]];
    [RKObjectManager setSharedManager:manager];
}

#pragma mark - mapping
- (RKObjectMapping *)rkObjMappingForClass: (NSString *)className
{
    NSDictionary *confModel = [Lib configModels];
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[confModel valueForKey:className]];
    [mapping addAttributeMappingsFromDictionary:[Lib dictForClass:className request:FALSE]];
    return mapping;
}

#pragma mark - descriptor
- (RKRequestDescriptor *)rkDescRequestForClass: (NSString *)className
{
    NSDictionary *confModel = [Lib configModels];
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
    [requestMapping addAttributeMappingsFromDictionary:[Lib dictForClass:className request:TRUE]];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[confModel valueForKey:className] rootKeyPath:className method:RKRequestMethodAny];
    return requestDescriptor;
}

- (RKResponseDescriptor *)rkDescResponseForClass: (NSString *)className
{
    RKObjectMapping *mapping = [self rkObjMappingForClass:className];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:statusCodes];
    return responseDescriptor;
}

- (RKResponseDescriptor *)rkDescResponseForClass: (NSString *)class1 relationshipClass: (NSString *)class2 fromKey: (NSString *)key1 toKey: (NSString *)key2
{
    RKObjectMapping* mapping1 = [self rkObjMappingForClass:class1];
    RKObjectMapping* mapping2 = [self rkObjMappingForClass:class2];
    
    [mapping1 addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:key1 toKeyPath:key2 withMapping:mapping2]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping1 method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return responseDescriptor;
}

#pragma mark - request
- (RKObjectRequestOperation *)rkObjRequestUrl: (NSString *)url forClass: (NSString *)className
{
    RKResponseDescriptor *resDescriptor = [self rkDescResponseForClass:className];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", HOST, url]]];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[resDescriptor]];
    return operation;
}

#pragma mark - service
- (void)getObjectsAtPath:(NSString *)path forClass: (NSString *)className
{
    RKObjectManager *manager = [RKObjectManager sharedManager];
    [manager addResponseDescriptor:[self rkDescResponseForClass:className]];
    if ([className isEqualToString:CLASS_POST]) {
        [manager addResponseDescriptor:[self rkDescResponseForClass:CLASS_POST relationshipClass:CLASS_USER fromKey:@"user" toKey:@"user"]];
    }
    [manager getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if ([self.delegate respondsToSelector:@selector(onGetObjectsSuccess:data:)]) {
            [self.delegate onGetObjectsSuccess:self data:[mappingResult array]];
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSString *err = [error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
        [Lib handleError:err forController:self];
    }];
}

- (void)postObject:(id)object toPath:(NSString *)path forClass: (NSString *)className
{
    RKObjectManager *manager = [RKObjectManager sharedManager];
    [manager addResponseDescriptor:[self rkDescResponseForClass:className]];
    if ([className isEqualToString:CLASS_POST]) {
        [manager addResponseDescriptor:[self rkDescResponseForClass:CLASS_POST relationshipClass:CLASS_USER fromKey:@"user" toKey:@"user"]];
    }
    [manager postObject:object path:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if ([self.delegate respondsToSelector:@selector(onPostObjectSuccess:data:)]) {
            [self.delegate onPostObjectSuccess:self data:[mappingResult firstObject]];
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSString *err = [error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
        [Lib handleError:err forController:self];
    }];
}

- (void)postObject:(id)object toPath:(NSString *)path method:(RKRequestMethod)method withData:(NSData *)data fileName:(NSString *)fileName forClass: (NSString *)className
{
    RKObjectManager *manager = [RKObjectManager sharedManager];
    [manager addResponseDescriptor:[self rkDescResponseForClass:className]];
    if ([className isEqualToString:CLASS_POST]) {
        [manager addResponseDescriptor:[self rkDescResponseForClass:CLASS_POST relationshipClass:CLASS_USER fromKey:@"user" toKey:@"user"]];
    }
    NSMutableURLRequest *request = [manager multipartFormRequestWithObject:object method:method path:URL_POST parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data
                                    name:fileName
                                fileName:@"photo.png"
                                mimeType:@"image/png"];
    }];
    RKObjectRequestOperation *operation = [manager objectRequestOperationWithRequest:request success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if ([self.delegate respondsToSelector:@selector(onPostObjectSuccess:data:)]) {
            [self.delegate onPostObjectSuccess:self data:[mappingResult firstObject]];
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSString *err = [error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
        [Lib handleError:err forController:self];
    }];
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
}

@end
