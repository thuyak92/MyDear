//
//  DetailPostInfoCell.h
//  MyDear
//
//  Created by phuongthuy on 2/3/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailPostInfoCell;

@interface DetailPostInfoCell : UITableViewCell
+ (DetailPostInfoCell *)createView;
@property (weak, nonatomic) IBOutlet UILabel *lblViewNum;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentNum;
@property (weak, nonatomic) IBOutlet UILabel *lblStarNum;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UITextView *txtvStatus;

@end
