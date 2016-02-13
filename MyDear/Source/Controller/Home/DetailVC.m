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
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    defaultTbFr = self.tableView.frame;
    defaultCmtFr = self.viewComment.frame;
    [_txtvComment.layer setMasksToBounds:YES];
    [_txtvComment.layer setCornerRadius:5];
    [_txtvComment.layer setBorderWidth:1];
//    [_txtvComment.layer setBorderColor:[CGColorRef colorFromHexString:@"#000000"]];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PostImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostImageCell"];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_post.imageUrl]
        placeholderImage:[UIImage imageNamed:@"selectPhoto.png"]];
        return cell;
    } else if (indexPath.section == 1) {
        PostInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostInfoCell"];
        [cell.lblViewNum setText:[NSString stringWithFormat:@"%ld", _post.likeNum]];
        [cell.lblCommentNum setText:[NSString stringWithFormat:@"12345%ld", _post.likeNum]];
        [cell.lblStarNum setText:[NSString stringWithFormat:@"4%ld", _post.likeNum]];
        [cell.lblTime setText:[Lib stringFromDate:_post.deliverTime formatter:DATE_TIME_FORMAT]];
        [cell.txtvStatus setText:_post.textContent];
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
        comment = _txtvComment.text;
        NSLog(@"comment = %@", comment);
        _txtvComment.text = @"";
        [_txtvComment endEditing:YES];
    }
}

#pragma mark - Comment



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

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return [textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        [_lblCmtPlaceholder setHidden:NO];
    } else {
        [_lblCmtPlaceholder setHidden:YES];
    }
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    keyboardHeight = kbSize.height;
    [self showChatView];
}

- (void)keyboardWillHide:(NSNotification*)aNotification {
    [self hideChatView];
    [_txtvComment endEditing:YES];
}

- (void)showChatView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect tbFrame = defaultTbFr;
    tbFrame.size.height -= keyboardHeight;
    [self.tableView setFrame:tbFrame];
//    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:/*listComments.count*/3 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [self.tableView.layer setBorderWidth:2];
    
    CGRect frame = defaultCmtFr;
    frame.origin.y -= keyboardHeight;
    [self.viewComment setFrame:frame];
    
    [UIView commitAnimations];
}

- (void)hideChatView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [self.tableView setFrame:defaultTbFr];
    [self.viewComment setFrame:defaultCmtFr];
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
