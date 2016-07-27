//
//  FarmDetailViewController.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "FarmDetailViewController.h"
#import "PublicDefine.h"
#import "AlertFarmViewController.h"
#import "stdPubFunc.h"
@interface FarmDetailViewController ()

@end

@implementation FarmDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setFarm_id:(NSString *)farm_id{
    _farm_id=farm_id;
}
-(void)setFarm_name:(NSString *)farm_name{
    _farm_name=farm_name;
}
//-(void)loadTopNav{
//    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
//    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
//    
//    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 18, fDeviceWidth, 40)];
//    [topLbl setTextAlignment:NSTextAlignmentCenter];
//    topLbl.text=@"通讯录";
//    [topLbl setTextColor:[UIColor whiteColor]];
//    
//    [TopView addSubview:topLbl];
//    [self.view addSubview:TopView];
//}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 18, fDeviceWidth, 40)];
    topLbl.text=_farm_name;
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
    
    
    UIImageView *alterimg=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-35, 28, 18, 18)];
    alterimg.image=[UIImage imageNamed:@"alter"];
    [TopView addSubview:alterimg];
    
    UILabel *alterLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-35, 24+19, 20, 20)];
    alterLbl.text=@"维护";
    [alterLbl setFont:[UIFont systemFontOfSize:10]];
    [alterLbl setTextColor:[UIColor whiteColor]];
    [TopView addSubview:alterLbl];
    //维护
    UIButton *alterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [alterBtn setFrame:CGRectMake(fDeviceWidth-70, 22, 70, 42)];
    [alterBtn addTarget:self action:@selector(clickalterbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:alterBtn];
    
    [self.view addSubview:TopView];
}

-(void)clickalterbtn{
    AlertFarmViewController *AlterFarmVc=[[AlertFarmViewController alloc]init];
    [AlterFarmVc setFarmId:_farm_id];
    [self.navigationController pushViewController:AlterFarmVc animated:NO];
}


-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:NO];
}


@end
