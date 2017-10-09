//
//  loginViewModel.m
//  MVVM+RAC登录页面
//
//  Created by Tix Xie on 2017/9/30.
//  Copyright © 2017年 TixXie. All rights reserved.
//

#import "loginViewModel.h"
#import <SVProgressHUD.h>

@implementation loginViewModel

/**
 懒加载模型

 @return 返回模型
 */
- (AccountItem *)account
{
    if (_account == nil) {
        _account = [[AccountItem alloc] init];
    }
    return _account;
}

/**
 初始化

 @return 返回本身实例
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialBind];
    }
    return self;
}


/**
 初始化绑定
 */
- (void)initialBind
{
    // 监听账号的属性值改变
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, account),RACObserve(self.account, password)] reduce:^id _Nullable(NSString *account, NSString *password){
        
        return @(account.length && password.length);
    }];
    
    // 处理登录业务逻辑
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // block:执行命令就会调用
        // block作用:事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
           // 模仿网络延迟1秒
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext:@"请求登录的数据"];
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
    
    // 处理登录请求返回的结果
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([x isEqualToString:@"请求登录的数据"]) {
            NSLog(@"登录成功");
        }
    }];
    
    // 监听登录状态
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"监听登录状态x: %@",x);
        if ([x isEqualToNumber:@(YES)]) {// 正在登录
            
            [SVProgressHUD show];
            
        } else { // 登录成功
            
            [SVProgressHUD dismiss];
        }
    }];
}


@end
