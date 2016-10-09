//
//  VCLockViewController.h
//  PassWordLockDemo
//
//  Created by VcaiTech on 16/9/30.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordContainerView.h"
#import "MyPasswordUIValidation.h"

extern NSString *const IsforgetPassWord;

@interface VCLockViewController : UIViewController

@property(nonatomic,weak)IBOutlet  UIStackView *passwordStackView;
@property(nonatomic,retain)MyPasswordUIValidation *passwordUIValidation;

@property(nonatomic,assign)BOOL isSetLockPass;
@property(nonatomic,assign)BOOL isAlertLockPass;
@property(nonatomic,assign)BOOL isForgetLockPass;

@end
