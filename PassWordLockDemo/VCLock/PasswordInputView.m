//
//  PasswordInputView.m
//  PassWordLockDemo
//
//  Created by VcaiTech on 16/9/28.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import "PasswordInputView.h"
#import "NSLayoutConstraint+passwordInput.h"


@implementation PasswordInputView

-(void)initVar{
    
    _circleView = [[UIView alloc]init];
    
    button =[[UIButton alloc]init];
    
    _label =[[UILabel alloc]init];
    
    _charestLabel = [[UILabel alloc]init];
    
    fontSizeRatio    = 42/40;
    
    borderWidthRatio = 1/26;
    
    _highlightBackgroundColor = [UIColor colorWithRed:226/255.0 green:227/255.0 blue:228/255.0 alpha:1.0];
    
    _highlightTextColor = [UIColor whiteColor];
    
    if (!self.textColor) {
        
        self.textColor = [UIColor colorWithRed:79/255.0 green:79/255.0 blue:79/255.0 alpha:1.0];
        
    }
    if (!self.circleBackgroundColor) {
        
        self.circleBackgroundColor = [UIColor whiteColor];
        
    }
    
    if (!self.numberString) {
        
        self.numberString = @"2";
        
    }
    
}


-(void)configureSubviews{
    
    [self addSubview:_circleView];
    //configure label
    [NSLayoutConstraint addEqualConstraintsFromSubView:_label toSuperView:self];
    _label.textAlignment = NSTextAlignmentCenter;
    
    [NSLayoutConstraint addConstraintsfromSubview:_charestLabel toSuperView:self constraintInsets:UIEdgeInsetsMake(_label.font.pointSize+18+_label.frame.origin.y,2, 5, 2)];
    _charestLabel.textAlignment = NSTextAlignmentCenter;
    //configure button
    [NSLayoutConstraint addEqualConstraintsFromSubView:button toSuperView:self];
    [button setExclusiveTouch:YES];
    [button addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel|UIControlEventTouchDragExit];

}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _label.textColor = _textColor;
}

-(void)setBorderColor:(UIColor *)borderColor{
    
    _borderColor = borderColor;
    self.backgroundColor = _borderColor;
    
}

-(void)setCircleBackgroundColor:(UIColor *)circleBackgroundColor{
    _circleBackgroundColor = circleBackgroundColor;
    _circleView.backgroundColor = _circleBackgroundColor;
}



#pragma mark - MARK: Animation

-(void)touchDownAction{
    
    _circleView.backgroundColor = _highlightBackgroundColor;
    
}

-(void)touchUpAction{
    
    _circleView.backgroundColor = _circleBackgroundColor;
}

-(void)touchDownAnimation{
    isAnimating = YES;
    
    [self tappedAnimation:^{
        
        [self touchDownAction];
        
    } completion:^(BOOL finished) {
        
        if (touchUpFlag){
            
            [self touchUpAnimation];
            
        } else {
            
            isAnimating = NO;
            
        }
        
    }];
    
}

-(void)touchUpAnimation{
    isAnimating = YES;
    [self tappedAnimation:^{
        [self touchUpAction];
    } completion:^(BOOL finished) {
        isAnimating = NO;
    }];
    
}

-(void)tappedAnimation:(void (^)(void))animations completion:(void (^)(BOOL finished))completion {
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:animations completion:completion];
}


-(void)touchDown{
    //delegate callback
    if (_delegate&&[_delegate respondsToSelector:@selector(passwordInputView:tappedString:)]) {
        
        [_delegate passwordInputView:self tappedString:_numberString];
        
    }
    
    //now touch down, so set touch up flag --> false
    touchUpFlag = NO;
    
    [self touchDownAnimation];
    
}

-(void)touchUp{
    
    //now touch up, so set touch up flag --> true
    touchUpFlag = YES;
    
    //only show touch up animation when touch down animation finished
    if (!isAnimating) {
        
        [self touchUpAnimation];
        
    }
    
}

#if TARGET_INTERFACE_BUILDER
-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    [self initVar];
    [self configureSubviews];
    
}
#else
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initVar];
    [self configureSubviews];
}
#endif





-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self updateUI];
    
}

-(void)updateUI{
    
    //prepare calculate
    CGFloat const width  = self.frame.size.width;
    CGFloat const height = self.frame.size.height;
//    CGPoint const center = CGPointMake(width/2, height/2);
//    CGFloat const radius = MIN(width, height) / 2;
    //CGFloat const borderWidth = 1;
//    CGFloat const circleRadius = radius - borderWidth;
    //update label
    
    _label.text = _numberString;
    _label.font = [UIFont systemFontOfSize:22 weight:UIFontWeightLight];
    _label.textColor = _textColor;
    
    _charestLabel.text=_charestString;
    _charestLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    _charestLabel.textColor = _subtextColor;
    NSArray *midStrs =@[@"2",@"5",@"8"];
    if ([midStrs containsObject: _numberString] ) {
        _circleView.frame =CGRectMake(1, 1,width-2,height-1);
    }else{
        _circleView.frame =CGRectMake(0, 1,width,height-1);
    }
    //update circle view
  
//    _circleView.center = center;
//    _circleView.layer.cornerRadius = circleRadius;
    _circleView.backgroundColor = _circleBackgroundColor;
    //circle view border
//    _circleView.layer.borderWidth = _isVibrancyEffect ? borderWidth : 0;
    //update mask
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, height)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
    //update color
    self.backgroundColor = _borderColor;
    
}



@end
