//
//  DetailPostInfoCell.m
//  MyDear
//
//  Created by phuongthuy on 2/3/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "DetailPostInfoCell.h"

@implementation DetailPostInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (DetailPostInfoCell *)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DetailPostInfoCell" owner:self options:nil] objectAtIndex:0];
}

@end
