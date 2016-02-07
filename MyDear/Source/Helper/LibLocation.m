//
//  LibLocation.m
//  MyDear
//
//  Created by phuongthuy on 1/16/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "LibLocation.h"
#import "AppDelegate.h"

@interface LibLocation ()

@end

@implementation LibLocation

static LibLocation *shareLocation = nil;

+ (LibLocation *) shareLocation
{
    @synchronized (self)
    {
        if (shareLocation == nil){
            shareLocation = [[LibLocation alloc] init];
            [shareLocation initLocation];
        }
    }
    return shareLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - accessible method

- (double)longitude
{
    return currentLocation.coordinate.longitude;
}

- (double)latitude
{
    return currentLocation.coordinate.latitude;
}

- (NSString *)locationName
{
    return curLocationName;
}


- (void)initLocation
{
    if (!locationManager) {
        locationManager = [[CLLocationManager alloc] init];
    }
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; //xac dinh vi tri voi do chinh xac 100m
    locationManager.distanceFilter = 400; //thong bao thay doi khi thiet bi da di chuyen 400m
    locationManager.delegate = self;
    currentLocation = [[CLLocation alloc] init];
}

#pragma mark - Location Manager

- (void)checkLocationStatus
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if ([CLLocationManager locationServicesEnabled]) {
        switch (status) {
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                locationManager.pausesLocationUpdatesAutomatically = NO;
                
                [locationManager startUpdatingLocation];
                //if ([locationManager respondsToSelector:@selector(setAllowsBackgroundLocationUpdates:)]) {
                   // [locationManager setAllowsBackgroundLocationUpdates:YES];
                //}
                //                [locationManager startMonitoringSignificantLocationChanges];
                
                status = [CLLocationManager authorizationStatus];
                break;
            case kCLAuthorizationStatusNotDetermined:
                if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])//iOS 8+
                {
                    [locationManager requestAlwaysAuthorization];
//                    locationManager.allowsBackgroundLocationUpdates = YES;
                }
                break;
            default:
                break;
        }
    }
    else{
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app showAlertTitle:@"エラー" message:@"The location services seems to be disabled from the settings."];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations lastObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            CLPlacemark *placemark = [placemarks lastObject];
//            NSLog(@"place = %@", placemark);
            curLocationName = [NSString stringWithFormat:@"%@, %@", placemark.locality, placemark.name];
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"Change in authorization status");
    [self checkLocationStatus];
}


@end
