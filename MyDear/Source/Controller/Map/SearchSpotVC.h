//
//  SearchSpotVC.h
//  MyDear
//
//  Created by phuongthuy on 2/14/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchSpotVC : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *btnCurLoc;
@property (weak, nonatomic) IBOutlet UIButton *btnOtherLoc;
- (IBAction)onBtnLocationClicked:(id)sender;

- (IBAction)onReloadBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtfLocation;

@property (weak, nonatomic) IBOutlet UISlider *sliderSpot;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
- (IBAction)onControlBtnClicked:(id)sender;

@end
