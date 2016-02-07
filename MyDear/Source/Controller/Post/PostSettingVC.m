//
//  PostSettingVC.m
//  MyDear
//
//  Created by phuongthuy on 1/16/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostSettingVC.h"
#import "LibLocation.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"

@interface PostSettingVC ()

@end

@implementation PostSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [LibRestKit share].delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btnBack.png"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(dismissModalViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self setDefaultPost];
}

- (void)viewDidAppear:(BOOL)animated
{
    [_image setImage:[UIImage imageWithData:_imageData]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLocation
{
    location = [[LibLocation shareLocation] locationName];
    [_txtfLocation setText:location];
}

- (void)setDefaultPost
{
    user = [Lib currentUser];
    [_btnAllOfUsers setSelected:YES];
    [_imvAvatar sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]
                  placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
    [_imvAvatar.layer setMasksToBounds:YES];
    [_imvAvatar.layer setCornerRadius:10];
    [_lblName setText:user.nickname];
    [_btnCurLoc setSelected:YES];
    [_btnSetDateNone setSelected:YES];
    [_btnChangeDate setHidden:YES];
    [self setLocation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onPrivacyButtonClicked:(id)sender {
    [_btnAllOfUsers setSelected:NO];
    [_btnSelectFromPost setSelected:NO];
    [_btnLimitPost setSelected:NO];
    [_lblName setHidden:YES];
    [_imvAvatar setHidden:YES];
    if (sender == _btnAllOfUsers) {
        [_btnAllOfUsers setSelected:YES];
    } else if (sender == _btnSelectFromPost) {
        [_btnSelectFromPost setSelected:YES];
        [_lblName setHidden:NO];
        [_imvAvatar setHidden:NO];
    } else if (sender == _btnLimitPost) {
        [_btnLimitPost setSelected:YES];
    } else {
#warning change privacy
    }
    userType = ((UIButton *)sender).tag;
}

- (IBAction)onChangePostButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSpotButtonClicked:(id)sender {
    [_btnCurLoc setSelected:NO];
    [_btnOtherLoc setSelected:NO];
    [_btnNotPublic setSelected:NO];
    [_btnReload setHidden:YES];
    [_btnMap setHidden:YES];
    if (sender == _btnCurLoc) {
        [_btnCurLoc setSelected:YES];
        [_btnReload setHidden:NO];
        [_txtfLocation setUserInteractionEnabled:NO];
        [self setLocation];
    } else if (sender == _btnOtherLoc) {
        [_btnOtherLoc setSelected:YES];
        [_btnMap setHidden:NO];
        [_txtfLocation setUserInteractionEnabled:YES];
    } else if (sender == _btnNotPublic) {
        location = @"";
        [_txtfLocation setText:@""];
    }
    spot = ((UIButton *)sender).tag;
}

- (IBAction)onLocationButtonClicked:(id)sender {
    if (sender == _btnMap) {
    UITabBarController *tabVC = (UITabBarController *)self.presentingViewController;
    [tabVC setSelectedIndex:1];
    [self dismissViewControllerAnimated:YES completion:nil];
    } else if (sender == _btnReload) {
        [self setLocation];
    }
}

- (IBAction)onSetDateButtonClicked:(id)sender {
    [_btnSetDateNone setSelected:NO];
    [_btnSetDate setSelected:NO];
    [_btnChangeDate setHidden:YES];
    [_lblSetDate setText:@""];
    if (sender == _btnSetDateNone) {
        [_btnSetDateNone setSelected:YES];
        date = [NSDate date];
        [self hideDatePicker];
    } else if (sender == _btnSetDate) {
        [_btnSetDate setSelected:YES];
        [_btnChangeDate setHidden:NO];
        date = [NSDate date];
        [_lblSetDate setText:[Lib stringFromDate:date formatter:DATE_TIME_FORMAT]];
    }
    setDate = ((UIButton *)sender).tag;
}

- (IBAction)onChangeDateButtonClicked:(id)sender {
    if ([_btnChangeDate isSelected]) {
        [_btnChangeDate setSelected:NO];
        [self hideDatePicker];
    } else {
        [_btnChangeDate setSelected:YES];
        [self showDatePicker];
        [self showDatePicker];
    }
}

#pragma mark - Table Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    if (indexPath.section == 3 && indexPath.row == 2) {
        return height;
    }
    return 40;
}

#pragma mark - TextView

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return [textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        [_lblPlaceholder setHidden:NO];
    } else {
        [_lblPlaceholder setHidden:YES];
    }
}

#pragma mark - Date Picker

- (void)showDatePicker
{
    height = 216;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
    [_datePicker setHidden:NO];
}

- (void)hideDatePicker
{
    height = 0;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
    [_datePicker setHidden:YES];
}

- (IBAction)onDatePickerChangeValue:(id)sender {
    date = _datePicker.date;
    [_lblSetDate setText:[Lib stringFromDate:date formatter:DATE_TIME_FORMAT]];
}

- (IBAction)onCategoryButtonClicked:(id)sender {
    for (int i = 0; i < 3; i++) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:4]];
        for (UIView *vi in [cell.contentView subviews]) {
            if ([vi isKindOfClass:[UIButton class]]) {
                [(UIButton *)vi setSelected:NO];
            }
        }
    }
    [sender setSelected:YES];
    category = ((UIButton *)sender).tag;
}

- (IBAction)onShareButtonClicked:(id)sender {
    
}

- (IBAction)onControlButtonClicked:(id)sender {
    if (sender == _btnCancel) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (sender == _btnPost) {
        [self postData];
    } else {
#warning save settings
    }
}

#pragma mark - RestKit

- (PostModel *)getPostData
{
    PostModel *post = [[PostModel alloc] init];
    post.user = user;
    post.userId = post.user.userId;
    post.textContent = _txtvStatus.text;
    post.longitude = [[LibLocation shareLocation] longitude];
    post.latitude = [[LibLocation shareLocation] latitude];
    post.locationName = [[LibLocation shareLocation] locationName];
    post.deliverTime = date;
    post.privacySetup = userType;
    post.categoryId = category;
    return post;
}

- (void)postData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [[LibRestKit share] postObject:[self getPostData] toPath:URL_POST method:RKRequestMethodPOST withData:_imageData fileName:@"image_file" forClass:CLASS_POST];
}

- (void)onPostObjectSuccess:(LibRestKit *)controller data:(id)object
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app switchToTabWithIndex:TAB_HOME];
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
