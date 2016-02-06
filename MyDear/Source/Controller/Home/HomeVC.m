//
//  HomeVC.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "HomeVC.h"
#import "PostCell.h"
#import "LibLocation.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [LibRestKit share].delegate = self;
    // Do any additional setup after loading the view.
    [_cvPost registerNib:[UINib nibWithNibName:@"PostCell" bundle:nil] forCellWithReuseIdentifier:@"postCell"];
    listCategories = [NSArray arrayWithObjects:@"NEW", @"人気", @"お気に入り", @"ファッション", @"グルメ", @"観光", @"スポーツ", @"芸術", @"美容", @"記念", @"趣味", nil];
    [self setCategories];
    [self setLocation];
    listPosts = [[NSMutableArray alloc] init];
    
    [Lib sha256:@"mYdEaRaPi-DeV2016"];
    
    [[LibRestKit share] getObjectsAtPath:URL_POST forClass:CLASS_POST];
}

- (void)setLocation
{
    location = [[LibLocation shareLocation] locationName];
    [_lblLocation setText:location];
    [_lblDistance setText:[NSString stringWithFormat:@"%ldkm", [Lib getDistance]]];
    if (!location) {
        [self performSelector:@selector(setLocation) withObject:nil afterDelay:2];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (_reloadData) {
        _reloadData = NO;
        [[LibRestKit share] getObjectsAtPath:URL_POST forClass:CLASS_POST];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:SEGUE_HOME_TO_DETAIL]) {
        DetailVC *vc = [segue destinationViewController];
        vc.post = sender;
    }
}

#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return listPosts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *cell = (PostCell*)[_cvPost dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
    PostModel *post = listPosts[indexPath.row];
    [cell.imvPost sd_setImageWithURL:[NSURL URLWithString:post.imageUrl]
                      placeholderImage:[UIImage imageNamed:@"selectPhoto.png"]];
    [cell.imvAvatar.layer setMasksToBounds:YES];
    [cell.imvAvatar.layer setCornerRadius:15];
    [cell.imvAvatar sd_setImageWithURL:[NSURL URLWithString:post.user.avatarUrl]
                    placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://graph.facebook.com/olivier.poitrey/picture"]
//                 placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]
//                          options:SDWebImageRefreshCached];
    [cell.imvFriendAva setImage:[UIImage imageNamed:[NSString stringWithFormat:@"iconPrivacy%ld.png", post.privacySetup]]];
    [cell.lblName setText:post.user.nickname];
    [cell.lblViewNum setText:[NSString stringWithFormat:@"%ld", post.likeNum]];
    [cell.lblLocation setText:[NSString stringWithFormat:@"%@", post.locationName]];
    [cell.lblStatus setText:post.textContent];
    [cell.lblTime setText:[Lib stringFromDate:post.deliverTime formatter:TIME_FORMAT]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:SEGUE_HOME_TO_DETAIL sender:listPosts[indexPath.row]];
}

- (IBAction)onButtonClicked:(id)sender{
    if (sender == _btnSearchDetail) {
        [self performSegueWithIdentifier:SEGUE_HOME_TO_SEARCH sender:nil];
    } else if (sender == _btnSpot) {
//        [self postData];
    }
}

- (IBAction)onSegmentChangeValue:(id)sender{
    
}

- (void)onCategoriesButtonClicked: (UIButton *)button
{
    for (UIView *vi in [_scrCategories subviews]) {
        if ([vi isKindOfClass:[UIButton class]]) {
            [(UIButton *)vi setTitleColor:[Lib colorFromHexString:COLOR_DEFAULT] forState:0];
            [vi setBackgroundColor:[UIColor whiteColor]];
        }
    }
    [button setTitleColor:[UIColor whiteColor] forState:0];
    [button setBackgroundColor:[Lib colorFromHexString:COLOR_TINT]];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:15];
}

- (void)setCategories
{
    float width = 70;
    float height = _scrCategories.frame.size.height;
    [_scrCategories setContentSize:CGSizeMake(width*listCategories.count, height)];
    for (int i = 0; i < listCategories.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 5, width, height-10)];
        [btn setTitle:listCategories[i] forState:0];
        [btn setTitleColor:[Lib colorFromHexString:COLOR_DEFAULT] forState:0];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTag:i];
        [btn addTarget:self action:@selector(onCategoriesButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_scrCategories addSubview:btn];
        if (i == 0) {
            [btn setTitleColor:[UIColor whiteColor] forState:0];
            [btn setBackgroundColor:[Lib colorFromHexString:COLOR_TINT]];
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:15];
        }
    }
}

#pragma mark - RestKit


//- (void)postData
//{
//    RKObjectManager *manager = [RKObjectManager sharedManager];
//    [manager addResponseDescriptor:[ServiceRestKit rkDescResponseForClass:CLASS_POST]];
//    [manager addRequestDescriptor:[ServiceRestKit rkDescRequestForClass:CLASS_POST]];
//    
//    PostModel *post = listPosts[0];
//    [manager postObject:post path:URL_POST parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//        PostModel *p = [mappingResult firstObject];
//        NSLog(@"%@", p.textContent);
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//}

#pragma mark - SearchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self sendSearch:_searchPost.text];
    [_searchPost resignFirstResponder];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)sendSearch:(NSString *)searchText
{
    
}

#pragma mark - RestKit Delegate
- (void)onGetObjectsSuccess:(LibRestKit *)controller data:(NSArray *)objects
{
    listPosts = [NSMutableArray arrayWithArray:objects];
    [_cvPost reloadData];
}

@end
