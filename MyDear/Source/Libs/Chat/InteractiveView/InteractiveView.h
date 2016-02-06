//
//  InteractiveView.h
//  MyDear
//
//  Created by phuongthuy on 1/8/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractiveView : UIView

@property (nonatomic, copy) void (^inputAcessoryViewFrameChangedBlock)(CGRect frame);
@property (nonatomic, readonly) CGRect inputAcesssorySuperviewFrame;
@end
