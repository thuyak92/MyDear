//
//  SearchVC.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "SearchVC.h"
#import "AppDelegate.h"
#import "LibLocation.h"

@interface SearchVC ()

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [LibRestKit share].delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    categories = [[NSMutableArray alloc] initWithCapacity:12];
    [_sliderDistance setThumbImage:[UIImage imageNamed:@"iconSlider.png"] forState:0];
    lblSlider = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 45, 14)];
    [lblSlider setText:[NSString stringWithFormat:@"%.0fkm", _sliderDistance.value]];
    [lblSlider setFont:[UIFont systemFontOfSize:13]];
    [lblSlider setTextAlignment:NSTextAlignmentCenter];
    [_sliderDistance addSubview:lblSlider];
    
//    [_sliderDistance bringSubviewToFront:lblSlider];
//    _sliderDistance.cu
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btnBack.png"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(dismissModalViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self setDefaultSearch];
    [self setLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLocation
{
    
    locationName = [[LibLocation shareLocation] locationName];
    [_txtfLocation setText:locationName];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setDefaultSearch
{
    [_btnAllOfUser setSelected:YES];
    [_btnCurLoc setSelected:YES];
    [_btnPost setSelected:YES];
    orderKey = @"order_time";
    orderValue = @"desc";
    [_segPopular setEnabled:NO];
    [_txtfLocation setEnabled:NO];
    [_txtfLocation setBackground:[UIImage imageNamed:@""]];
}

#pragma mark - action

- (IBAction)onUserButtonClicked:(id)sender {
    [_btnAllOfUser setSelected:NO];
    [_btnFriend setSelected:NO];
    [_btnPublic setSelected:NO];
    if (sender == _btnAllOfUser) {
        [_btnAllOfUser setSelected:YES];
    } else if (sender == _btnFriend) {
        [_btnFriend setSelected:YES];
    } else {
        [_btnPublic setSelected:YES];
    }
    userType = ((UIButton *)sender).tag;
}

- (IBAction)onSpotButtonClicked:(id)sender {
    [_btnCurLoc setSelected:NO];
    [_btnOtherLoc setSelected:NO];
    [_btnReload setHidden:YES];
    [_txtfLocation setEnabled:NO];
    [_txtfLocation setBackground:[UIImage imageNamed:@""]];
    if (sender == _btnCurLoc) {
        [_btnCurLoc setSelected:YES];
        [_btnReload setHidden:NO];
    } else if (sender == _btnOtherLoc) {
        [_btnOtherLoc setSelected:YES];
        [_txtfLocation setEnabled:YES];
        [_txtfLocation setBackground:[UIImage imageNamed:@"btnGreyBorderSqr.png"]];
    }
    spot = ((UIButton *)sender).tag;
}

- (IBAction)onLocationButtonClicked:(id)sender {
    if (sender == _btnReload) {
        [self setLocation];
    }
}
- (IBAction)onSliderChangedValue:(id)sender {
//    NSLog(@"distance = %f", _sliderDistance.value);
    CGRect trackRect = [_sliderDistance trackRectForBounds:_sliderDistance.bounds];
    CGRect thumbRect = [_sliderDistance thumbRectForBounds:_sliderDistance.bounds
                                             trackRect:trackRect
                                                 value:_sliderDistance.value];
    
    lblSlider.center = CGPointMake(thumbRect.origin.x + _sliderDistance.frame.origin.x + 20,  _sliderDistance.frame.origin.y + 37);
    [lblSlider setText:[NSString stringWithFormat:@"%.0fkm", _sliderDistance.value]];
//    distance = _sliderDistance.value;
}

- (IBAction)onCategoryButtonClicked:(id)sender {
    [_btnAllCategory setSelected:NO];
    if ([sender isSelected]) {
        [sender setSelected:NO];
    } else {
        [sender setSelected:YES];
        NSInteger category = ((UIButton *)sender).tag;
        [categories addObject:@(category)];
    }
}

- (IBAction)onAllCategoryButtonClicked:(id)sender {
    
    if ([sender isSelected]) {
        [sender setSelected:NO];
    } else {
        //clear data
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
        for (UIView *vi in [cell.contentView subviews]) {
            if ([vi isKindOfClass:[UIButton class]]) {
                ((UIButton *)vi).selected = NO;
            }
        }
        [categories removeAllObjects];
        
        //search for all category
        [sender setSelected:YES];
        [categories addObject:@(_btnAllCategory.tag)];
    }
}

- (IBAction)onOrderButtonClicked:(id)sender {
    [_btnPost setSelected:NO];
    [_btnPopular setSelected:NO];
    [_segPost setEnabled:NO];
    [_segPopular setEnabled:NO];
    if (sender == _btnPost) {
        [_btnPost setSelected:YES];
        [_segPost setEnabled:YES];
        orderKey = @"order_time";
    } else {
        [_btnPopular setSelected:YES];
        [_segPopular setEnabled:YES];
        orderKey = @"order_liked";
    }
}

- (IBAction)onOrderSegmentChangedValue:(id)sender {
    NSInteger value = ((UISegmentedControl *)sender).selectedSegmentIndex;
    if (value == 1) {
        orderValue = @"asc";
    } else {
        orderValue = @"desc";
    }
}

- (IBAction)onBtnCommitClicked:(id)sender {
    if (sender == _btnCancel) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [[LibRestKit share] getObjectsAtPath:[self createSearchRequest] forClass:CLASS_POST];
    }
}

#pragma mark - RestKit

- (NSDictionary *)getSearchData
{
    if (spot == TYPE_OTHER_LOCATION) {
        longitude = 0.0;
        latitude = 0.0;
        if (locationName == nil || locationName.length == 0) {
            //validate name
            [self setLocation];
        }
    } else {
        longitude = [[LibLocation shareLocation] longitude];
        latitude = [[LibLocation shareLocation] latitude];
        locationName = @"";
    }
    NSString *cat = [[categories valueForKey:@"description"] componentsJoinedByString:@","];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @(userType), @"privacy_setup",
                          orderValue, orderKey,
                          cat, @"category_id",
                          @(_sliderDistance.value), @"distance",
                          @(longitude), @"longitude",
                          @(latitude), @"latitude",
                          locationName, @"name",
                          nil];
    return dict;
}

- (NSString *)createSearchRequest
{
    NSDictionary *params = [self getSearchData];
    NSString *search = [Lib addQueryStringToUrlString: URL_SEARCH withDictionary:params];
    NSLog(@"search = %@", search);
    return search;
}

#pragma mark - SearchBar delegate
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [self sendSearch:_searchLoc.text];
//    [_searchLoc resignFirstResponder];
//    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - RestKit

- (void)onGetObjectsSuccess:(LibRestKit *)controller data:(NSArray *)objects
{
    NSLog(@"arr%@", objects);
}

@end
