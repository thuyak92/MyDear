//
//  PostVC.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PostVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSelectPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnInstagram;
@property (weak, nonatomic) IBOutlet UIButton *btnEditKeep;
- (IBAction)onButonClicked:(id)sender;

@end
