//
//  DrawPageViewController.m
//  This ViewController implements the main drawing interface of GoSketch.
//  The interface has three parts: function bar, draw panel, and color setting bar.
//
//  The function bar includes: 'backButton' to get back to main page,
//  'clearButton' to reset drawpanel as default blank page,
//  and 'saveButton' to save drawing in the photo album.
//
//  The draw panel includes two imageView: mainImage, and tempDrawImage.
//  In every touch movement, tempDrawImage is drawn by touch. When touch action finished,
//  tempDrawImage is added onto mainImage.
//
//  The color seting bar has 6 pre-define color, and a customized color. The customized color is implemented
//  by a third-party liabray "FCColorPickerViewController" at: https://github.com/fcanas/ios-color-picker
//
//  Created by Changkun Zhao on 4/2/15.
//  Copyright (c) 2015 Changkun Zhao. All rights reserved.
//
#import "DrawPageViewController.h"
#import "ActivityHub.h"
#import "PBColors.h"
#import "FCColorPickerViewController.h"
#import "MainSelectionViewController.h"


@interface DrawPageViewController ()<FCColorPickerViewControllerDelegate>
@property UIColor *drawColor;
@property (nonatomic, copy) UIColor *customizeColor;
@property UIImage *penImage;                 //image of pen figure
@property UIImage *ereasrImage;              //image of eraser figure
@property CGFloat *screenWidth;              //widthe of screen
@property CGFloat *screenHeight;             // height of screen

@end

@implementation DrawPageViewController

- (void)viewDidLoad {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.screenWidth = &(screenRect.size.width);
    self.screenHeight = &(screenRect.size.height);
    
    //setting buttons' shape, this part could be moved to storyboard.
    [self.redButton.layer setMasksToBounds:YES];
    [self.redButton.layer setCornerRadius:20.0f];
    [self.greenButton.layer setMasksToBounds:YES];
    [self.greenButton.layer setCornerRadius:20.0f];
    [self.deepGreenButton.layer setMasksToBounds:YES];
    [self.deepGreenButton.layer setCornerRadius:20.0f];
    [self.purpleButton.layer setMasksToBounds:YES];
    [self.purpleButton.layer setCornerRadius:20.0f];
    [self.blueButton.layer setMasksToBounds:YES];
    [self.blueButton.layer setCornerRadius:20.0f];
    [self.yellowButton.layer setMasksToBounds:YES];
    [self.yellowButton.layer setCornerRadius:20.0f];
    [self.customizeButton.layer setMasksToBounds:YES];
    [self.customizeButton.layer setCornerRadius:20.0f];
    [self.eraseButton.layer setMasksToBounds:YES];
    [self.eraseButton.layer setCornerRadius:20.0f];
    [self.backButton.layer setMasksToBounds:YES];
    [self.backButton.layer setCornerRadius:20.0f];
    [self.clearButton.layer setMasksToBounds:YES];
    [self.clearButton.layer setCornerRadius:20.0f];
    [self.saveButton.layer setMasksToBounds:YES];
    [self.saveButton.layer setCornerRadius:20.0f];

    
    //load default color settings
    self.customizeColor=PBWhite;
    [self.redButton setBackgroundColor:PBRed];
    [self.greenButton setBackgroundColor:PBGreen];
    [self.deepGreenButton setBackgroundColor:PBDeepGren];
    [self.purpleButton setBackgroundColor:PBPurple];
    [self.blueButton setBackgroundColor:PBBlue];
    [self.yellowButton setBackgroundColor:PBYellow];
    [self.customizeButton setBackgroundColor:self.customizeColor];
    [self.eraseButton setBackgroundColor:PBPurleWhite];
    [self.backButton setBackgroundColor:PBPurleWhite];
    [self.clearButton setBackgroundColor:PBPurleWhite];
    [self.saveButton setBackgroundColor:PBPurleWhite];
    [self.upperBar setBackgroundColor:PBGrey];
    self.drawColor=PBBlack;
    [self.drawColor getRed:&red green:&green blue:&blue alpha:&opacity];
    brush = 5.0;
    
    //slider image setting
    [self.sliderBar setThumbImage:[UIImage imageNamed:@"knob.png"] forState:UIControlStateNormal];
    [self.mainImage setImage:self.image];
    
    // pen image setting
    self.penImage=[UIImage imageNamed:@"Marker Pen-50.png"];
    
    //eraser iamge setting
    self.ereasrImage=[UIImage imageNamed:@"Eraser-50.png"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
    
    //visualize drawing pen
    CGFloat deltaX=0.5*self.penImageView.frame.size.width;
    CGFloat deltaY=0.5*self.penImageView.frame.size.height;
    self.penImageView.center=CGPointMake(lastPoint.x+deltaX, lastPoint.y-deltaY);
    
}
  /*TODO: the drawing function need to be improved with more drawing styles
   * and more smoother curves. Future work could use 'UIbezierpath' to visuallize
   * more smoother curves and curving algorithms.
   */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    CGFloat deltaX=0.5*self.penImageView.frame.size.width;
    CGFloat deltaY=0.5*self.penImageView.frame.size.height;
    self.penImageView.center=CGPointMake(currentPoint.x+deltaX, currentPoint.y-deltaY);
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);

    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
       // CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        
        CGColorRef color = [self.drawColor CGColor];
        CGContextSetStrokeColor(UIGraphicsGetCurrentContext(), CGColorGetComponents(color));
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
    
}

