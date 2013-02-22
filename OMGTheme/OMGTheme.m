//
//  OMGTheme.m
//  DFT
//
//  Created by H.O. ten Hoor on 11/26/12.
//  Copyright (c) 2012 TMG. All rights reserved.
//

#import "OMGTheme.h"

@implementation NSMutableDictionary (OMGTextAttributeAdditions)

- (void)OMG_setTextColor:(UIColor *)textColor
{
    if(!textColor) { return ; }
    
    [self setObject:textColor forKey:UITextAttributeTextColor];
}

- (void)OMG_setTextShadowColor:(UIColor *)textShadowColor
{
    if(!textShadowColor) { return ; }
    
    [self setObject:textShadowColor forKey:UITextAttributeTextShadowColor];
}

- (void)OMG_setTextShadowOffset:(UIOffset)textShadowOffset
{
    [self setObject:[NSValue valueWithUIOffset:textShadowOffset] forKey:UITextAttributeTextShadowOffset];
}

@end


@interface OMGTheme ()

+ (NSString *)_imageExtensionForControlState:(UIControlState)controlState;
+ (UIImage *)_imageWithNameInFormat:(NSString *)format edgeInsets:(UIEdgeInsets)edgeInsets forState:(UIControlState)controlState;

@end

@implementation OMGTheme

+ (OMGTheme *)defaultTheme
{
    static OMGTheme *_defaultTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultTheme = [[OMGTheme alloc] init];
    });
    
    return _defaultTheme;
}

#pragma mark - Private

+ (NSString *)_imageExtensionForControlState:(UIControlState)controlState
{
    NSString *imageExtension = nil;
    
    switch (controlState) {
        case UIControlStateHighlighted:
            imageExtension = @"-highlighted";
            break;
            
        case UIControlStateDisabled:
            imageExtension = @"-disabled";
            break;
            
        case UIControlStateNormal:
            imageExtension = @"-normal";
            break;
            
        default:
            imageExtension = @"";
            break;
    }
    
    return imageExtension;
}

+ (UIImage *)_imageWithNameInFormat:(NSString *)format edgeInsets:(UIEdgeInsets)edgeInsets forState:(UIControlState)controlState
{
    return [[UIImage imageNamed:[NSString stringWithFormat:format, [OMGTheme _imageExtensionForControlState:controlState]]] resizableImageWithCapInsets:edgeInsets];
}

#pragma mark - Convenience

+ (NSDictionary *)textAttributesWithTextColor:(UIColor *)textColor shadowColor:(UIColor *)shadowColor shadowOffset:(UIOffset)shadowOffset
{
    return @{
        UITextAttributeTextColor : textColor,
        UITextAttributeTextShadowColor: shadowColor,
        UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:shadowOffset]
    };    
}

// Defaults

+ (UIColor *)defaultTextColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)defaultTextShadowColor
{
    return [UIColor blackColor];
}

+ (UIOffset)defaultTextShadowOffset
{
    return UIOffsetMake(0, 1);
}

+ (NSDictionary *)defaultTextAttributes
{
    return [OMGTheme textAttributesWithTextColor:[OMGTheme defaultTextColor] shadowColor:[OMGTheme defaultTextShadowColor] shadowOffset:[OMGTheme defaultTextShadowOffset]];
}

+ (CGFloat)defaultButtonInset
{
    return 6.0f;
}

+ (UIEdgeInsets)defaultButtonEdgeInsets
{
    CGFloat buttonInset = [OMGTheme defaultButtonInset];
    
    return UIEdgeInsetsMake(buttonInset, buttonInset * 2, buttonInset, buttonInset * 2);
}

+ (UIEdgeInsets)defaultBackButtonEdgeInsets
{
    CGFloat buttonInset = [OMGTheme defaultButtonInset];
    
    return UIEdgeInsetsMake(buttonInset, 14, buttonInset, 8);
}

+ (UIImage *)defaultNavigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics
{
    return [UIImage imageNamed:@"navigation-bar-background.png"];
}

+ (UIImage *)defaultToolbarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics
{
    UIImage *backgroundImage = [UIImage imageNamed:@"toolbar-background.png"];
    
    if(!backgroundImage) {
        backgroundImage = [OMGTheme defaultNavigationBarBackgroundImageForBarMetrics:barMetrics];
    }
    
    return backgroundImage;
}

+ (UIImage *)defaultButtonBackgroundImageForState:(UIControlState)controlState
{
    return [OMGTheme _imageWithNameInFormat:@"button-background%@.png" edgeInsets:[OMGTheme defaultButtonEdgeInsets] forState:controlState];
}

+ (UIImage *)defaultBackButtonBackgroundImageForState:(UIControlState)controlState
{
    return [OMGTheme _imageWithNameInFormat:@"back-button-background%@.png" edgeInsets:[OMGTheme defaultBackButtonEdgeInsets] forState:controlState];
}

#pragma mark - Enumerators

+ (void)enumerateBarMetricsWithBlock:(void (^)(UIBarMetrics barMetrics))block
{
    block(UIBarMetricsDefault);
    block(UIBarMetricsLandscapePhone);
}

