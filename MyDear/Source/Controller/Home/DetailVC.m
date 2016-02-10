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
#import "PostInfoCell.h"
#import "PostImageCell.h"
#import "CommentCell.h"


@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"sdahgiew");
    user = [Lib currentUser];
    // Do any additional setup after loading the view.
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
//    cellHeight = 44;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

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
        return 3;// listComments.count;
    }
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        return self.tableView.frame.size.width;
//    }
//    
//    return cellHeight + 40;
//}

- (CGSize)frameForText:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [text boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:attributesDictionary
                                      context:nil];
    
    // This contains both height and width, but we really care about height.
    return frame.size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [cell setSeparatorInset:UIEdgeInsetsZero];
    if (indexPath.section == 0) {
        PostImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostImageCell"];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_post.imageUrl]
        placeholderImage:[UIImage imageNamed:@"selectPhoto.png"]];
        return cell;
    } else if (indexPath.section == 1) {
        PostInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostInfoCell"];
        
        
        
        
//        DetailPostInfoCell *cell = (DetailPostInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"PostInfo" forIndexPath:indexPath];
//        DetailPostInfoCell *cell = [DetailPostInfoCell createView];
        [cell.lblViewNum setText:[NSString stringWithFormat:@"%ld", _post.likeNum]];
        [cell.lblCommentNum setText:[NSString stringWithFormat:@"12345%ld", _post.likeNum]];
        [cell.lblStarNum setText:[NSString stringWithFormat:@"4%ld", _post.likeNum]];
        [cell.lblTime setText:[Lib stringFromDate:_post.deliverTime formatter:DATE_TIME_FORMAT]];
//
        [cell.txtvStatus setText:_post.textContent];
        
////        CGSize size = [cell.txtvStatus sizeThatFits:CGSizeMake(cell.txtvStatus.frame.size.width, 500)];
//        [cell.txtvStatus sizeToFit];
//        cellHeight = cell.txtvStatus.contentSize.height;
//        NSLog(@" size = %f", cellHeight);
//        [cell.txtvStatus setFrame:CGRectMake(cell.txtvStatus.frame.origin.x, cell.txtvStatus.frame.origin.y, cell.txtvStatus.frame.size.width, 133)];
//        [cell.txtvStatus reloadInputViews];
////        [cell.contentView setFrame:CGRectMake(cell.txtvStatus.frame.origin.x, cell.txtvStatus.frame.origin.y, cell.txtvStatus.frame.size.width, cellHeight+40)];
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        return cell;
    } else if (indexPath.section == 2) {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
//        [cell.imvAva sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]
//    placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
//        cell.lblName.text = user.nickname;
        cell.lblTime.text = [Lib stringFromDate:_post.deliverTime formatter:DATE_TIME_FORMAT];
        cell.txtvComment.text = _post.textContent;
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"cell"];
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

//- (void)keyboardWasShown:(NSNotification *)notification {
//    // Get the size of the keyboard.
//    keyboardY = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].origin.y;
//    keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
//    [self showChatView];
//}
//
//- (void)keyboardWillHide:(NSNotification *)notification {
//    // Get the size of the keyboard.
//    //    keyboardSize = CGSizeMake(0, 0);
//    [self hideChatView];
//    keyboardHeight = 0;
//}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0.0, kbSize.height, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification*)aNotification {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.35];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0.0, 0.0, 0.0);
    self.tableView.contentInset = contentInsets;
    self.tableView.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
}

//- (CGFloat)textViewHeightForRowAtIndexPath: (NSIndexPath*)indexPath {
//    UITextView *calculationView = [textViews objectForKey: indexPath];
//    CGFloat textViewWidth = calculationView.frame.size.width;
//    if (!calculationView.attributedText) {
//        // This will be needed on load, when the text view is not inited yet
//        
//        calculationView = [[UITextView alloc] init];
//        calculationView.attributedText = // get the text from your datasource add attributes and insert here
//        textViewWidth = 290.0; // Insert the width of your UITextViews or include calculations to set it accordingly
//    }
//    CGSize size = [calculationView sizeThatFits:CGSizeMake(textViewWidth, FLT_MAX)];
//    return size.height;
//}

@end
