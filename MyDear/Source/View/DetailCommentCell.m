//
//  DetailCommentCell.m
//  MyDear
//
//  Created by phuongthuy on 2/3/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "DetailCommentCell.h"

@implementation DetailCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (DetailCommentCell *)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DetailCommentCell" owner:self options:nil] objectAtIndex:0];
}

@end
