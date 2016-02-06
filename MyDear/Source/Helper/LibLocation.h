//
//  LibLocation.h
//  MyDear
//
//  Created by phuongthuy on 1/16/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LibLocation : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString *curLocationName;
}

+ (LibLocation *) shareLocation;

- (void)initLocation;
- (double)longitude;
- (double)latitude;
- (NSString *)locationName;

@end
