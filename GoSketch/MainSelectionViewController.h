//
//  MainSelectionViewController.h
//  PaintBoard
//
//  Created by Changkun Zhao on 4/2/15.
//  Copyright (c) 2015 Changkun Zhao. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface MainSelectionViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *emptyImageButton;

@property (weak, nonatomic) IBOutlet UIButton *loadImageButton;
- (IBAction)emptyButtonClicked:(id)sender;

- (IBAction)loadButtionClicked:(id)sender;
@end
