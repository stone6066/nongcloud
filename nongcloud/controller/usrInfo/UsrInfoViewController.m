//
//  UsrInfoViewController.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "UsrInfoViewController.h"
#import "PublicDefine.h"
#import "ListTableViewCell.h"
#import "listCellModel.h"
#import "UIImageView+WebCache.h"
#import "PersonInfoViewController.h"
#import "AlertPswViewController.h"

@interface UsrInfoViewController ()

@end

@implementation UsrInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNav];
    [self loadTopVc];
    listCellModel *LM1=[[listCellModel alloc]init];
    LM1.cellName=@"个人资料";
    LM1.cellImg=@"person";
    
    listCellModel *LM2=[[listCellModel alloc]init];
    LM2.cellName=@"密码服务";
    LM2.cellImg=@"psw";

    
    listCellModel *LM3=[[listCellModel alloc]init];
    LM3.cellName=@"设置";
    LM3.cellImg=@"setting";

    
    _tableData=[[NSArray alloc]initWithObjects:LM1,LM2,LM3, nil];
    [self loadTableView];
    [_TableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 18, fDeviceWidth, 40)];
    topLbl.text=@"我的账户";
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


static NSString * const MarketCellId = @"UsrTableCell";
-(void)loadTableView{
    CGFloat devH= fDeviceHeight*0.618;
    
    UIView *bottomVc=[[UIView alloc]initWithFrame:CGRectMake(0, fDeviceHeight*(1-0.618), fDeviceWidth, devH)];
  
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, fDeviceWidth, 130)];
    self.TableView.tag=0;
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:MarketCellId];
    
    [bottomVc addSubview:self.TableView];
    
    
    UIImageView *logobtnImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 190, fDeviceWidth-20, 50)];
    logobtnImg.image=[UIImage imageNamed:@"logout"];
    [bottomVc addSubview:logobtnImg];
    
    UIButton *LoginOutBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 186, fDeviceWidth-20, 50)];
    
    [LoginOutBtn addTarget:self action:@selector(clicklogoutbtn) forControlEvents:UIControlEventTouchUpInside];
    
    [LoginOutBtn setTitle:@"退出登录"forState:UIControlStateNormal];// 添加文字
    [bottomVc addSubview:LoginOutBtn];
    [self.view addSubview: bottomVc];
}
-(void)clicklogoutbtn{
    ApplicationDelegate.isLogin=NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}
-(void)loadTopVc{
    CGFloat devH= fDeviceHeight*(1-0.618)-TopSeachHigh;
    UIView *topVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, devH)];
    topVc.backgroundColor=topSearchBgdColor;
    
    
    UIImageView *iconImg=[[UIImageView alloc]initWithFrame:CGRectMake((fDeviceWidth-(devH-20))/2, 10, devH-20, devH-20)];
    
    
    [iconImg sd_setImageWithURL:[NSURL URLWithString:@"http://img1.cache.netease.com/catchpic/F/FA/FAE5092DBC8408FD891B53D4A92AE5DA.jpg"]];
    
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.cornerRadius = CGRectGetHeight(iconImg.bounds)/2;
    //    注意这里的ImageView 的宽和高都要相等
    //    layer.cornerRadiu 设置的是圆角的半径
    //    属性border 添加一个镶边
    iconImg.layer.borderWidth = 0.5f;
    iconImg.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [topVc addSubview:iconImg];

    
    [self.view addSubview:topVc];
}
#pragma mark table delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MarketCellId forIndexPath:indexPath];
    //
    //    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    listCellModel *LM=_tableData[indexPath.item];
    [cell showUiUsrCell:LM];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.item) {
        case 0:
            [self pushPersonInfo];
            break;
        case 1:
            [self pushAlertPswView];
            break;
        default:
            break;
    }
   
}
-(void)pushPersonInfo{
    PersonInfoViewController *Pvc=[[PersonInfoViewController alloc]init];
    [Pvc setUserId:ApplicationDelegate.myLoginInfo.userId];
    Pvc.view.backgroundColor=collectionBgdColor;
    [self.navigationController pushViewController:Pvc animated:YES];
}
-(void)pushAlertPswView{
    AlertPswViewController *Pvc=[[AlertPswViewController alloc]init];
    Pvc.view.backgroundColor=collectionBgdColor;
    [self.navigationController pushViewController:Pvc animated:YES];
}

@end
