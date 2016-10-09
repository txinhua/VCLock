//
//  NSLayoutConstraint+passwordInput.h
//  PassWordLockDemo
//
//  Created by VcaiTech on 16/9/29.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (passwordInput)
+(void)addConstraintsfromView:(UIView *)view toView:(UIView *) baseView constraintInsets:(UIEdgeInsets)insets;

+(void)addEqualConstraintsFromSubView:(UIView *)subView toSuperView:(UIView *) superView;

+(void)addConstraintsfromSubview:(UIView *) subview toSuperView:(UIView *) superView constraintInsets:(UIEdgeInsets)insets;
@end
