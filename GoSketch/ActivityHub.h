//
//  ActivityHub.h
//  HHeal
//
//  Created by Changkun Zhao on 10/6/14.
//  Copyright (c) 2014 Changkun Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityHub : UIView

@property (nonatomic, retain) UIActivityIndicatorView *activityView;
@property (nonatomic, retain) UILabel* label;
@property (nonatomic, retain) UIImageView* figure;

-(void) setImage: (UIImage*)image;

-(void) setLabelText:(NSString*) text;

-(void) showActivityView;

-(void) dismissActivityView;

@end
