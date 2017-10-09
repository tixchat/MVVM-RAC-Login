//
//  loginViewModel.h
//  MVVM+RAC登录页面
//
//  Created by Tix Xie on 2017/9/30.
//  Copyright © 2017年 TixXie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountItem.h"
#import <ReactiveObjC.h>

@interface loginViewModel : NSObject

/** 用户模型 */
@property(nonatomic, strong) AccountItem *account;
/** 是否允许登录 */
@property(nonatomic, strong) RACSignal *enableLoginSignal;
/** 登录命令 */
@property(nonatomic, strong) RACCommand *loginCommand;


@end