- (IBAction)clearAction:(id)sender {
    //clear all drawing, and reset the background image.
  [self.mainImage setImage:self.image];
}

- (IBAction)backAction:(id)sender {
    
    // alert to confirm leaving current page
        UIAlertView *backAlert = [[UIAlertView alloc] initWithTitle:@"Do you want to leave this page?"
                                                          message:@"Your drawing will be lost after leaving this page."
                                                         delegate:self
                                                cancelButtonTitle:@"No"
                                                otherButtonTitles:@"Yes", nil];
    
        [backAlert show];
    
}

- (IBAction)saveAction:(id)sender {
    // save to album as a figure
    UIImageWriteToSavedPhotosAlbum(self.mainImage.image, nil, nil, nil);
    
    // activity hub in the middle
    ActivityHub *hub=[[ActivityHub alloc ]initWithFrame:CGRectMake(0, 0,170, 170)];
    hub.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [hub setLabelText:@"Saved to album"];
    [hub setImage:[UIImage imageNamed:@"Checkmark-64.png"]];
    [self.view addSubview:hub];
    
    //delay 1.5 seconds for display activity hub
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [hub removeFromSuperview];
    });
    
}

  // erase action, setting pen color as background color
- (IBAction)eraseAction:(id)sender {
    self.drawColor=PBWhite;
    [self.drawColor getRed:&red green:&green blue:&blue alpha:&opacity];
    [self.penImageView setImage:self.ereasrImage];
    
}

- (IBAction)slideBarChanged:(id)sender {
    //sliderBar value ranges from 0.02 to 1
    brush=50.0f*(self.sliderBar.value);
    
}


  // selecting six predefined color, six button are tagged in the storyboard from 0 to 5.
- (IBAction)colorSelected:(id)sender {
   
    UIButton * PressedButton = (UIButton*)sender;
    
    switch(PressedButton.tag)
    {
        case 0:
            self.drawColor=PBRed;
            break;
        case 1:
            self.drawColor=PBGreen;
            break;
        case 2:
            self.drawColor=PBDeepGren;
            break;
        case 3:
            self.drawColor=PBPurple;
            break;
        case 4:
            self.drawColor=PBBlue;
            break;
        case 5:
            self.drawColor=PBYellow;
            break;
                    }
    
    [self.drawColor getRed:&red green:&green blue:&blue alpha:&opacity];
    [self.penImageView setImage:self.penImage];
    
}


- (void)colorPickerViewController:(FCColorPickerViewController *)colorPicker
                   didSelectColor:(UIColor *)color
{
     self.color = color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setColor:(UIColor *)color
{
    self.drawColor=color;
    self.customizeColor=color;
    [self.customizeButton setBackgroundColor:self.drawColor];
    [self.drawColor getRed:&red green:&green blue:&blue alpha:&opacity];

}

- (IBAction)customizeColor:(id)sender {
    [self.penImageView setImage:self.penImage];
    FCColorPickerViewController *colorPicker = [FCColorPickerViewController colorPickerWithColor:self.customizeColor
                                                                                        delegate:self];
    colorPicker.tintColor = [UIColor whiteColor];
    [colorPicker setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:colorPicker
                       animated:YES
                     completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Yes"]){
        
        [self performSegueWithIdentifier: @"backSegue" sender: self];
    }

}



@end
