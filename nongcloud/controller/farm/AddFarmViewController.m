//
//  AddFarmViewController.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "AddFarmViewController.h"
#import "PublicDefine.h"
#import "deviceInfo.h"
#import "ListTableViewCell.h"
#import "AddDevViewController.h"
#import "stdTextField.h"
#import "YCXMenu.h"
#import "deviceInfo.h"
#import "stdPubFunc.h"

@interface AddFarmViewController ()<UITextFieldDelegate,stdTextFieldDelegate>

@end

@implementation AddFarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMyVar];
    [self loadTopNav];
    [self loadContentView];
    [self loadTableView];
    [self loadSubTableView];
    [self initRighmenuView];
    [self initSubRighmenuView];
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
    [_DevIdTxt resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; //键盘按下return，这句代码可以隐藏 键盘
    return YES;
}

-(void)initMyVar{
    _tableDataSource=[[NSMutableArray alloc]init];
    _SubTableDataSource=[[NSMutableArray alloc]init];
    _SubDevDict=[[NSMutableDictionary alloc]init];
    _subPageindex=1;
    _pageindex=1;
    _showType=0;
    _rightOffset=70;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 18, fDeviceWidth, 40)];
    topLbl.text=@"新建农场";
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
    [self makeUpLoadDict];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)loadContentView{
    UIView *topVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 80)];
    
    _FarmName=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, (fDeviceWidth-20), 30)];
    _Farm_type=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, (fDeviceWidth-20), 30)];
    [self stdInitTxtF:_FarmName hintxt:@"请输入农场名称"];
    [self stdInitTxtF:_Farm_type hintxt:@"请输入养殖种类"];
    [topVc addSubview:_FarmName];
    [topVc addSubview:_Farm_type];
    [self.view addSubview:topVc];
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


static NSString * const MarketCellId = @"DevTableCell";
-(void)loadTableView{
    CGFloat devH= (fDeviceHeight-TopSeachHigh-80)/2;
    
    UIView *devVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+80, fDeviceWidth, devH)];
    UILabel * devList=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
    devList.text=@"设备列表";
    [devList setTextColor:[UIColor blackColor]];
    
    
    UIImageView *addimg=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-35, 10, 24, 24)];
    addimg.image=[UIImage imageNamed:@"add"];
    [devVc addSubview:addimg];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn setFrame:CGRectMake(fDeviceWidth-80, 10, 80, 42)];
    [addBtn addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    [devVc addSubview:addBtn];
    
    
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, fDeviceWidth, devH-50)];
    self.TableView.tag=0;
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:MarketCellId];
    
    //self.TableView.backgroundColor=[UIColor redColor];

    [devVc addSubview:devList];
    [devVc addSubview:self.TableView];
    [self.view addSubview: devVc];
    if (_showType==1) {
        //[self loadTableData:@"uid" typeStr:_listType pageNo:_pageindex];
        
        // 下拉刷新
        __unsafe_unretained __typeof(self) weakSelf = self;
        self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageindex=1;
            //[self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
            [weakSelf.TableView.mj_header endRefreshing];
            // 进入刷新状态后会自动调用这个block
        }];
        
        // 上拉刷新
        self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            if (_tableDataSource.count>0) {
                _pageindex+=1;
                //[self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
            }
            else
            {
                _pageindex=1;
                //[self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
            }
            
            // 结束刷新
            [weakSelf.TableView.mj_footer endRefreshing];
        }];

    }
}

