//
//  EditTxtViewController.m
//  nongcloud
//
//  Created by tianan-apple on 16/8/1.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "EditTxtViewController.h"
#import "PublicDefine.h"

@interface EditTxtViewController ()<UITextFieldDelegate>

@end

@implementation EditTxtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self loadTopNav];

}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_txtField resignFirstResponder];
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

-(void)setViewTitle:(NSString *)viewTitle{
    _viewTitle=viewTitle;
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 18, fDeviceWidth, 40)];
    topLbl.text=_viewTitle;
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
    
    UIImageView *alterimg=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-34, 28, 18, 18)];
    alterimg.image=[UIImage imageNamed:@"save"];
    [TopView addSubview:alterimg];
    
    UILabel *alterLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-35, 24+19, 20, 20)];
    alterLbl.text=@"保存";
    [alterLbl setFont:[UIFont systemFontOfSize:10]];
    [alterLbl setTextColor:[UIColor whiteColor]];
    [TopView addSubview:alterLbl];
    //维护
    UIButton *alterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [alterBtn setFrame:CGRectMake(fDeviceWidth-70, 22, 70, 42)];
    [alterBtn addTarget:self action:@selector(clicksavebtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:alterBtn];
    
    [self.view addSubview:TopView];
    _txtField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, fDeviceWidth-40, 30)];
    [self stdInitTxtF:_txtField hintxt:@""];
    [self.view addSubview:_txtField];
   
}

-(void)stdInitTxtF:(UITextField*)txtF hintxt:(NSString*)hintstr{
    txtF.backgroundColor = [UIColor clearColor];
    [txtF setTintColor:[UIColor blueColor]];
    [txtF setFont:[UIFont systemFontOfSize:13]];
    txtF.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    txtF.textColor=txtColor;
    txtF.layer.borderColor = [UIColor grayColor].CGColor; // set color as you want.
    txtF.layer.borderWidth = 1.0f; // set borderWidth as you want.
    txtF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:hintstr attributes:@{NSForegroundColorAttributeName:txtColor}];
    txtF.delegate=self;
}

-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)clicksavebtn{
    [self.navigationController popViewControllerAnimated:NO];
    if(self.EditTxtBlock)
        self.EditTxtBlock(self,_txtField.text);
}
@end
