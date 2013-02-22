//
//  OMGBarLabelItem.m
//  OMGTheme
//
//  Created by H.O. ten Hoor on 2/22/13.
//  Copyright (c) 2013 H.O. ten Hoor. All rights reserved.
//

#import "OMGBarLabelItem.h"
#import "OMGTheme.h"

@implementation OMGBarLabelItem

- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    
    self = [super initWithCustomView:_label];

    [_label addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:NULL];
    
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.shadowColor = [UIColor blackColor];
    _label.shadowOffset = CGSizeMake(0, 1);
    _label.font = [UIFont boldSystemFontOfSize:13];
    
    _label.text = title;    
    
    return self;
}

- (id)initWithLabel:(UILabel *)label
{
    self = [super initWithCustomView:label];
    
    _label = label;
    
    [_label addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:NULL];
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"HHAHAH");
    
    [self.label sizeToFit];
}


@end