-(void)clickSubAddBtn{
    if (_tableDataSource.count>0) {
        [self popRighmenu:self.rightSubDevMenu];
    }
    else
    [stdPubFunc stdShowMessage:@"请先添加一个设备"];
    
}
static NSString * const SubDevCellId = @"SubDevTableCell";
-(void)loadSubTableView{
    CGFloat devH= (fDeviceHeight-TopSeachHigh-80)/2;
    
    UIView *devVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+80+devH, fDeviceWidth, devH)];
    UILabel * devList=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
    devList.text=@"子设备列表";
    [devList setTextColor:[UIColor blackColor]];
    
    
    UIImageView *addimg=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-35, 10, 24, 24)];
    addimg.image=[UIImage imageNamed:@"add"];
    [devVc addSubview:addimg];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn setFrame:CGRectMake(fDeviceWidth-80, 10, 80, 42)];
    [addBtn addTarget:self action:@selector(clickSubAddBtn) forControlEvents:UIControlEventTouchUpInside];
    [devVc addSubview:addBtn];
    
    
    self.SubTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, fDeviceWidth, devH-50)];
    self.SubTableView.tag=1;
    self.SubTableView.delegate=self;
    self.SubTableView.dataSource=self;
    [self.view addSubview:self.SubTableView];
    self.SubTableView.tableFooterView = [[UIView alloc]init];
    self.SubTableView.backgroundColor=collectionBgdColor;
    [self.SubTableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:SubDevCellId];
    
    //self.TableView.backgroundColor=[UIColor redColor];
    
    [devVc addSubview:devList];
    [devVc addSubview:self.SubTableView];
    [self.view addSubview: devVc];
    if (_showType==1) {
        //[self loadTableData:@"uid" typeStr:_listType pageNo:_pageindex];
        
        // 下拉刷新
        __unsafe_unretained __typeof(self) weakSelf = self;
        self.SubTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageindex=1;
            //[self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
            [weakSelf.SubTableView.mj_header endRefreshing];
            // 进入刷新状态后会自动调用这个block
        }];
        
        // 上拉刷新
        self.SubTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            if (_SubTableDataSource.count>0) {
                _pageindex+=1;
                //[self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
            }
            else
            {
                _pageindex=1;
                //[self loadTableData:ApplicationDelegate.myLoginInfo.communityId pageNo:_pageindex];
            }
            
            // 结束刷新
            [weakSelf.SubTableView.mj_footer endRefreshing];
        }];
        
    }
}
-(void)initRighmenuView{
    if (self.rightDevMenu == nil) {
       
        self.rightDevMenu = [[UIView alloc]initWithFrame:CGRectMake(fDeviceWidth, 20, fDeviceWidth-_rightOffset, fDeviceHeight - 20)];
        
        [self.view addSubview:self.rightDevMenu];
        
        
        [self.rightDevMenu setBackgroundColor:[UIColor whiteColor]];
        UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, fDeviceWidth-_rightOffset, 40)];
        topLbl.text=@"添加设备";
        [topLbl setTextAlignment:NSTextAlignmentCenter];
        [topLbl setTextColor:[UIColor blackColor]];
        [self.rightDevMenu addSubview:topLbl];
        
        UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 12, 24, 24)];
        backimg.image=[UIImage imageNamed:@"leftBack"];
        [self.rightDevMenu addSubview:backimg];
        //返回按钮
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setFrame:CGRectMake(0, 0, 70, 42)];
        [back addTarget:self action:@selector(devMenuCilck) forControlEvents:UIControlEventTouchUpInside];
        [self.rightDevMenu addSubview:back];
        
        UIView *topSprit=[[UIView alloc]initWithFrame:CGRectMake(0, 44, fDeviceWidth-_rightOffset, 1)];
        topSprit.backgroundColor=spritLineColor;
        [self.rightDevMenu addSubview:topSprit];
        
        _DevName=[[UITextField alloc]initWithFrame:CGRectMake(10, 65+31*0, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_DevName hintxt:@"设备名称"];
        _DevName.delegate=self;
        [self.rightDevMenu addSubview:_DevName];
        
        _oneStd=[[stdTextField alloc]initWithFrame:CGRectMake(10, 65+31*1, fDeviceWidth-_rightOffset-20, 30) titletxt:@"设备类型" stdImg:@"dropArrow" sendtag:0];
        [self.rightDevMenu addSubview:_oneStd];
        
        _twoStd=[[stdTextField alloc]initWithFrame:CGRectMake(10, 65+31*2, fDeviceWidth-_rightOffset-20, 30) titletxt:@"厂家" stdImg:@"dropArrow" sendtag:1];
        [self.rightDevMenu addSubview:_twoStd];
        
        _threeStd=[[stdTextField alloc]initWithFrame:CGRectMake(10, 65+31*3, fDeviceWidth-_rightOffset-20, 30) titletxt:@"型号" stdImg:@"dropArrow" sendtag:2];
        [self.rightDevMenu addSubview:_threeStd];
        
        _oneStd.stdtxtDelegate=self;
        _twoStd.stdtxtDelegate=self;
        _threeStd.stdtxtDelegate=self;
        
        _DevIdTxt=[[UITextField alloc]initWithFrame:CGRectMake(10, 65+31*4, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_DevIdTxt hintxt:@"设备ID"];
        _DevIdTxt.delegate=self;
        [self.rightDevMenu addSubview:_DevIdTxt];
        
        UIImageView *logobtnImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 65+31*6, fDeviceWidth-_rightOffset-20, 50)];
        logobtnImg.image=[UIImage imageNamed:@"logBtn"];
        [self.rightDevMenu addSubview:logobtnImg];
        
        UIButton* OkBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 65+31*6-3, fDeviceWidth-_rightOffset-20, 50)];
        
        [OkBtn addTarget:self action:@selector(clickAddToTable) forControlEvents:UIControlEventTouchUpInside];
        
        [OkBtn setTitle:@"确  定"forState:UIControlStateNormal];// 添加文字
        [self.rightDevMenu addSubview:OkBtn];
    }
}

