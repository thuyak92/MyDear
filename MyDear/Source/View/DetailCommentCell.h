//
//  DetailCommentCell.h
//  MyDear
//
//  Created by phuongthuy on 2/3/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailCommentCell;

@interface DetailCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvAva;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;

+ (DetailCommentCell *)createView;

@end
