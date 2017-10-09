//
//  ViewController.m
//  MVVM+RAC登录页面
//
//  Created by Tix Xie on 2017/9/30.
//  Copyright © 2017年 TixXie. All rights reserved.
//

#import "ViewController.h"
#import "loginViewModel.h"
#import <ReactiveObjC.h>
#import "loginViewModel.h"

@interface ViewController ()
/** 登录视图模型 */
@property(nonatomic, strong) loginViewModel *loginViewModel;
/** 账号TextField */
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
/** 密码TextField */
@property (weak, nonatomic) IBOutlet UITextField *passwrodTextField;
/** 登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController
- (loginViewModel *)loginViewModel
{
    if (_loginViewModel == nil) {
        _loginViewModel = [[loginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 绑定视图模型
    [self bindViewModel];
    
    // 绑定登录按钮
    [self loginEvent];
}


/**
 绑定视图模型
 */
- (void)bindViewModel
{
    // 绑定视图模型属性
    RAC(self.loginViewModel.account,account) = _accountTextField.rac_textSignal;
    RAC(self.loginViewModel.account,password) = _passwrodTextField.rac_textSignal;
}

/**
 登录事件
 */
- (void)loginEvent
{
    // 绑定登录按钮
    RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;
    // 监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.loginViewModel.loginCommand execute:nil];
    }];
}


@end
