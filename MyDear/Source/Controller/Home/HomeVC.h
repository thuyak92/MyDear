//
//  HomeVC.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

#define SEG_ALL     0
#define SEG_FRIEND  1
#define SEG_PUBLIC  2

@interface HomeVC : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, RestKitLibDelegate>
{
    NSArray *listCategories;
    SearchModel *search;
}

@property (nonatomic, assign) BOOL reloadData;
@property (nonatomic, strong) NSMutableArray *listPosts;

@property (weak, nonatomic) IBOutlet UISearchBar *searchPost;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UIButton *btnSpot;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segGroup;
@property (weak, nonatomic) IBOutlet UIScrollView *scrCategories;

@property (weak, nonatomic) IBOutlet UICollectionView *cvPost;

- (IBAction)onButtonClicked:(id)sender;

- (IBAction)onSegmentChangeValue:(id)sender;

@end
