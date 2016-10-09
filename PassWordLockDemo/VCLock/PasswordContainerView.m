//
//  PasswordContainerView.m
//  PassWordLockDemo
//
//  Created by VcaiTech on 16/9/26.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import "PasswordContainerView.h"

#import "NSLayoutConstraint+passwordInput.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface PasswordContainerView ()<PasswordInputViewTappedProtocol>
{
    LAContext *touchIDContext;
//    NSString  *touchAuthenticationReason;// = "Touch to unlock"
    CGFloat kDefaultWidth;
    CGFloat kDefaultHeight;
    
@private
    NSMutableString  *inputString;
    
}
@end

@implementation PasswordContainerView

@dynamic isTouchAuthenticationAvailable;

+(id)createWithDigit:(NSInteger)digit{
    
    NSBundle *bundle =  [NSBundle bundleForClass:self];
    
    UINib *nib = [UINib nibWithNibName:@"PasswordContainerView" bundle:bundle];
    
    PasswordContainerView *view = (PasswordContainerView *)[nib instantiateWithOwner:self options:nil].firstObject;
    
    view.passwordDotView.totalDotCount = digit;
    
    return view;
}


+(id)createIn:(UIStackView *)stackView digit:(NSInteger)digit {
    
    PasswordContainerView * passwordContainerView = [PasswordContainerView createWithDigit:digit];
    
    [stackView addArrangedSubview:passwordContainerView];
    
    return passwordContainerView;
}

-(void)width:(CGFloat)width {
    self.widthConstraint.constant = width;
}

-(void)clearInput{
    
    inputString = [NSMutableString stringWithString:@""];
    self.passwordDotView.inputDotCount = inputString.length;
    
}

-(void)inputString:(NSString *)inputStr{
    inputString = [NSMutableString stringWithString:inputStr];
    self.passwordDotView.inputDotCount = inputString.length;
    [self checkInputComplete];

}


-(void)setTintColor:(UIColor *)tintColor{
    if (!_isVibrancyEffect) {
        
        [_deleteButton setTitleColor:tintColor forState:UIControlStateNormal|UIControlStateHighlighted] ;
        
        _passwordDotView.strokeColor = tintColor;
            
        _touchAuthenticationButton.tintColor = tintColor;
            
        [self.passwordInputViews enumerateObjectsUsingBlock:^(PasswordInputView  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.textColor = tintColor;
            obj.borderColor = tintColor;
        }];
        
    }
    
}

-(void)checkInputComplete{
    if (inputString.length == _passwordDotView.totalDotCount) {
        if (_delegate&&[_delegate respondsToSelector:@selector(passwordInputComplete: input:)]) {
            [_delegate passwordInputComplete:self input:inputString];
        }
    }
}

-(void)setHighlightedColor:(UIColor *)highlightedColor{
    _highlightedColor = highlightedColor;
    if (!_isVibrancyEffect) {
        self.passwordDotView.fillColor = highlightedColor;
        [self.passwordInputViews enumerateObjectsUsingBlock:^(PasswordInputView  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.highlightBackgroundColor = highlightedColor;
        }];
    }
}

-(BOOL)isIsTouchAuthenticationAvailable{
    
   return [touchIDContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
}

-(void)setTouchAuthenticationEnabled:(BOOL)touchAuthenticationEnabled {
    
    _touchAuthenticationEnabled = touchAuthenticationEnabled;
    BOOL enable = (self.isTouchAuthenticationAvailable && touchAuthenticationEnabled);
    _touchAuthenticationButton.alpha = enable ? 1.0 : 0.0;
    _touchAuthenticationButton.userInteractionEnabled = enable;
}

-(void)installInputViews{
    
//    NSArray *arrangedSubViews = [self.iputsStack arrangedSubviews];
//    NSMutableArray *inputRecords = [NSMutableArray arrayWithCapacity:10];
//    for (int i=0;i<arrangedSubViews.count;i++) {
//        UIStackView *rowStack = [arrangedSubViews objectAtIndex:i];
//        if ([rowStack isKindOfClass:[UIStackView class]]) {
//            NSArray *subInputViews = [rowStack arrangedSubviews];
//            for (int j=0;j<subInputViews.count;j++){
//                id obj =[subInputViews objectAtIndex:j];
//                if (![obj isKindOfClass:[UIButton class]]) {
//                    [inputRecords addObject:obj];
//                }
//            }
//        }
//    }
//    if (inputRecords.count>0) {
//        self.passwordInputViews =[[NSArray alloc]initWithArray:inputRecords];
//    }else{
//        self.passwordInputViews = nil;
//    }
    
}


-(void)setIsVibrancyEffect:(BOOL)isVibrancyEffect{
    
    _isVibrancyEffect  = isVibrancyEffect;
    
    [self configureVibrancyEffect];
    
}


-(void)configureVibrancyEffect{
    
    UIColor *whiteColor  = [UIColor whiteColor];
    UIColor *clearColor = [UIColor clearColor];
    //delete button title color
    UIColor *titleColor;
    //dot view stroke color
    UIColor *strokeColor;
    //dot view fill color
    UIColor *fillColor;
    //input view background color
    UIColor *circleBackgroundColor;
    UIColor *highlightBackgroundColor;
    UIColor *borderColor;
    //input view text color
    UIColor *textColor;
    UIColor *highlightTextColor;
    
    if (_isVibrancyEffect){
        //delete button
        titleColor = whiteColor;
        //dot view
        strokeColor = whiteColor;
        fillColor = whiteColor;
        //input view
        circleBackgroundColor = clearColor;
        highlightBackgroundColor = whiteColor;
        borderColor = clearColor;
        textColor = [UIColor colorWithRed:79/255.0 green:79/255.0 blue:79/255.0 alpha:1.0];
        highlightTextColor = whiteColor;
    } else {
        //delete button
        titleColor = self.tintColor;
        //dot view
        strokeColor = self.tintColor;
        
        fillColor = _highlightedColor;
        //input view
        circleBackgroundColor = whiteColor;
        highlightBackgroundColor = _highlightedColor;
        borderColor = self.tintColor;
        textColor = self.tintColor;
        highlightTextColor = _highlightedColor;
    }
    
    [_deleteButton setTitleColor:titleColor forState:UIControlStateNormal];
    _passwordDotView.strokeColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1.0];
    _passwordDotView.fillColor = [UIColor blackColor];
    _touchAuthenticationButton.tintColor = strokeColor;
    [self.passwordInputViews enumerateObjectsUsingBlock:^(PasswordInputView  *passwordInputView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        passwordInputView.isVibrancyEffect = _isVibrancyEffect;
    }];
    
}

