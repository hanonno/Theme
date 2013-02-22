//
//  OMGThemeViewController.m
//  OMGTheme
//
//  Created by H.O. ten Hoor on 2/22/13.
//  Copyright (c) 2013 H.O. ten Hoor. All rights reserved.
//

#import "OMGThemeViewController.h"
#import "OMGTheme.h"

@implementation OMGThemeViewController

#pragma mark - NSObject

- (id)init
{
    return (self = [super initWithNibName:nil bundle:nil]);
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.toolbarItems = @[self.infoLabelItem, self.shareButtonItem, self.addButtonItem, self.addButtonItem];
    
    self.navigationItem.title = @"Theme";
    self.navigationItem.rightBarButtonItem = self.addButtonItem;
    
    [self.toolbar setItems:self.toolbarItems animated:NO];
}


#pragma mark - Info Label

- (OMGBarLabelItem *)infoLabelItem
{
    return [[OMGBarLabelItem alloc] initWithTitle:@"What are you going to do?" target:self action:@selector(test:)];
//    OMGBarLabelItem *labelItem = [[OMGBarLabelItem alloc] init];
//    
//    labelItem.label.text = @"Hanana";
//    
//    return labelItem;
    
//    return [OMGBarLabelItem labelWithText:@"INFO!!"];
}


#pragma mark - Add Button

- (UIBarButtonItem *)addButtonItem
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleAddButton:)];
}


- (void)handleAddButton:(id)sender
{
    NSLog(@"Add?!");
}


#pragma mark - Share Button

- (UIBarButtonItem *)shareButtonItem
{
    return [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(handleEditButton:)];
}


- (void)handleEditButton:(id)sender
{
    NSLog(@"Share?");
}


#pragma mark - Toolbar

- (UIToolbar *)toolbar
{
    if(!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
        _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        
        [self.view addSubview:_toolbar];
    }
    
    return _toolbar;
}

@end