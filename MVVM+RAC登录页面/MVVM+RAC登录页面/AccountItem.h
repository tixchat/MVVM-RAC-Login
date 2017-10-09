//
//  AccountItem.h
//  MVVM+RAC登录页面
//
//  Created by Tix Xie on 2017/9/30.
//  Copyright © 2017年 TixXie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountItem : NSObject
/** 账号 */
@property(nonatomic, copy) NSString *account;
/** 密码 */
@property(nonatomic, copy) NSString *password;

@end
