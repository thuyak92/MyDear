//
//  PostCell.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imvPost;
@property (weak, nonatomic) IBOutlet UIImageView *imvAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *imvFriendAva;
@property (weak, nonatomic) IBOutlet UIImageView *imvView;
@property (weak, nonatomic) IBOutlet UIImageView *imvComment;
@property (weak, nonatomic) IBOutlet UIImageView *imvStar;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblViewNum;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentNum;
@property (weak, nonatomic) IBOutlet UILabel *lblStarNum;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;

+ (PostCell *)createView;

@end
