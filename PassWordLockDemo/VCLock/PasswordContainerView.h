//
//  PasswordContainerView.h
//  PassWordLockDemo
//
//  Created by VcaiTech on 16/9/26.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordDotView.h"
#import "PasswordInputView.h"

@class PasswordContainerView;

@protocol PasswordInputCompleteProtocol <NSObject>

-(void)passwordInputComplete:(PasswordContainerView*)passwordContainerView input:(NSString *)input;

-(void)touchAuthenticationComplete:(PasswordContainerView *) passwordContainerView success:(BOOL)success error:(NSError *)error;

@end


@interface PasswordContainerView : UIView

//MARK: IBOutlet
@property(nonatomic,strong)IBOutletCollection(PasswordInputView) NSArray *passwordInputViews;

@property(nonatomic,weak)IBOutlet UILabel *tipContent;

@property(nonatomic,weak)IBOutlet UILabel *errorTipContent;
@property(nonatomic,weak)IBOutlet PasswordDotView *passwordDotView;
@property(nonatomic,weak)IBOutlet UIButton *deleteButton;
@property(nonatomic,weak)IBOutlet UIButton * touchAuthenticationButton;

//MARK: Property
@property(nonatomic,weak)id<PasswordInputCompleteProtocol> delegate;

@property(nonatomic,assign)BOOL isVibrancyEffect;

@property(nonatomic,copy)UIColor *highlightedColor;

@property(nonatomic,assign)BOOL isTouchAuthenticationAvailable;

@property(nonatomic,assign)BOOL touchAuthenticationEnabled;

@property(nonatomic,retain)NSLayoutConstraint *widthConstraint;

+(id)createIn:(UIStackView *)stackView digit:(NSInteger)digit;
-(void)width:(CGFloat)width;
-(void)clearInput;
-(void)wrongPassword;
-(void)nextPasswordInput;
-(void)rearrangeForVisualEffectView:(UIViewController *) vc;

@end
