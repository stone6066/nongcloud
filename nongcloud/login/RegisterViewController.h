//
//  RegisterViewController.h
//  nongcloud
//
//  Created by tianan-apple on 16/7/29.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *userLogin;
@property(nonatomic,strong)UITextField *userPhone;
@property(nonatomic,strong)UITextField *userPassword;
@property(nonatomic,strong)UITextField *userPassword1;
@property(nonatomic,strong)UITextField *nationId;
@property(nonatomic,strong)UITextField *portrait;
@end