-(void)clickAddToTable{
    deviceInfo *DEV=[[deviceInfo alloc]init];
    DEV.devName=_DevName.text;
    DEV.devType=_oneStd.titleLable.text;
    DEV.devTypeId=_oneStd.txtId;
    
    DEV.devFactory=_twoStd.titleLable.text;
    DEV.devFactoryId=_twoStd.txtId;
    
    DEV.devVersion=_threeStd.titleLable.text;
    DEV.devVersionId=_threeStd.txtId;
    
    DEV.devNo=_DevIdTxt.text;
    [_tableDataSource addObject:DEV];
    [self.TableView reloadData];
    
    [self hideRighMenu:self.rightDevMenu];
    
}
-(void)TextFieldDelegate:(UIButton*)sender{
    NSMutableArray *itemTmp;
    itemTmp=[self makeItems:sender.tag];
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[sender convertRect: sender.bounds toView:window];
    
    [self drawDropDownList:rect.origin.x+rect.size.width/2 ListY:rect.origin.y+rect.size.height items:itemTmp drawSender:sender.tag];
}
-(void)devMenuCilck{
    [self hideRighMenu:self.rightDevMenu];
}
-(void)popRighmenu:(UIView *)menuVc{
    CGRect Temp = menuVc.frame;
    Temp.origin.x = fDeviceWidth;
    menuVc.frame = Temp;
    Temp.origin.x = _rightOffset;
    [UIView animateWithDuration:0.3 animations:^{
        menuVc.frame = Temp;
    }];
    
    
}
-(void)hideRighMenu:(UIView *)menuVc{
    CGRect Temp = menuVc.frame;
    Temp.origin.x = _rightOffset;
    menuVc.frame = Temp;
    Temp.origin.x = fDeviceWidth;
    [UIView animateWithDuration:0.3 animations:^{
        menuVc.frame = Temp;
    }];
}
-(void)clickAddBtn{
    //[self initMyVar];
    [self popRighmenu:self.rightDevMenu];
    [_oneStd setTitleLableTxt:@"设备类型"];
    [_twoStd setTitleLableTxt:@"厂家"];
    [_threeStd setTitleLableTxt:@"型号"];
    [_DevIdTxt setText:@""];
}

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0) {
        return _tableDataSource.count;
    }
    else
        return _SubTableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MarketCellId forIndexPath:indexPath];
    //
    //    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    deviceInfo *dm=_tableDataSource[indexPath.item];
    [cell showUiDevCell:dm image:@""];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    }
    else{
        ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubDevCellId forIndexPath:indexPath];
        //
        //    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
        deviceInfo *dm=_SubTableDataSource[indexPath.item];
        [cell showUiDevCell:dm image:@""];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==0)
    {
//        if (_SubDevData.count>indexPath.item) {
//            
//            _SubTableDataSource=_SubDevData[indexPath.item];
//            
//            
//            
//        }
//        else
//        {
//            _SubTableDataSource=nil;
//            _SubTableDataSource=[[NSMutableArray alloc]init];
//            //[_SubTableDataSource removeAllObjects];
//            
//        }
        NSString * keyTmp=[NSString stringWithFormat:@"%ld",(long)indexPath.item];
        _SubTableDataSource=[_SubDevDict objectForKey:keyTmp];
       [_SubTableView reloadData];
    }
}

