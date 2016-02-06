//
//  SendImageCollectionViewCell.m
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "SendImageCollectionViewCell.h"

@implementation SendImageCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)sendImageAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickOnCellAtIndex:withImage:)]) {
        [self.delegate didClickOnCellAtIndex:_cellIndex withImage:self.tempImageView.image];
    }
}

@end
