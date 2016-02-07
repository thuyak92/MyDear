//
//  SearchModel.h
//  MyDear
//
//  Created by phuongthuy on 2/7/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (assign, nonatomic) NSInteger parentTab;
@property (assign, nonatomic) NSInteger privacySetup;
@property (strong, nonatomic) NSMutableArray *category;
@property (assign, nonatomic) NSInteger spot;
@property (assign, nonatomic) float distance;
@property (assign, nonatomic) float longitude;
@property (assign, nonatomic) float latitude;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *orderKey;
@property (strong, nonatomic) NSString *orderValue;

@end
