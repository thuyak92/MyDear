//
//  PostMapCell.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostMapCell.h"

@implementation PostMapCell

- (void)awakeFromNib {
    // Initialization code
}

+ (PostMapCell *)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PostMapCell" owner:self options:nil] objectAtIndex:0];
}

@end
