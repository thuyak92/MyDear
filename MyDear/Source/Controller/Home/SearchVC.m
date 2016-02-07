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
#import "HomeVC.h"
#import "MapVC.h"

@interface SearchVC ()

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [LibRestKit share].delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btnBack.png"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(dismissModalViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self initSliderLabel];
}

- (void)viewDidAppear:(BOOL)animated
{
    search = [Lib loadDataWithKey:KEY_SEARCH];
    [_txtfLocation setText:search.name];
    [self setDefaultSearch];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self getSearchData];
    [Lib saveData:search forKey:KEY_SEARCH];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init data
- (void)initSliderLabel
{
    [_sliderDistance setThumbImage:[UIImage imageNamed:@"iconSlider.png"] forState:0];
    lblSlider = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 45, 14)];
    [lblSlider setText:[NSString stringWithFormat:@"%.0fkm", _sliderDistance.value]];
    [lblSlider setFont:[UIFont systemFontOfSize:13]];
    [lblSlider setTextAlignment:NSTextAlignmentCenter];
    [_sliderDistance addSubview:lblSlider];
}

- (void)setDefaultSearch
{
    [self setPrivacy];
    [self setLocation];
    [self setDistance];
    [self setOrderBy];
    [self setCategories];
}

#pragma mark - config
- (void)setPrivacy
{
    [_btnAllOfUser setSelected:NO];
    [_btnFriend setSelected:NO];
    [_btnPublic setSelected:NO];
    switch (search.privacySetup) {
        case TYPE_PRIVACY_PUBLIC:
            [_btnPublic setSelected:YES];
            break;
        case TYPE_PRIVACY_FRIEND:
            [_btnFriend setSelected:YES];
            break;
        default:
            [_btnAllOfUser setSelected:YES];
            break;
    }
}

- (void)setLocation
{
    [_btnCurLoc setSelected:NO];
    [_btnOtherLoc setSelected:NO];
    [_btnReload setHidden:YES];
    [_txtfLocation setEnabled:NO];
    [_txtfLocation setBackground:[UIImage imageNamed:@""]];
    if (search.spot == TYPE_CURRENT_LOCATION) {
        [_btnCurLoc setSelected:YES];
        [_btnReload setHidden:NO];
    } else if (search.spot == TYPE_OTHER_LOCATION) {
        [_btnOtherLoc setSelected:YES];
        [_txtfLocation setEnabled:YES];
        [_txtfLocation setBackground:[UIImage imageNamed:@"btnGreyBorderSqr.png"]];
    }
    [_sliderDistance setValue:search.distance];
    
}

- (void)setDistance
{
    CGRect trackRect = [_sliderDistance trackRectForBounds:_sliderDistance.bounds];
    CGRect thumbRect = [_sliderDistance thumbRectForBounds:_sliderDistance.bounds
                                                 trackRect:trackRect
                                                     value:_sliderDistance.value];
    
    lblSlider.center = CGPointMake(thumbRect.origin.x + _sliderDistance.frame.origin.x + 20,  _sliderDistance.frame.origin.y + 37);
    [lblSlider setText:[NSString stringWithFormat:@"%.0fkm", _sliderDistance.value]];
}

- (void)setOrderBy
{
    [_btnPost setSelected:NO];
    [_btnPopular setSelected:NO];
    [_segPost setEnabled:NO];
    [_segPopular setEnabled:NO];
    if ([search.orderKey isEqualToString:TYPE_ORDER_TIME]) {
        [_btnPost setSelected:YES];
        [_segPost setEnabled:YES];
        if ([search.orderValue isEqualToString:TYPE_ORDER_VALUE_DESC]) {
            [_segPost setSelectedSegmentIndex:0];
        } else {
            [_segPost setSelectedSegmentIndex:1];
        }
    } else {
        [_btnPopular setSelected:YES];
        [_segPopular setEnabled:YES];
        if ([search.orderValue isEqualToString:TYPE_ORDER_VALUE_DESC]) {
            [_segPopular setSelectedSegmentIndex:0];
        } else {
            [_segPopular setSelectedSegmentIndex:1];
        }
    }
}