+ (void)enumerateControlStatesWithBlock:(void (^)(UIControlState controlState))block
{
    block(UIControlStateNormal);
    block(UIControlStateHighlighted);
    block(UIControlStateDisabled);
}

+ (void)enumerateControlStatesAndBarMetricsWithBlock:(void (^)(UIControlState controlState, UIBarMetrics barMetrics))block
{
    block(UIControlStateNormal, UIBarMetricsDefault);
    block(UIControlStateHighlighted, UIBarMetricsDefault);
    block(UIControlStateDisabled, UIBarMetricsDefault);
    
    block(UIControlStateNormal, UIBarMetricsLandscapePhone);
    block(UIControlStateHighlighted, UIBarMetricsLandscapePhone);
    block(UIControlStateDisabled, UIBarMetricsLandscapePhone);
}

#pragma mark - Applying Styles

- (void)applyNavigationBarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics
{
    UIImage *backgroundImage = [OMGTheme defaultNavigationBarBackgroundImageForBarMetrics:barMetrics];
    
    if(_delegate && [_delegate respondsToSelector:@selector(backgroundImage:forNavigationBarWithBarMetrics:)])
    {
        backgroundImage = [_delegate backgroundImage:backgroundImage forNavigationBarWithBarMetrics:barMetrics];
    }
    
    [[UINavigationBar appearance] setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
}

- (void)applyToolbarBackgroundImageForBarMetrics:(UIBarMetrics)barMetrics
{
    UIImage *backgroundImage = [OMGTheme defaultToolbarBackgroundImageForBarMetrics:barMetrics];
    
    if(_delegate && [_delegate respondsToSelector:@selector(backgroundImage:forToolbarWithBarMetrics:)]) {
        backgroundImage = [_delegate backgroundImage:backgroundImage forToolbarWithBarMetrics:barMetrics];
    }

    [[UIToolbar appearance] setBackgroundImage:backgroundImage forToolbarPosition:UIToolbarPositionAny barMetrics:barMetrics];
}

- (void)applyButtonTextAttributesForState:(UIControlState)controlState
{
    NSDictionary *textAttributes = [OMGTheme defaultTextAttributes];
        
    if(_delegate && [_delegate respondsToSelector:@selector(textAttributes:forButtonInState:)])
    {
        textAttributes = [_delegate textAttributes:[textAttributes mutableCopy] forButtonInState:controlState];
    }
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:controlState];
}

- (void)applyButtonBackgroundImageForState:(UIControlState)controlState withBarMetrics:(UIBarMetrics)barMetrics
{
    UIImage *backgroundImage = [OMGTheme defaultButtonBackgroundImageForState:controlState];
    
    if(_delegate && [_delegate respondsToSelector:@selector(backgroundImage:forButtonInState:withBarMetrics:)])
    {
        backgroundImage = [_delegate backgroundImage:backgroundImage forButtonInState:controlState withBarMetrics:barMetrics];
    }
    
    [[UIBarButtonItem appearance] setBackgroundImage:backgroundImage forState:controlState barMetrics:barMetrics];
}

- (void)applyBackButtonBackgroundImageForState:(UIControlState)controlState withBarMetrics:(UIBarMetrics)barMetrics
{
    UIImage *backgroundImage = [OMGTheme defaultBackButtonBackgroundImageForState:controlState];
    
    if(_delegate && [_delegate respondsToSelector:@selector(backgroundImage:forBackButtonInState:withBarMetrics:)])
    {
        backgroundImage = [_delegate backgroundImage:backgroundImage forBackButtonInState:controlState withBarMetrics:barMetrics];
    }
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backgroundImage forState:controlState barMetrics:barMetrics];
}

- (void)apply
{
    // Navigation Bar
    NSDictionary *textAttributes = [OMGTheme defaultTextAttributes];
    
    if(_delegate && [_delegate respondsToSelector:@selector(textAttributes:forNavigationBarWithMetrics:)])
    {
        textAttributes = [_delegate textAttributes:[textAttributes mutableCopy] forNavigationBarWithMetrics:UIBarMetricsDefault];
    }
    
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    
    [self applyNavigationBarBackgroundImageForBarMetrics:UIBarMetricsDefault];
    [self applyNavigationBarBackgroundImageForBarMetrics:UIBarMetricsLandscapePhone];
    
    // Toolbar
    [OMGTheme enumerateBarMetricsWithBlock:^(UIBarMetrics barMetrics) {
        [self applyToolbarBackgroundImageForBarMetrics:barMetrics];
    }];
    
    // Buttons
    [OMGTheme enumerateControlStatesWithBlock:^(UIControlState controlState) {
        [self applyButtonTextAttributesForState:controlState];
    }];

    [OMGTheme enumerateControlStatesAndBarMetricsWithBlock:^(UIControlState controlState, UIBarMetrics barMetric) {
        [self applyButtonBackgroundImageForState:controlState withBarMetrics:barMetric];
    }];
    
    [OMGTheme enumerateControlStatesAndBarMetricsWithBlock:^(UIControlState controlState, UIBarMetrics barMetrics) {
        [self applyBackButtonBackgroundImageForState:controlState withBarMetrics:barMetrics];
    }];
}

@end