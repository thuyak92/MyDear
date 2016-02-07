//
//  PostMapCell.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostMapCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvPost;
@property (weak, nonatomic) IBOutlet UIImageView *imvAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

+ (PostMapCell *)createView;

@end
