//
//  SearchVC.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

#define TYPE_CURRENT_LOCATION   0
#define TYPE_OTHER_LOCATION     1

@interface SearchVC : UITableViewController<UITextFieldDelegate, RestKitLibDelegate>
{
    NSInteger userType, spot;
    NSMutableArray *categories;
    NSString *locationName, *orderKey, *orderValue;
    float longitude, latitude;
    UILabel *lblSlider;
}

//Search bar
@property (weak, nonatomic) IBOutlet UISearchBar *searchLoc;

//Users
@property (weak, nonatomic) IBOutlet UIButton *btnAllOfUser;
@property (weak, nonatomic) IBOutlet UIButton *btnFriend;
@property (weak, nonatomic) IBOutlet UIButton *btnPublic;
- (IBAction)onUserButtonClicked:(id)sender;

//Spot
@property (weak, nonatomic) IBOutlet UIButton *btnCurLoc;
@property (weak, nonatomic) IBOutlet UIButton *btnOtherLoc;
@property (weak, nonatomic) IBOutlet UIButton *btnReload;
- (IBAction)onSpotButtonClicked:(id)sender;
- (IBAction)onLocationButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtfLocation;

//slider
@property (weak, nonatomic) IBOutlet UISlider *sliderDistance;
- (IBAction)onSliderChangedValue:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAllCategory;

//Category
- (IBAction)onCategoryButtonClicked:(id)sender;
- (IBAction)onAllCategoryButtonClicked:(id)sender;

//Order
@property (weak, nonatomic) IBOutlet UIButton *btnPost;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segPost;
@property (weak, nonatomic) IBOutlet UIButton *btnPopular;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segPopular;
- (IBAction)onOrderButtonClicked:(id)sender;
- (IBAction)onOrderSegmentChangedValue:(id)sender;

//Commit
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
- (IBAction)onBtnCommitClicked:(id)sender;

@end
