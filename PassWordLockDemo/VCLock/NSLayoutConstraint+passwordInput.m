//
//  NSLayoutConstraint+passwordInput.m
//  PassWordLockDemo
//
//  Created by VcaiTech on 16/9/29.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import "NSLayoutConstraint+passwordInput.h"

@implementation NSLayoutConstraint (passwordInput)
+(void)addConstraintsfromView:(UIView *)view toView:(UIView *) baseView constraintInsets:(UIEdgeInsets)insets{
    
    [baseView.topAnchor constraintEqualToAnchor:view.topAnchor constant:-insets.top];
    
    NSLayoutConstraint * const topConstraint = [baseView.topAnchor constraintEqualToAnchor:view.topAnchor constant:-insets.top];
    
    NSLayoutConstraint * const bottomConstraint = [baseView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:insets.bottom];
    
    NSLayoutConstraint * const leftConstraint = [baseView.leftAnchor constraintEqualToAnchor:view.leftAnchor constant:-insets.left];
    
    NSLayoutConstraint * const rightConstraint = [baseView.rightAnchor  constraintEqualToAnchor:view.rightAnchor constant:insets.right];
    
    [NSLayoutConstraint activateConstraints:@[topConstraint,bottomConstraint,leftConstraint,rightConstraint]];
}

+(void)addEqualConstraintsFromSubView:(UIView *)subView toSuperView:(UIView *) superView {
    
    [superView addSubview:subView];
    
    subView.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint addConstraintsfromView:subView toView:superView constraintInsets:UIEdgeInsetsZero];
    
}

+(void)addConstraintsfromSubview:(UIView *) subView toSuperView:(UIView *) superView constraintInsets:(UIEdgeInsets)insets{
    
    [superView addSubview:subView];
    
    subView.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint addConstraintsfromView:subView toView:superView constraintInsets:insets];
    
}
@end
