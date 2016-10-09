//
//  PasswordInputView.h
//  PassWordLockDemo
//
//  Created by VcaiTech on 16/9/28.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PasswordInputView;

@protocol PasswordInputViewTappedProtocol <NSObject>
-(void)passwordInputView:(PasswordInputView *) passwordInputView tappedString:(NSString *)tappedString;
@end

IB_DESIGNABLE

@interface PasswordInputView : UIView
{
    CGFloat fontSizeRatio;
    
    CGFloat borderWidthRatio;
    
    BOOL touchUpFlag;
    
    BOOL isAnimating;
@private
    UIButton *button;
    
    
}

@property(nonatomic,weak)id<PasswordInputViewTappedProtocol>delegate;

@property(nonatomic,strong)UILabel  *label;

@property(nonatomic,strong)UILabel  *charestLabel;

@property(nonatomic,strong)IBInspectable NSString *numberString;
@property(nonatomic,strong)IBInspectable UIColor  *borderColor;
@property(nonatomic,strong)IBInspectable NSString *charestString;
@property(nonatomic,strong)IBInspectable UIColor  *circleBackgroundColor;
@property(nonatomic,strong)IBInspectable UIColor  *textColor;
@property(nonatomic,strong)IBInspectable UIColor  *subtextColor;
@property(nonatomic,strong)IBInspectable UIColor  *highlightTextColor;
@property(nonatomic,strong)UIColor  *highlightBackgroundColor;
@property(nonatomic,strong)UIView   *circleView;
@property(nonatomic,assign)BOOL isVibrancyEffect;

@end


