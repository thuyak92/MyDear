//
//  DetailVC.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "DetailVC.h"
#import "Lib.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailPostInfoCell.h"
#import "DetailCommentCell.h"


@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedRowHeight = self.tableView.rowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return listComments.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.tableView.frame.size.width;
    }
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    if (indexPath.section == 0) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_post.imageUrl]
        placeholderImage:[UIImage imageNamed:@"selectPhoto.png"]];
        return cell;
    } else if (indexPath.section == 1) {
        DetailPostInfoCell *cell = [DetailPostInfoCell createView];
        [cell.lblViewNum setText:[NSString stringWithFormat:@"%ld", _post.likeNum]];
        [cell.lblCommentNum setText:[NSString stringWithFormat:@"%ld", _post.likeNum]];
        [cell.lblStarNum setText:[NSString stringWithFormat:@"%ld", _post.likeNum]];
        [cell.lblTime setText:[Lib stringFromDate:_post.deliverTime formatter:DATE_TIME_FORMAT]];
        [self.view layoutIfNeeded];
        // do your own text change here.
//        self.txtfComment.text = [NSString stringWithFormat:@"%@, %@", self.infoTextView.text, self.infoTextView.text];
//        [self.txtfComment setNeedsUpdateConstraints];
//        [self.txtfComment updateConstraintsIfNeeded];
//        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//            [self.view layoutIfNeeded];
//        } completion:nil];
//        [cell.lblStatus setNumberOfLines:10];
        [cell.txtvStatus sizeThatFits:cell.txtvStatus.frame.size];
        [cell.txtvStatus sizeToFit];
        [cell.txtvStatus setText:_post.textContent];
        return cell;
    } else if (indexPath.section == 2) {
        
    }
    return cell;
}

- (IBAction)onButtonClicked:(id)sender {
    if (sender == _btnBack) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (sender == _btnSend) {
        
    }
}

#pragma mark - Comment

- (void)showChatView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [_tableView setFrame:CGRectMake(0, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height-keyboardHeight)];
    [_viewComment setFrame:CGRectMake(0, _viewComment.frame.origin.y-keyboardHeight, _viewComment.frame.size.width, _viewComment.frame.size.height)];
    [UIView commitAnimations];
}

- (void)hideChatView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [_tableView setFrame:CGRectMake(0, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height+keyboardHeight)];
    [_viewComment setFrame:CGRectMake(0, _viewComment.frame.origin.y+keyboardHeight, _viewComment.frame.size.width, _viewComment.frame.size.height)];
    [UIView commitAnimations];
    [_txtfComment endEditing:YES];
}

- (void)sendChatMessage
{
//    if (txtfChat.text && txtfChat.text.length != 0) {
//        [[SocketLib shareSocketLib] sendChatMessage:txtfChat.text TableID:[Libs getTableID]];
//        txtfChat.text = @"";
//    }
//    [self performSelector:@selector(hideChatView) withObject:nil afterDelay:3];
}

//- (void)onChatReceived:(SocketLib *)controller message:(NSString *)mess username:(NSString *)name
//{
//    [self showChatView];
//    NSString *curText = txtvChat.text;
//    curText = [curText stringByAppendingString:@"\n"];
//    curText = [curText stringByAppendingString:[NSString stringWithFormat:@"%@: %@", name, mess]];
//    [txtvChat setText:curText];
//    
//    NSRange range = NSMakeRange(txtvChat.text.length - 1, 1);
//    [txtvChat scrollRangeToVisible:range];
//    if (keyboardSize.height == 0) {
//        [self performSelector:@selector(hideChatView) withObject:self afterDelay:3];
//    }
//    
//}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendChatMessage];
    [_txtfComment endEditing:YES];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_txtfComment becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_txtfComment resignFirstResponder];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    // Get the size of the keyboard.
    keyboardY = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].origin.y;
    keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self showChatView];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    // Get the size of the keyboard.
    //    keyboardSize = CGSizeMake(0, 0);
    [self hideChatView];
    keyboardHeight = 0;
}

@end