-(NSMutableArray *)makeItems:(NSInteger)itemType {
    NSMutableArray *itemData=[[NSMutableArray alloc]init];
    
    switch (itemType) {
        case 0:
            itemData = [@[
                          [YCXMenuItem menuItem:@"RTU节点"
                                          image:nil
                                            tag:100
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"0"],
                          [YCXMenuItem menuItem:@"摄像头"
                                          image:nil
                                            tag:101
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"1"],
                          [YCXMenuItem menuItem:@"温湿度传感器"
                                          image:nil
                                            tag:102
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"2"],
                          [YCXMenuItem menuItem:@"光照传感器"
                                          image:nil
                                            tag:103
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"3"],
                          [YCXMenuItem menuItem:@"土壤温湿度传感器"
                                          image:nil
                                            tag:104
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"4"]
                          
                          ] mutableCopy];
            break;
        case 1:
            itemData = [@[
                          [YCXMenuItem menuItem:@"天安在线"
                                          image:nil
                                            tag:100
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"0"],
                          [YCXMenuItem menuItem:@"先华通信"
                                          image:nil
                                            tag:101
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"1"],
                          [YCXMenuItem menuItem:@"海康"
                                          image:nil
                                            tag:102
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"2"]
                          
                          
                          ] mutableCopy];

            break;
        case 2:
            itemData = [@[
                          [YCXMenuItem menuItem:@"接触式无线CCD"
                                          image:nil
                                            tag:100
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"0"],
                          [YCXMenuItem menuItem:@"有线有源传感"
                                          image:nil
                                            tag:101
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"1"],
                          [YCXMenuItem menuItem:@"控制器"
                                          image:nil
                                            tag:102
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:@"2"]
                          
                          
                          ] mutableCopy];
            break;
        default:
            break;
    }
   
    return itemData;
}
-(void)drawDropDownList:(CGFloat)X ListY:(CGFloat)Y  items:(NSMutableArray *)itemArr drawSender:(NSInteger)senderIndex{
    [YCXMenu setTintColor:MyGrayColor];
    if ([YCXMenu isShow]){
        [YCXMenu dismissMenu];
    } else {
        
        [YCXMenu showMenuInView:self.view fromRect:CGRectMake(X, Y, 0, 0) menuItems:itemArr selected:^(NSInteger index, YCXMenuItem *item) {
            
            switch (senderIndex) {
                case 0:
                    [_oneStd setTitleLableTxt:item.title];
                    [_oneStd setTxtId:item.menuId];
                    break;
                case 1:
                    [_twoStd setTitleLableTxt:item.title];
                    [_twoStd setTxtId:item.menuId];
                    break;
                case 2:
                    [_threeStd setTitleLableTxt:item.title];
                    [_threeStd setTxtId:item.menuId];
                    break;
                default:
                    break;
            }
            
        }];
    }
}