- (void)setCategories
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    for (UIView *vi in [cell.contentView subviews]) {
        if ([vi isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)vi;
            if ([search.category containsObject:@(btn.tag)])
            {
                [btn setSelected:YES];
            } else{
                [btn setSelected:NO];
            }
        }
    }
}

#pragma mark - action

- (IBAction)onUserButtonClicked:(id)sender {
    search.privacySetup = ((UIButton *)sender).tag;
    [self setPrivacy];
}

- (IBAction)onSpotButtonClicked:(id)sender {
    search.spot = ((UIButton *)sender).tag;
    [self setLocation];
}

- (IBAction)onLocationButtonClicked:(id)sender {
    if (sender == _btnReload) {
        [_txtfLocation setText:search.name];
    }
}

- (IBAction)onSliderChangedValue:(id)sender {
    [self setDistance];
}

- (IBAction)onCategoryButtonClicked:(id)sender {
    [search.category removeObject:@(0)];
    NSInteger category = ((UIButton *)sender).tag;
    if ([sender isSelected]) {
        [search.category removeObject:@(category)];
    } else {
        [search.category addObject:@(category)];
    }
    [self setCategories];
}

- (IBAction)onAllCategoryButtonClicked:(id)sender {
    [search.category removeAllObjects];
    if (![sender isSelected]) {
        [search.category addObject:@(_btnAllCategory.tag)];
    }
    [self setCategories];
}

- (IBAction)onOrderButtonClicked:(id)sender {
    if (sender == _btnPost) {
        search.orderKey = @"order_time";
    } else {
        search.orderKey = @"order_liked";
    }
    [self setOrderBy];
}

- (IBAction)onOrderSegmentChangedValue:(id)sender {
    NSInteger value = ((UISegmentedControl *)sender).selectedSegmentIndex;
    if (value == 1) {
        search.orderValue = @"asc";
    } else {
        search.orderValue = @"desc";
    }
}

- (IBAction)onBtnCommitClicked:(id)sender {
    if (sender == _btnCancel) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        [[LibRestKit share] getObjectsAtPath:[self createSearchRequest] forClass:CLASS_POST];
    }
}

#pragma mark - RestKit

- (void)getSearchData
{
    if (search.spot == TYPE_OTHER_LOCATION) {
        if (search.name.length == 0) {
            AppDelegate *app = [[UIApplication sharedApplication] delegate];
            [app showAlertTitle:nil message:@"住所を入力してください。"];        }
    } else {
        search.longitude = [[LibLocation shareLocation] longitude];
        search.latitude = [[LibLocation shareLocation] latitude];
        search.name = @"";
    }
    search.distance = _sliderDistance.value;
}

- (NSString *)createSearchRequest
{
    [self getSearchData];
    NSString *cat = [[search.category valueForKey:@"description"] componentsJoinedByString:@","];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                          @(search.privacySetup), @"privacy_setup",
                          search.orderValue, search.orderKey,
                          cat, @"category_id",
                          @(search.distance), @"distance",
                          @(search.longitude), @"longitude",
                          @(search.latitude), @"latitude",
                          search.name, @"name",
                          nil];
    NSString *searchUrl = [Lib addQueryStringToUrlString: URL_SEARCH withDictionary:params];
    NSLog(@"search = %@", searchUrl);
    return searchUrl;
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
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    if (search.parentTab == TAB_HOME) {
        UINavigationController *nav = (UINavigationController *)self.parentViewController;
        HomeVC *vc = (HomeVC *)nav.parentViewController;
        vc.listPosts = [NSMutableArray arrayWithArray: objects];
    } else if (search.parentTab == TAB_MAP) {
        MapVC *vc = (MapVC *)self.parentViewController;
        vc.listPosts = [NSMutableArray arrayWithArray: objects];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
