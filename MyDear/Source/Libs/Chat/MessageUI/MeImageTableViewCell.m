//
//  MeImageTableViewCell.m
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "MeImageTableViewCell.h"

@implementation MeImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.messageImageView.layer.borderColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