-(void)initSubRighmenuView{
    if (self.rightSubDevMenu == nil) {
        
        self.rightSubDevMenu = [[UIView alloc]initWithFrame:CGRectMake(fDeviceWidth, 20, fDeviceWidth-_rightOffset, fDeviceHeight - 20)];
        
        [self.view addSubview:self.rightSubDevMenu];
        [self.rightSubDevMenu setBackgroundColor:[UIColor whiteColor]];
        UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, fDeviceWidth-_rightOffset, 40)];
        topLbl.text=@"添加子设备";
        [topLbl setTextAlignment:NSTextAlignmentCenter];
        [topLbl setTextColor:[UIColor blackColor]];
        [self.rightSubDevMenu addSubview:topLbl];
        
        UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 12, 24, 24)];
        backimg.image=[UIImage imageNamed:@"leftBack"];
        [self.rightSubDevMenu addSubview:backimg];
        //返回按钮
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        [back setFrame:CGRectMake(0, 0, 70, 42)];
        [back addTarget:self action:@selector(devSubMenuCilck) forControlEvents:UIControlEventTouchUpInside];
        [self.rightSubDevMenu addSubview:back];
        
        UIView *topSprit=[[UIView alloc]initWithFrame:CGRectMake(0, 44, fDeviceWidth-_rightOffset, 1)];
        topSprit.backgroundColor=spritLineColor;
        [self.rightSubDevMenu addSubview:topSprit];
        
        CGFloat YOffset=65;
        CGFloat editIndex=0;
        CGFloat editHeigh=31;
        
        _DevNameTxt=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_DevNameTxt hintxt:@"名称"];
        _DevNameTxt.delegate=self;
        [self.rightSubDevMenu addSubview:_DevNameTxt];
        
        editIndex+=1;
        YOffset+=15;
        _oneSubStd=[[stdTextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30) titletxt:@"厂家" stdImg:@"dropArrow" sendtag:0];
        [self.rightSubDevMenu addSubview:_oneSubStd];
        
        editIndex+=1;
        _twoSubStd=[[stdTextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30) titletxt:@"设备型号" stdImg:@"dropArrow" sendtag:1];
        [self.rightSubDevMenu addSubview:_twoSubStd];
        
        
        
        _oneSubStd.stdtxtDelegate=self;
        _twoSubStd.stdtxtDelegate=self;
        
        
        editIndex+=1;
        YOffset+=15;
        _DevAddrTxt=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_DevAddrTxt hintxt:@"地址"];
        _DevAddrTxt.delegate=self;
        [self.rightSubDevMenu addSubview:_DevAddrTxt];
        
        editIndex+=1;
        _SubDevIdTxt=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevIdTxt hintxt:@"设备ID"];
        _SubDevIdTxt.delegate=self;
        [self.rightSubDevMenu addSubview:_SubDevIdTxt];
        
        editIndex+=1;
        YOffset+=15;
        _SubDevControl1=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevControl1 hintxt:@"控制通道1"];
        _SubDevControl1.delegate=self;
        [self.rightSubDevMenu addSubview:_SubDevControl1];
        
        editIndex+=1;
        _SubDevControl2=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevControl2 hintxt:@"控制通道2"];
        _SubDevControl2.delegate=self;
        [self.rightSubDevMenu addSubview:_SubDevControl2];
        
        editIndex+=1;
        _SubDevControl3=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevControl3 hintxt:@"控制通道3"];
        _SubDevControl3.delegate=self;
        [self.rightSubDevMenu addSubview:_SubDevControl3];
        
        editIndex+=1;
        _SubDevControl4=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevControl4 hintxt:@"控制通道4"];
        _SubDevControl4.delegate=self;
        [self.rightSubDevMenu addSubview:_SubDevControl4];
        
        
        editIndex+=2;
        UIImageView *logobtnImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 50)];
        logobtnImg.image=[UIImage imageNamed:@"logBtn"];
        [self.rightSubDevMenu addSubview:logobtnImg];
        
        UIButton* OkBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex-3, fDeviceWidth-_rightOffset-20, 50)];
        
        [OkBtn addTarget:self action:@selector(clickAddToSubTable) forControlEvents:UIControlEventTouchUpInside];
        
        [OkBtn setTitle:@"确  定"forState:UIControlStateNormal];// 添加文字
        [self.rightSubDevMenu addSubview:OkBtn];
    }
}

-(void)devSubMenuCilck{
    [self hideRighMenu:_rightSubDevMenu];
}
-(NSMutableArray*)stdDeepCopyArr:(NSMutableArray*)SrcArr{
    NSMutableArray *dscArr=[[NSMutableArray alloc]init];
    for (int i; i<SrcArr.count; i++) {
        [dscArr addObject:SrcArr[i]];
        
    }
    
    
    return dscArr;

}

