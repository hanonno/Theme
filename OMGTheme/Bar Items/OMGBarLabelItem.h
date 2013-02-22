//
//  OMGBarLabelItem.h
//  OMGTheme
//
//  Created by H.O. ten Hoor on 2/22/13.
//  Copyright (c) 2013 H.O. ten Hoor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMGBarLabelItem : UIBarButtonItem

@property (nonatomic, retain) UILabel *label;

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (id)initWithLabel:(UILabel *)label;

@end