//
//  AlertPswViewController.m
//  PropertyManage
//
//  Created by tianan-apple on 16/7/1.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "AlertPswViewController.h"
#import "PublicDefine.h"
#import "stdPubFunc.h"
@interface AlertPswViewController ()<UITextFieldDelegate>

@end

@implementation AlertPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=MyGrayColor;
    [self loadTopNav];
    [self loadAlertView];
    [self textfieldRecognizer];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    float lblWidth=4*20;
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake((fDeviceWidth-lblWidth)/2, 18, lblWidth, 40)];
    topLbl.text=@"修改密码";
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
    [self.view addSubview:TopView];
}
-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)loadAlertView{
    CGFloat firstY=TopSeachHigh+30;
    CGFloat VCWidth=fDeviceWidth-20;
    CGFloat VCHight=40;
    
    _oldPsw=[[UITextField alloc]initWithFrame:CGRectMake(10, firstY+0*50, VCWidth, VCHight)];
    [self stdInitTxtF:_oldPsw hintxt:@" 请输入原密码"];
    [self.view addSubview:_oldPsw];
    
    _onePsw=[[UITextField alloc]initWithFrame:CGRectMake(10, firstY+1*50, VCWidth, VCHight)];
    [self stdInitTxtF:_onePsw hintxt:@" 请输入新密码"];
    [self.view addSubview:_onePsw];
    
    _towPsw=[[UITextField alloc]initWithFrame:CGRectMake(10, firstY+2*50, VCWidth, VCHight)];
    [self stdInitTxtF:_towPsw hintxt:@" 请再次输入新密码"];
    [self.view addSubview:_towPsw];
    
    [self addReportBtn];
}

-(void)stdInitTxtF:(UITextField*)txtF hintxt:(NSString*)hintstr{
    txtF.backgroundColor = [UIColor whiteColor];
    [txtF setTintColor:spritLineColor];
    [txtF setFont:[UIFont systemFontOfSize:13]];
    txtF.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    txtF.textColor=tabTxtColor;
    [txtF.layer setMasksToBounds:YES];
    [txtF.layer setCornerRadius:5.0];
    txtF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:hintstr attributes:@{NSForegroundColorAttributeName: tabTxtColor}];
    txtF.delegate=self;
}

-(void)addReportBtn{
    CGFloat yy=TopSeachHigh+30+200+10;
    UIButton *addReport=[[UIButton alloc]initWithFrame:CGRectMake(10, yy, fDeviceWidth-20, 40)];
    [addReport setTitle:@"提交"forState:UIControlStateNormal];// 添加文字
    addReport.backgroundColor=topSearchBgdColor;
    [addReport.layer setMasksToBounds:YES];
    [addReport.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //[_addReport.layer setBorderWidth:1.0]; //边框宽度
    [addReport addTarget:self action:@selector(stdAddClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addReport];
    
}
-(void)stdAddClick{
    if ([self checkAddState]) {
        [self addMendToSrv];
    }
    NSLog(@"提交报修");
}
-(BOOL)checkAddState{
    if ([_oldPsw.text isEqualToString:@" 请输入原密码"]) {
        [stdPubFunc stdShowMessage:@"请输入原密码"];
        return NO;
    }
    if (_oldPsw.text.length<1) {
        [stdPubFunc stdShowMessage:@"请输入原密码"];
        return NO;
    }
    
    if ([_onePsw.text isEqualToString:@" 请输入新密码"]) {
        [stdPubFunc stdShowMessage:@"请输入新密码"];
        return NO;
    }
    if (_onePsw.text.length<1) {
        return NO;
    }
    if ([_towPsw.text isEqualToString:@" 请再次输入新密码"]) {
        [stdPubFunc stdShowMessage:@"请再次输入新密码"];
        return NO;
    }
    if (_towPsw.text.length<1) {
        [stdPubFunc stdShowMessage:@"请再次输入新密码"];
        return NO;
    }
    
    if (![_towPsw.text isEqualToString:_onePsw.text]) {
        [stdPubFunc stdShowMessage:@"两次输入的新密码不一致，请重新输入"];
        return NO;
    }
    return YES;
}

-(void)textfieldRecognizer{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_onePsw resignFirstResponder];
    [_towPsw resignFirstResponder];
    [_oldPsw resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; //键盘按下return，这句代码可以隐藏 键盘
    return YES;
}


-(void)addMendToSrv{
    [SVProgressHUD showWithStatus:k_Status_Load];
    NSDictionary *paramDict = @{
                                @"ut":@"indexVilliageGoods",
                                };
    
    //http://192.168.0.211:8081/Former/login/pwdUpdate?userId=1&oldPwd=aaaaaa&newPwd=111111
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@%@%@%@%@",BaseUrl,@"Former/login/pwdUpdate?userId=",ApplicationDelegate.myLoginInfo.userId,@"&oldPwd=",_oldPsw.text,@"&newPwd=",_onePsw.text];
    NSLog(@"addbaoxiustr:%@",urlstr);
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
                                          [SVProgressHUD dismiss];
                                          
                                          
                                          if ([suc isEqualToString:@"success"]) {
                                              [stdPubFunc savePassWord:_onePsw.text];
                                              [stdPubFunc stdShowMessage:@"修改成功"];
                                              [self clickleftbtn];
                                              
                                          }
                                          else
                                          [stdPubFunc stdShowMessage:suc];
                                      } else {
                                          [SVProgressHUD dismiss];
                                          [stdPubFunc stdShowMessage:@"修改失败"];
                                          
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD dismiss];
                                      [stdPubFunc stdShowMessage:@"修改失败"];
                                      
                                  }];
    
}


@end
