//
//  MessageCell.m
//  MyDear
//
//  Created by phuongthuy on 1/11/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (MessageCell *)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:self options:nil] objectAtIndex:0];
}

@end
