//
//  ViewController.m
//  PassWordLockDemo
//
//  Created by VcaiTech on 16/9/25.
//  Copyright © 2016年 Tang guifu. All rights reserved.
//

#import "ViewController.h"
#import "VCLock.h"

@interface ViewController ()
{
   
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(IBAction)doAlertAction:(id)sender{
    NSString *passWord = [[NSUserDefaults standardUserDefaults]objectForKey:LocalPass];
    if (passWord) {
        UIStoryboard *storyBoard =[UIStoryboard storyboardWithName:@"VCLock" bundle:[NSBundle mainBundle]];
        
        VCLockViewController *vcLockView = [storyBoard instantiateViewControllerWithIdentifier:@"VCLockView"];
        
        if (vcLockView) {
            vcLockView.isAlertLockPass = YES;
            UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vcLockView];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }

}


-(IBAction)doSetPass:(id)sender{
    
    UIStoryboard *storyBoard =[UIStoryboard storyboardWithName:@"VCLock" bundle:[NSBundle mainBundle]];
    
    VCLockViewController *vcLockView = [storyBoard instantiateViewControllerWithIdentifier:@"VCLockView"];
    
    if (vcLockView) {
        vcLockView.isSetLockPass = YES;
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vcLockView];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}

-(IBAction)doValidationPass:(id)sender{
    
    NSString *passWord = [[NSUserDefaults standardUserDefaults]objectForKey:LocalPass];
    if (passWord) {
        UIStoryboard *storyBoard =[UIStoryboard storyboardWithName:@"VCLock" bundle:[NSBundle mainBundle]];
        
        VCLockViewController *vcLockView = [storyBoard instantiateViewControllerWithIdentifier:@"VCLockView"];
        
        if (vcLockView) {
            UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vcLockView];
            [self presentViewController:nav animated:YES completion:nil];
        }
        
    }else{
        NSLog(@"密码还未设置");
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
