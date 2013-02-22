//
//  TMGTheme.h
//  DFT
//
//  Created by H.O. ten Hoor on 11/26/12.
//  Copyright (c) 2012 TMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableDictionary (OMGTextAttributeAdditions)

- (void)OMG_setTextColor:(UIColor *)textColor;
- (void)OMG_setTextShadowColor:(UIColor *)textShadowColor;
- (void)OMG_setTextShadowOffset:(UIOffset)textShadowOffset;

@end

@protocol OMGThemeDelegate <NSObject>

@optional

// Text
- (NSDictionary *)textAttributes:(NSMutableDictionary *)defaultTextAttributes forNavigationBarWithMetrics:(UIBarMetrics)barMetrics;
- (NSDictionary *)textAttributes:(NSMutableDictionary *)defaultTextAttributes forButtonInState:(UIControlState)controlState;
- (NSDictionary *)textAttributes:(NSMutableDictionary *)defaultTextAttributes forBackButtonInState:(UIControlState)controlState;

// Images
- (UIImage *)backgroundImage:(UIImage *)defaultBackgroundImage forNavigationBarWithBarMetrics:(UIBarMetrics)barMetrics;
- (UIImage *)backgroundImage:(UIImage *)defaultBackgroundImage forToolbarWithBarMetrics:(UIBarMetrics)barMetrics;
- (UIImage *)backgroundImage:(UIImage *)defaultBackgroundImage forButtonInState:(UIControlState)controlState withBarMetrics:(UIBarMetrics)barMetrics;
- (UIImage *)backgroundImage:(UIImage *)defaultBackgroundImage forBackButtonInState:(UIControlState)controlState withBarMetrics:(UIBarMetrics)barMetrics;

@end


@interface OMGTheme : NSObject

+ (OMGTheme *)defaultTheme;

// Convenience
+ (NSDictionary *)textAttributesWithTextColor:(UIColor *)textColor shadowColor:(UIColor *)shadowColor shadowOffset:(UIOffset)shadowOffset;

// Defaults
+ (UIColor *)defaultTextColor;
+ (UIColor *)defaultTextShadowColor;
+ (UIOffset)defaultTextShadowOffset;
+ (NSDictionary *)defaultTextAttributes;

+ (CGFloat)defaultButtonInset;
+ (UIEdgeInsets)defaultButtonEdgeInsets;
+ (UIEdgeInsets)defaultBackButtonEdgeInsets;

+ (UIImage *)defaultNavigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics;
+ (UIImage *)defaultToolbarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics;
+ (UIImage *)defaultButtonBackgroundImageForState:(UIControlState)controlState;
+ (UIImage *)defaultBackButtonBackgroundImageForState:(UIControlState)controlState;

// Enumerators
+ (void)enumerateBarMetricsWithBlock:(void (^)(UIBarMetrics barMetrics))block;
+ (void)enumerateControlStatesWithBlock:(void (^)(UIControlState controlState))block;
+ (void)enumerateControlStatesAndBarMetricsWithBlock:(void (^)(UIControlState controlState, UIBarMetrics barMetrics))block;

// Delegate
@property (nonatomic, retain) NSObject <OMGThemeDelegate> *delegate;

// Applying Styles
- (void)applyNavigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics;
- (void)applyButtonTextAttributesForState:(UIControlState)controlState;
- (void)applyButtonBackgroundImageForState:(UIControlState)controlState withBarMetrics:(UIBarMetrics)barMetrics;
- (void)applyBackButtonBackgroundImageForState:(UIControlState)controlState withBarMetrics:(UIBarMetrics)barMetrics;

// Applies everything
- (void)apply;

@end