//
//  MessageVC.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "MessageVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MessageVC ()

@end

@implementation MessageVC

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    UserModel *user = listUsers[indexPath.row];
    cell.textLabel.text = user.nickname;
//    cell.detailTextLabel.text = user.desc;
    [cell.imageView.layer setMasksToBounds:YES];
    [cell.imageView.layer setCornerRadius:15];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]
                      placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
    
    CALayer * layer = [cell.imageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:22.0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedUser = listUsers[indexPath.row];
#warning send request to get list message at pass
    
}

#pragma mark - RestKit
- (void)onGetObjectsSuccess:(LibRestKit *)controller data:(NSArray *)objects
{
//    messages = [NSMutableArray arrayWithArray:objects];
//    JChatViewController *chat = [[UIStoryboard storyboardWithName:@"JChat" bundle:nil] instantiateViewControllerWithIdentifier:@"JChat"];
//    chat.messagesArray = messages;
//    [Lib getImageFromUrl:selectedUser.avatarUrl callback:^(NSData *data) {
//        chat.guestAvatar = [UIImage imageWithData:data];
//        [self presentViewController:chat animated:YES completion:nil];
//    }];;
}

@end
