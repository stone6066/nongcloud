//
//  RegisterViewController.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/29.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "RegisterViewController.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self drawContentView];
    [self addTextTapGestureRecognizer];
}
-(void)addTextTapGestureRecognizer{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_userName resignFirstResponder];
    [_userLogin resignFirstResponder];
    [_userPhone resignFirstResponder];
    [_userPassword resignFirstResponder];
    [_userPassword1 resignFirstResponder];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; //键盘按下return，这句代码可以隐藏 键盘
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 18, fDeviceWidth, 40)];
    topLbl.text=@"注册新用户";
    [topLbl setTextAlignment:NSTextAlignmentCenter];
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    
    UIView * topStaus=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopStausHight)];
    topStaus.backgroundColor=stausBarColor;
    [TopView addSubview:topStaus];
    
    
    [self.view addSubview:TopView];
}

-(void)clickleftbtn
{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)drawContentView{
    UIView *contentVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    CGFloat offsetY=20;
    CGFloat txtH=40;
    CGFloat txtW=fDeviceWidth-20;
    CGFloat txtsp=40+2;
    NSInteger txtIndex=0;
    _userLogin=[[UITextField alloc]initWithFrame:CGRectMake(10, offsetY, txtW, txtH)];
    [self stdInitTxtF:_userLogin hintxt:@"设置登录用户名"];
    
    txtIndex+=1;
    _userPassword=[[UITextField alloc]initWithFrame:CGRectMake(10, offsetY+txtsp*txtIndex, txtW, txtH)];
    [self stdInitTxtF:_userPassword hintxt:@"设置密码"];
    
    _userPassword.secureTextEntry = YES;
    
    txtIndex+=1;
    _userPassword1=[[UITextField alloc]initWithFrame:CGRectMake(10, offsetY+txtsp*txtIndex, txtW, txtH)];
    [self stdInitTxtF:_userPassword1 hintxt:@"再次输入密码"];
    _userPassword1.secureTextEntry = YES;
    txtIndex+=1;
    _userPhone=[[UITextField alloc]initWithFrame:CGRectMake(10, offsetY+txtsp*txtIndex, txtW, txtH)];
    [self stdInitTxtF:_userPhone hintxt:@"手机号码"];
    
    
    [contentVc addSubview:_userLogin];
    [contentVc addSubview:_userPassword];
    [contentVc addSubview:_userPassword1];
    [contentVc addSubview:_userPhone];
    
    txtIndex+=2;
    UIImageView *logobtnImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, offsetY+txtsp*txtIndex, fDeviceWidth-20, 50)];
    logobtnImg.image=[UIImage imageNamed:@"logBtn"];
    [contentVc addSubview:logobtnImg];
    
    
    UIButton *regBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, offsetY+txtsp*txtIndex-3, fDeviceWidth-20, 50)];
    
    [regBtn addTarget:self action:@selector(regbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [regBtn setTitle:@"注   册"forState:UIControlStateNormal];// 添加文字
    [contentVc addSubview:regBtn];
    [self.view addSubview:contentVc];
}
-(void)stdInitTxtF:(UITextField*)txtF hintxt:(NSString*)hintstr{
    txtF.backgroundColor = MyGrayColor;
    [txtF setTintColor:[UIColor blueColor]];
    [txtF setFont:[UIFont systemFontOfSize:13]];
    txtF.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    txtF.textColor=txtColor;//[UIColor whiteColor];
    txtF.layer.borderColor = [UIColor whiteColor].CGColor; // set color as you want.
    txtF.layer.borderWidth = 1.0f; // set borderWidth as you want.
    txtF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:hintstr attributes:@{NSForegroundColorAttributeName: txtColor}];
    txtF.delegate=self;
}

-(void)regbtnClick{
    [self regUsrToSrvFuc];
}


//上报
-(void)regUsrToSrvFuc{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",BaseUrl,@"Former/login/userLogin?userLogin=",_userLogin.text,
        @"&userPassword=",_userPassword.text,
        @"&orgCode=10001",
        @"&userPhone=",_userPhone.text
                      ];
    
    
    NSLog(@"regUsrToSrvFuc:%@",urlstr);
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:nil
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"数据：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"msg"];
                                          
                                          //
                                          if ([suc isEqualToString:@"success"]) {
                                              //成功
                                              
                                              [SVProgressHUD dismiss];
                                              [stdPubFunc stdShowMessage:@"注册成功，可以在设置中继续完善资料"];
                                              //[stdPubFunc saveLoginInfo:_userLogin.text password:_userPassword.text];
                                              loginInfo *logtmp=[[loginInfo alloc]init];
                                              logtmp.usrlog=_userLogin.text;
                                              logtmp.usrpsw=_userPassword.text;
                                              [self.navigationController popViewControllerAnimated:NO];
                                              [[NSNotificationCenter defaultCenter] postNotificationName:NSUserLoginMsg
                                                 object:logtmp];
                                              
                                          } else {
                                              //失败
                                              [SVProgressHUD showErrorWithStatus:suc];
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                          
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      NSLog(@"error:%@",error);
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                  }];
    
}
-(void)loginSuccPro{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

//登录
-(void)loginNetFuc:(NSString*)usr passWord:(NSString*)psw{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@",BaseUrl,@"Former/login/user?userLogin=",usr,@"&userPwd=",psw];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"数据：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"msg"];
                                          
                                          //
                                          if ([suc isEqualToString:@"success"]) {
                                              //成功
                                              loginInfo *LGIN=[[loginInfo alloc]init];
                                              ApplicationDelegate.myLoginInfo=[LGIN asignInfoWithDict:jsonDic];
                                              [stdPubFunc saveLoginInfo:_userLogin.text password:_userPassword.text];
                                              [SVProgressHUD dismiss];
                                              [self loginSuccPro];
                                              
                                          } else {
                                              //失败
                                              [SVProgressHUD showErrorWithStatus:suc];
                                              
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                          
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                      
                                  }];
    
}
@end
