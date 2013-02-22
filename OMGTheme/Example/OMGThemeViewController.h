//
//  OMGThemeViewController.h
//  OMGTheme
//
//  Created by H.O. ten Hoor on 2/22/13.
//  Copyright (c) 2013 H.O. ten Hoor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMGBarLabelItem.h"

@interface OMGThemeViewController : UIViewController

@property (nonatomic, strong) OMGBarLabelItem *infoLabelItem;
@property (nonatomic, strong) UIBarButtonItem *shareButtonItem;
@property (nonatomic, strong) UIBarButtonItem *addButtonItem;

@property (nonatomic, strong) UIToolbar *toolbar;

@end