//MARK: IBAction
-(IBAction)deleteInputString:(id)sender{
    
    if(inputString.length > 0){
        [inputString deleteCharactersInRange:NSMakeRange(inputString.length-1, 1)];
    }
    NSLog(@"%@",inputString);
    self.passwordDotView.inputDotCount = inputString.length;
    
    
}


-(void)awakeFromNib{
    [super awakeFromNib];
    [self clearInput];
    [self configureConstraints];
    self.backgroundColor = [UIColor clearColor];
    
    for (PasswordInputView *pa in self.passwordInputViews) {
        [pa setDelegate:self];
    }
    
    [_deleteButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    
    [_deleteButton.titleLabel setMinimumScaleFactor:0.5];
    
    _touchAuthenticationEnabled = NO;
    
    UIImage *image = [_touchAuthenticationButton.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [_touchAuthenticationButton setImage:image forState:UIControlStateNormal];
    
    _touchAuthenticationButton.tintColor = self.tintColor;
    
}

-(void)wrongPassword{
    
    [self.passwordDotView shakeAnimationWithCompletion:^{
        [self clearInput];
    }];
    
}

-(void)nextPasswordInput{
    
     [self.passwordDotView shakeRightAnimationWithCompletion:^{
         [self clearInput];
     }];
}

-(void)configureConstraints {
    
    if (kDefaultWidth==0) {
        kDefaultWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    }
    
    NSLayoutConstraint *ratioConstraint = [self.widthAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.78];
    
    self.widthConstraint = [self.widthAnchor constraintEqualToConstant:kDefaultWidth];
    
    self.widthConstraint.priority = 999;
    [NSLayoutConstraint activateConstraints:@[ratioConstraint,self.widthConstraint]];
    
}

//MARK: VisualEffect
-(void)rearrangeForVisualEffectView:(UIViewController *) vc{
    self.isVibrancyEffect = YES;
    for (PasswordInputView  *passwordInputView in self.passwordInputViews) {
        UILabel *label = passwordInputView.label;
        [label removeFromSuperview];
        [vc.view addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint addConstraintsfromView:label toView:passwordInputView constraintInsets:UIEdgeInsetsZero];
        
        UILabel *charLabel = passwordInputView.charestLabel;
        [charLabel removeFromSuperview];
        [vc.view addSubview:charLabel];
        charLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint addConstraintsfromView:charLabel toView:passwordInputView constraintInsets:UIEdgeInsetsMake(label.font.pointSize+18+label.frame.origin.y, 2, 5, 2)];
    }
}


-(IBAction)touchAuthenticationAction:(UIButton *)sender{
    
//    if (self.isTouchAuthenticationAvailable) {
//        [touchIDContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:touchAuthenticationReason reply:^(BOOL success, NSError * _Nullable error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (success) {
//                    self.passwordDotView.inputDotCount = self.passwordDotView.totalDotCount;
//                    touchIDContext =  [[LAContext alloc]init];
//                }
//                if (_delegate&&[_delegate respondsToSelector:@selector(touchAuthenticationComplete: success:error:)]) {
//                    [_delegate touchAuthenticationComplete:self success:success error:error];
//                }
//            });
//        }];
//    }
    
    
}


-(void)passwordInputView:(PasswordInputView *) passwordInputView tappedString:(NSString *)tappedString{

    if (inputString.length < _passwordDotView.totalDotCount) {
        [inputString appendString:tappedString];
    }
    
    self.passwordDotView.inputDotCount = inputString.length;
    
    [self checkInputComplete];
}



@end
