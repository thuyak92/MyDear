//
//  PostCell.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    // Initialization code
}

+ (PostCell *)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"PostCell" owner:self options:nil] objectAtIndex:0];
}

@end
