//
//  MapVC.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"
@import GoogleMaps;

@interface MapVC : UIViewController <GMSMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, RestKitLibDelegate>
{
    NSArray *listCategories;
    SearchModel *search;
}

@property (nonatomic, strong) NSMutableArray *listPosts;

@property (weak, nonatomic) IBOutlet UISearchBar *searchPost;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchDetail;

@property (weak, nonatomic) IBOutlet UIButton *btnSpot;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segPrivacy;
@property (weak, nonatomic) IBOutlet UIScrollView *scrCategories;
- (IBAction)onSegmentChangeValue:(id)sender;


@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UICollectionView *cvPost;

- (IBAction)onButtonClicked:(id)sender;

@end
