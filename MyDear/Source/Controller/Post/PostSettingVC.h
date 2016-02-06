//
//  PostSettingVC.h
//  MyDear
//
//  Created by phuongthuy on 1/16/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

@interface PostSettingVC : UITableViewController<UITextViewDelegate, RestKitLibDelegate>
{
    NSInteger userType, spot, setDate, category;
    NSString *location;
    UIView *view;
    CGFloat height;
    NSDate *date;
    UserModel *user;
}
@property (nonatomic, strong) NSData *imageData;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextView *txtvStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceholder;
@property (weak, nonatomic) IBOutlet UIButton *btnChangePost;
- (IBAction)onChangePostButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnAllOfUsers;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectFromPost;
@property (weak, nonatomic) IBOutlet UIImageView *imvAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeUser;
@property (weak, nonatomic) IBOutlet UIButton *btnLimitPost;
- (IBAction)onPrivacyButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCurLoc;
@property (weak, nonatomic) IBOutlet UIButton *btnOtherLoc;
@property (weak, nonatomic) IBOutlet UIButton *btnNotPublic;
@property (weak, nonatomic) IBOutlet UIButton *btnReload;
@property (weak, nonatomic) IBOutlet UIButton *btnMap;
@property (weak, nonatomic) IBOutlet UITextField *txtfLocation;
- (IBAction)onSpotButtonClicked:(id)sender;
- (IBAction)onLocationButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSetDateNone;
@property (weak, nonatomic) IBOutlet UIButton *btnSetDate;
@property (weak, nonatomic) IBOutlet UILabel *lblSetDate;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeDate;
- (IBAction)onSetDateButtonClicked:(id)sender;
- (IBAction)onChangeDateButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)onDatePickerChangeValue:(id)sender;

- (IBAction)onCategoryButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnInstagram;
@property (weak, nonatomic) IBOutlet UIButton *btnTwitter;
@property (weak, nonatomic) IBOutlet UIButton *btnLine;
- (IBAction)onShareButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnPost;
- (IBAction)onControlButtonClicked:(id)sender;

@end
