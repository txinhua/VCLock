//
//  PasswordDotView.h
//  PassWordLockDemo
//
//  Created by VcaiTech on 16/9/26.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PasswordDotView : UIView

@property(nonatomic,assign)NSInteger inputDotCount;

@property(nonatomic,assign)NSInteger totalDotCount;

@property(nonatomic,retain)UIColor *strokeColor ;

@property(nonatomic,retain)UIColor * fillColor ;

@property(nonatomic,assign)BOOL isFull ;

-(void)shakeAnimationWithCompletion:(void (^)(void))completion;

-(void)shakeRightAnimationWithCompletion:(void (^)(void))completion;

@end
