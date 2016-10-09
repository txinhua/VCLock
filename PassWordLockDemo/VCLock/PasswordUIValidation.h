//
//  PasswordUIValidation.h
//  PassWordLockDemo
//
//  Created by VcaiTech on 16/9/28.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PasswordContainerView.h"

typedef void (^Failure)();
typedef void (^Success)();
typedef BOOL (^Validation)(NSString *str);

extern NSString *const LocalPass;

@interface PasswordUIValidation : NSObject<PasswordInputCompleteProtocol>
{
    int  errorTimesLeave;
    NSString  *localTempPass;
}


@property(nonatomic,copy)Failure failure;
@property(nonatomic,copy)Success success;
@property(nonatomic,copy)Validation validation;
@property(nonatomic,retain)PasswordContainerView *view;
@property(nonatomic,assign)BOOL isSetLockPass;
@property(nonatomic,assign)BOOL isAlertLockPass;
@property(nonatomic,assign)BOOL isForgetLockPass;
@property(nonatomic,assign)NSInteger lockPassSetTimes;

-(instancetype)initIn:(UIStackView *)stackView width:(CGFloat)width digit:(NSInteger)digit;

@end
