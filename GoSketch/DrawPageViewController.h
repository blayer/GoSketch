//
//  DrawPageViewController.h
//  PaintBoard
//
//  Created by Changkun Zhao on 4/2/15.
//  Copyright (c) 2015 Changkun Zhao. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface DrawPageViewController : UIViewController

{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
   }
@property (weak, nonatomic) IBOutlet UIImageView *penImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIButton *eraseButton;
@property (weak, nonatomic) IBOutlet UIButton *customizeButton;
@property (weak, nonatomic) IBOutlet UISlider *sliderBar;
@property (strong,nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *deepGreenButton;
@property (weak, nonatomic) IBOutlet UIButton *purpleButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIImageView *upperBar;


- (IBAction)clearAction:(id)sender;
- (IBAction)saveAction:(id)sender;
- (IBAction)eraseAction:(id)sender;
- (IBAction)slideBarChanged:(id)sender;
- (IBAction)colorSelected:(id)sender;
- (IBAction)customizeColor:(id)sender;
- (IBAction)backAction:(id)sender;


@end