-(void)clickAddToSubTable{
    deviceInfo *DEV=[[deviceInfo alloc]init];
    DEV.devName=_DevNameTxt.text;
//    DEV.devTypeId=_oneSubStd.txtId;
    
    DEV.devFactory=_oneSubStd.titleLable.text;//厂家
    DEV.devFactoryId=_oneSubStd.txtId;
    
    DEV.devVersion=_twoSubStd.titleLable.text;//型号
    DEV.devVersionId=_twoSubStd.txtId;
    
    DEV.devAddr=_DevAddrTxt.text;//地址
    DEV.devNo=_SubDevIdTxt.text;//设备Id
    DEV.controlPip1=_SubDevControl1.text;
    DEV.controlPip2=_SubDevControl2.text;
    DEV.controlPip3=_SubDevControl3.text;
    DEV.controlPip4=_SubDevControl4.text;
    
    if (!_SubTableDataSource) {
        _SubTableDataSource=[[NSMutableArray alloc]init];
    }
    [_SubTableDataSource addObject:DEV];
    [self.SubTableView reloadData];
    NSUInteger indexI=_TableView.indexPathForSelectedRow.item;//>0?:0;
    
   // NSMutableArray *subArr=[self stdDeepCopyArr:_SubTableDataSource];
   // NSArray* subArr = [NSKeyedUnarchiver unarchiveObjectWithData:
    //                              [NSKeyedArchiver archivedDataWithRootObject: _SubTableDataSource]];
    NSMutableArray* subArr=[[NSMutableArray alloc]initWithArray:_SubTableDataSource];
//    if (_SubDevData.count>indexI) {
//        [_SubDevData replaceObjectAtIndex:_TableView.indexPathForSelectedRow.item withObject:subArr];
//    }
//    else//此设备第一次添加子设备
//        [_SubDevData addObject:subArr];
    
    NSString* subKey=[NSString stringWithFormat:@"%lu",(unsigned long)indexI];
    [_SubDevDict setObject:subArr forKey:subKey];
    [self hideRighMenu:self.rightSubDevMenu];
    
}
-(NSDictionary *)makeUpLoadDict{
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
   
    [dict setObject:_FarmName.text forKey:@"farmName"];
    [dict setObject:_Farm_type.text forKey:@"farmType"];
    NSMutableArray *devList=[[NSMutableArray alloc]init];
    
    int i=0;
    for (deviceInfo *dev in _tableDataSource) {
        NSMutableArray *subDevList=[[NSMutableArray alloc]init];
        NSMutableArray *equipmentSub=[[NSMutableArray alloc]init];
        NSString *keyStr=[NSString stringWithFormat:@"%d",i];
        i++;
        subDevList=[_SubDevDict objectForKey:keyStr];
        
         for (deviceInfo *subDev in subDevList)
         {
             NSMutableDictionary * subDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        subDev.devName,@"equipmentName",
                                          subDev.devNo,@"equipmentNo",
                                          subDev.devTypeId,@"equipmentType",
                                          subDev.devFactoryId,@"equipmentFactoryId",
                                          subDev.devVersion,@"equipmentModelId",
                                            subDev.controlPip1,@"controlChannelOne",
                                            subDev.controlPip2,@"controlChannelTwo",
                                            subDev.controlPip3,@"controlChannelThree",
                                            subDev.controlPip4,@"controlChannelFour",
                                          nil];
             [equipmentSub addObject:subDict];
         }
             
        NSMutableDictionary * pDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:dev.devName,@"equipmentName",
                                     dev.devNo,@"equipmentNo",
                                     dev.devTypeId,@"equipmentType",
                                     dev.devFactoryId,@"equipmentFactoryId",
                                     dev.devVersion,@"equipmentModelId",
                                     equipmentSub,@"equipmentSub",
                                     nil];
        [devList addObject:pDict];
    }
    [dict setObject:devList forKey:@"equipment"];
    NSLog(@"dict:%@",[self dictionaryToJson:dict]);
    
    
    return dict;

}

-(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//登录
-(void)loginNetFuc:(NSString*)usr passWord:(NSString*)psw{
    [SVProgressHUD showWithStatus:k_Status_Load];
    //http://192.168.0.21:8080/propies/login/user?userLogin=admin&userPwd=aaaaaa
//    NSDictionary *paramDict = @{
//                                @"ut":@"indexVilliageGoods",
//                                };
    NSDictionary *paramDict =[self makeUpLoadDict];
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"propies/login/user?userLogin="];
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
                                          if ([suc isEqualToString:@"登陆成功"]) {
                                              //成功
                                              
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
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                            }];
    
}
@end
