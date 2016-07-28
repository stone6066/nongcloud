//
//  MainViewController.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MainViewController.h"
#import "PublicDefine.h"
#import "LoginViewController.h"
#import "MainCollectionViewCell.h"
#import "farmModel.h"
#import "FarmDetailViewController.h"
#import "AddFarmViewController.h"
#import "UsrInfoViewController.h"

@interface MainViewController ()
{
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageindex=1;
    [self loadTopStaus];
    [self loadTopImg];
    [self loadBottomView];
    _dataSource = [[NSMutableArray alloc]init];
    //[self dataSectionArray];
    [self loadHomeCollectionView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTopStaus{
    UIView * topStaus=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopStausHight)];
    topStaus.backgroundColor=stausBarColor;
    [self.view addSubview:topStaus];
}

-(void)loadTopImg{
    UIImageView *topImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, TopStausHight, fDeviceWidth, 150)];
    topImg.image=[UIImage imageNamed:@"homeTopImg"];
    [self.view addSubview:topImg];
}
-(void)loadBottomView{
    UIImageView *topImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, fDeviceHeight-80, fDeviceWidth, 80)];
    topImg.image=[UIImage imageNamed:@"homeBottom"];
    [self.view addSubview:topImg];
    
    UIButton *account=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-40, fDeviceHeight-50, 40, 40)];
    [account setImage:[UIImage imageNamed:@"account"] forState:UIControlStateNormal];
    [account addTarget:self action:@selector(showUsrInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:account];
}
-(void)showUsrInfo{
    UsrInfoViewController *usrVc=[[UsrInfoViewController alloc]init];
    usrVc.view.backgroundColor=MyGrayColor;
    [self.navigationController pushViewController:usrVc animated:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden=YES;
    if (!ApplicationDelegate.isLogin) {
        //显示登录页面
        LoginViewController *vc = [[LoginViewController alloc]init];
        vc.loginSuccBlock = ^(LoginViewController *aqrvc){
            NSLog(@"login_suc");
            ApplicationDelegate.isLogin = YES;
            //[self loadCollectionViewData:_pageindex];
        };
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    }
    else
       [self loadCollectionViewData:_pageindex];
    
}

-(void)loadHomeCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopStausHight+150, fDeviceWidth, fDeviceHeight-TopStausHight-150-79) collectionViewLayout:flowLayout];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    //-----------------------------------------
    
    self.collectionView.backgroundColor = topSearchBgdColor;//
    
    [self.collectionView registerClass:[MainCollectionViewCell class]  forCellWithReuseIdentifier:@"CollectionCell"];

    
    // 下拉刷新
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageindex=1;
        [self loadCollectionViewData:_pageindex];
        [weakSelf.collectionView.mj_header endRefreshing];
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (_dataSource.count>0) {
            _pageindex+=1;
            [self loadCollectionViewData:_pageindex];
        }
        else
        {
            _pageindex=1;
            [self loadCollectionViewData:_pageindex];
        }
        
        // 结束刷新
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
    
    
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    farmModel * FM=_dataSource[indexPath.item];
    
    [cell showUiMainCell:FM];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    farmModel * FM=_dataSource[indexPath.item];
    if ([FM.farmId isEqualToString:@"-1"]) {
        [self pushAddFarmView];
    }
    else
        [self pushFarmView:FM.farmId farmName:FM.farmName];
}

//有多少个section；
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //有多少个一维数组；
    return 1;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((fDeviceWidth - 40) / 3, (fDeviceWidth - 40) / 3);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0,20,0,20);
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(self.collectionView.frame.size.width, 50);
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(void)pushFarmView:(NSString *)farmId farmName:(NSString *)fname{
    FarmDetailViewController *FDVC=[[FarmDetailViewController alloc]init];
    [FDVC setFarm_id:farmId];
    [FDVC setFarm_name:fname];
    [self.navigationController pushViewController:FDVC animated:NO];
}

-(void)pushAddFarmView{
    AddFarmViewController *AFDVC=[[AddFarmViewController alloc]init];
    [self.navigationController pushViewController:AFDVC animated:NO];
}
#pragma mark -- Lazy Load 懒加载
//要添加的图片从这里面选；
//这里进行的是懒加载，要先去判断，没有的话才去进行实例化;

- (void)dataSectionArray{
    
        for (int i=0; i<8; i++) {
            farmModel *FM=[[farmModel alloc]init];
            FM.farmName=[NSString stringWithFormat:@"%@%d",@"农场",i];
            FM.farmImg=@"farmImg";
            FM.farmId=[NSString stringWithFormat:@"%d",i];
            [_dataSource addObject:FM];
        }
    farmModel *FM=[[farmModel alloc]init];
    FM.farmName=[NSString stringWithFormat:@"%@",@"新建"];
    FM.farmImg=@"addFarm";
    FM.farmId=@"-1";
    [_dataSource addObject:FM];
    
    //[self.collectionView reloadData];
}


-(void)loadCollectionViewData:(NSInteger)pageNo{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"Former/farm/farmInfo?userId=",ApplicationDelegate.myLoginInfo.userId];
    NSLog(@"urlstr:%@",urlstr);
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
                                              farmModel * FM=[[farmModel alloc]init];
                                              _dataSource=[FM asignInfoWithDict:jsonDic];
                                              
                                              farmModel *FM1=[[farmModel alloc]init];
                                              FM1.farmName=[NSString stringWithFormat:@"%@",@"新建"];
                                              FM1.farmImg=@"addFarm";
                                              FM1.farmId=@"-1";
                                              [_dataSource addObject:FM1];
                                              [self.collectionView reloadData];
                                              [SVProgressHUD dismiss];
                                              
                                          }else if([suc isEqualToString:@"无数据"])
                                          {
                                              farmModel *FM1=[[farmModel alloc]init];
                                              FM1.farmName=[NSString stringWithFormat:@"%@",@"新建"];
                                              FM1.farmImg=@"addFarm";
                                              FM1.farmId=@"-1";
                                              [_dataSource removeAllObjects];
                                              [_dataSource addObject:FM1];
                                              [self.collectionView reloadData];
                                              [SVProgressHUD dismiss];

                                          }
                                          else {
                                              //失败
                                              [SVProgressHUD showErrorWithStatus:k_Error_WebViewError];
                                              
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
