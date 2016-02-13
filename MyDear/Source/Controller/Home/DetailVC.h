//
//  DetailVC.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

@interface DetailVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
{
    NSMutableArray *listComments;
    NSString *comment;
    float keyboardHeight;
    UserModel *user;
    CGRect defaultTbFr, defaultCmtFr;
}

@property (strong, nonatomic) PostModel *post;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIImageView *imvAvar;
@property (weak, nonatomic) IBOutlet UIImageView *imvPrivacy;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *txtvComment;
@property (weak, nonatomic) IBOutlet UILabel *lblCmtPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *viewComment;

@property (weak, nonatomic) IBOutlet UIButton *btnSend;

- (IBAction)onButtonClicked:(id)sender;

@end
