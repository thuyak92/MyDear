//
//  AccountInfoVC.h
//  MyDear
//
//  Created by phuongthuy on 1/20/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

@interface AccountInfoVC : UITableViewController<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RestKitLibDelegate>
{
    NSData *avatar;
    NSInteger idSearch, location;
}
@property (weak, nonatomic) IBOutlet UITextField *txtfNickname;
@property (weak, nonatomic) IBOutlet UITextField *txtfComment;
@property (weak, nonatomic) IBOutlet UITextField *txtfMyspot;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segIdSearch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segLocation;
- (IBAction)onSegmentChangeValue:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imvAvatar;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (weak, nonatomic) IBOutlet UIButton *btnLibrary;
- (IBAction)onButtonClicked:(id)sender;

@end
