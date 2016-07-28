//
//  PersonInfoViewController.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "PublicDefine.h"
#import "ListTableViewCell.h"

@interface PersonInfoViewController ()

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableData=[[NSMutableArray alloc]init];
    [self loadTopNav];
    [self loadTableView];
    [self getPerinfoFromSvr:_userId];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUserId:(NSString *)userId{
    _userId=userId;
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 18, fDeviceWidth, 40)];
    topLbl.text=@"个人资料";
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
static NSString * const MarketCellId = @"PersonTableCell";
-(void)loadTableView{
  
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 240)];
    self.TableView.tag=0;
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:MarketCellId];
 
    [self.view addSubview: self.TableView];
}

#pragma mark table delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MarketCellId forIndexPath:indexPath];
    //
    //    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    cell.textLabel.text=_tableData[indexPath.item];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(void)getPerinfoFromSvr:(NSString*)usrid{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"Former/login/userInfo?userId=",usrid];
    NSLog(@"getPerinfoSrvFuc:%@",urlstr);
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
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
                                              NSArray *usrArr=[jsonDic objectForKey:@"data"];
                                              for (NSDictionary *dicttmp in usrArr) {
                                                 
                                                  [_tableData addObject: [NSString stringWithFormat:@"昵称：%@",[dicttmp objectForKey:@"userName"]]];
                                                  
                                                   [_tableData addObject: [NSString stringWithFormat:@"电话：%@",[dicttmp objectForKey:@"userPhone"]]];
                                                  
                                                   [_tableData addObject: [NSString stringWithFormat:@"最近登录经度：%@",[dicttmp objectForKey:@"lastLongitude"]]];
                                                  
                                                   [_tableData addObject: [NSString stringWithFormat:@"最近登录纬度：%@",[dicttmp objectForKey:@"lastLatitude"]]];
                                                  
                                                  
                                              }
                                              
                                              [_TableView reloadData];
                                              
                                              [SVProgressHUD dismiss];
                                             
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
@end
