//
//  MyPageVC.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "MyPageVC.h"
#import "Lib.h"
#import "AppDelegate.h"

@interface MyPageVC ()

@end

@implementation MyPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app checkLogin];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadData
{
//    RKObjectRequestOperation *operation = [ServiceRestKit rkObjRequestUrl:URL_USER forClass:CLASS_USER];
//    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
//        UserModel *user = [result firstObject];
//        NSLog(@"Mapped the article: %@\n%@", user.nickname, user.avatarUrl);
//    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//        NSLog(@"Failed with error: %@", [error localizedDescription]);
//    }];
//    [operation start];
}

- (IBAction)onButtonClicked:(id)sender {
    if (sender == _btnLogout) {
        [Lib setCurrentUser:nil];
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        [app checkLogin];
    }
}
@end
