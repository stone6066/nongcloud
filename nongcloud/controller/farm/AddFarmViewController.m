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
    [_FarmName resignFirstResponder];
    [_DevName resignFirstResponder];
    [_DevNameTxt resignFirstResponder];
    [_DevAddrTxt resignFirstResponder];
    [_SubDevIdTxt resignFirstResponder];
    [_SubDevControl1 resignFirstResponder];
    [_SubDevControl2 resignFirstResponder];
    [_SubDevControl3 resignFirstResponder];
    [_SubDevControl4 resignFirstResponder];

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
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)loadContentView{
    UIView *topVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 80)];
    
    _FarmName=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, (fDeviceWidth-20), 30)];
    
    _Farm_type=[[stdTextField alloc]initWithFrame:CGRectMake(10, 50, (fDeviceWidth-20), 30) titletxt:@"请选择养殖种类" stdImg:@"dropArrow" sendtag:6];
    [self.rightDevMenu addSubview:_oneStd];
    
//    _Farm_type=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, (fDeviceWidth-20), 30)];
    [self stdInitTxtF:_FarmName hintxt:@"请输入农场名称"];
    //[self stdInitTxtF:_Farm_type hintxt:@"请输入养殖种类"];
    [topVc addSubview:_FarmName];
    [topVc addSubview:_Farm_type];
    _Farm_type.stdtxtDelegate=self;
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
    CGFloat devH= (fDeviceHeight-TopSeachHigh-80)/2-40;
    
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
         _subDeviceShowType=0;
        _DevNameTxt.text=@"";
        
        [_threeSubStd setTitleLableTxt:@"设备类型"];
        [_threeSubStd setTxtId:@""];
        
        [_oneSubStd setTitleLableTxt:@"厂家"];
        [_oneSubStd setTxtId:@""];
        
        [_twoSubStd setTitleLableTxt:@"设备型号"];
        [_twoSubStd setTxtId:@""];
        
        _DevAddrTxt.text=@"";
        _SubDevIdTxt.text=@"";
        
        _SubDevControl1.text=@"";
        _SubDevControl2.text=@"";
        _SubDevControl3.text=@"";
        _SubDevControl4.text=@"";
        _SubDevMaxValue.text=@"";
        _SubDevMinValue.text=@"";
    }
    else
    [stdPubFunc stdShowMessage:@"请先添加一个设备"];
}
-(void)alertSubDev:(deviceInfo*)dev{
    _subDeviceShowType=1;
    [self popRighmenu:self.rightSubDevMenu];
        
    _DevNameTxt.text=dev.devName;
        
    [_threeSubStd setTitleLableTxt:dev.devType];
    [_threeSubStd setTxtId:dev.devTypeId];
        
    [_oneSubStd setTitleLableTxt:dev.devFactory];
    [_oneSubStd setTxtId:dev.devFactoryId];
        
    [_twoSubStd setTitleLableTxt:dev.devVersion];
    [_twoSubStd setTxtId:dev.devVersionId];
    
    _DevAddrTxt.text=dev.devAddr;
    _SubDevIdTxt.text=dev.devNo;
    
    _SubDevControl1.text=dev.controlPip1;
    _SubDevControl2.text=dev.controlPip2;
    _SubDevControl3.text=dev.controlPip3;
    _SubDevControl4.text=dev.controlPip4;
    _SubDevMaxValue.text=dev.maxLimit;
    _SubDevMinValue.text=dev.minLimit;
    
    }

static NSString * const SubDevCellId = @"SubDevTableCell";
-(void)loadSubTableView{
    CGFloat devH= (fDeviceHeight-TopSeachHigh-80)/2-40;
    
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
    [self addUpInfoBtn];
}

-(void)addUpInfoBtn{
    UIImageView *logobtnImg=[[UIImageView alloc]initWithFrame:CGRectMake(20, fDeviceHeight-60, fDeviceWidth-40, 50)];
    logobtnImg.image=[UIImage imageNamed:@"logBtn"];
    [self.view addSubview:logobtnImg];
    
    UIButton *UpInfoBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, fDeviceHeight-70, fDeviceWidth-40, 60)];
    [self.view addSubview:UpInfoBtn];
    [UpInfoBtn addTarget:self action:@selector(clickUpinfo) forControlEvents:UIControlEventTouchUpInside];
    
    [UpInfoBtn setTitle:@"保   存"forState:UIControlStateNormal];// 添加文字
}
-(void)clickUpinfo{
    [self addFarmToSrvFuc];
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
    DEV.devAddr=@"";
   
    if (_deviceShowType==0) {//新建设备
        if (_tableDataSource.count>0) {//新加的id比数组最后一个id大1
            deviceInfo *devtmp=_tableDataSource[_tableDataSource.count-1];
            NSString* idtmp= devtmp.devId;
            NSInteger ii=[idtmp integerValue];
            ii+=1;
            idtmp=[NSString stringWithFormat:@"%lu",(unsigned long)ii];
            DEV.devId=idtmp;
            
        }
        else
            DEV.devId=@"1";
         [_tableDataSource addObject:DEV];
    }
    else{//编辑设备
            deviceInfo *devtmp=_tableDataSource[_selectedTableIndex];
            DEV.devId=devtmp.devId;
        [_tableDataSource replaceObjectAtIndex:_selectedTableIndex withObject:DEV];
    }
    
    
   
    [self.TableView reloadData];
    
    [self hideRighMenu:self.rightDevMenu];
    
}
-(void)TextFieldDelegate:(UIButton*)sender{
    
//    NSMutableArray *itemTmp;
//    itemTmp=[self makeItems:sender.tag];
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[sender convertRect: sender.bounds toView:window];
 
    [self getDataTypenew:sender.tag popRect:rect];
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
    _deviceShowType=0;
    [self popRighmenu:self.rightDevMenu];
    _DevName.text=@"";
    [_oneStd setTitleLableTxt:@"设备类型"];
    [_twoStd setTitleLableTxt:@"厂家"];
    [_threeStd setTitleLableTxt:@"型号"];
    [_DevIdTxt setText:@""];
}
-(void)alertDev:(deviceInfo*)dev{
    _deviceShowType=1;
    [self popRighmenu:self.rightDevMenu];
    
    _DevName.text=dev.devName;
    
    [_oneStd setTitleLableTxt:dev.devType];
    [_oneStd setTxtId:dev.devTypeId];
    
    [_twoStd setTitleLableTxt:dev.devFactory];
    [_twoStd setTxtId:dev.devFactoryId];
    
    [_threeStd setTitleLableTxt:dev.devVersion];
    [_threeStd setTxtId:dev.devVersionId];
    
    [_DevIdTxt setText:dev.devNo];
}
#pragma mark table delegate
-(NSArray* )tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
            if (tableView.tag==0) {
        
                deviceInfo *dev=_tableDataSource[indexPath.item];
                NSString *keystr=dev.devId;
                [_SubDevDict removeObjectForKey:keystr];//删除对应的子设备
        
                [_tableDataSource removeObjectAtIndex:indexPath.item];//删除设备
                _SubTableDataSource=nil;
        
                [_SubTableView reloadData];
        
        
            }
            else
            {
                [_SubTableDataSource removeObjectAtIndex:indexPath.item];
                [self setSubDevDictFromArr];
            }
            [tableView reloadData];
    }];//此处是iOS8.0以后苹果最新推出的api，UITableViewRowAction，Style是划出的标签颜色等状态的定义，这里也可自行定义
    
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        if (tableView.tag==0) {
            deviceInfo *dev=_tableDataSource[indexPath.item];
            [self alertDev:dev];
        }
        else{
            deviceInfo *dev=_SubTableDataSource[indexPath.item];
            [self alertSubDev:dev];
        }
        
    }];
    editRowAction.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];//可以定义RowAction的颜色
    return @[deleteRoWAction, editRowAction];//最后返回这俩个RowAction 的数组
    
}
////按钮显示的内容
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return @"删除";
//    
//}
////这里就是点击删除执行的方法
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%ld",(long)indexPath.item);
//    if (tableView.tag==0) {
//        
//        deviceInfo *dev=_tableDataSource[indexPath.item];
//        NSString *keystr=dev.devId;
//        [_SubDevDict removeObjectForKey:keystr];//删除对应的子设备
//       
//        [_tableDataSource removeObjectAtIndex:indexPath.item];//删除设备
//        _SubTableDataSource=nil;
//        
//        [_SubTableView reloadData];
//        
//        
//    }
//    else
//    {
//        [_SubTableDataSource removeObjectAtIndex:indexPath.item];
//        [self setSubDevDictFromArr];
//    }
//    [tableView reloadData];
//}

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
    _selectedTableIndex=indexPath.item;
    if (tableView.tag==0)
    {
        deviceInfo *dev=_tableDataSource[indexPath.item];
        _SubTableDataSource=[_SubDevDict objectForKey:dev.devId];
       [_SubTableView reloadData];
       
    }
}


-(void)drawDropDownList:(CGFloat)X ListY:(CGFloat)Y itemWidth:(CGFloat)iWidth items:(NSMutableArray *)itemArr drawSender:(NSInteger)senderIndex{
    [YCXMenu setTintColor:MyGrayColor];
    if ([YCXMenu isShow]){
        [YCXMenu dismissMenu];
    } else {
        [YCXMenu showMenuInView:self.view  fromRect:CGRectMake(X, Y, 0, 0) menuItems:itemArr itemWidth:iWidth selected:^(NSInteger index, YCXMenuItem *item ) {
            
            switch (senderIndex) {
                case 0:
                    [_oneStd setTitleLableTxt:item.title];
                    [_oneStd setTxtId:item.menuId];
                    
                    [_twoStd setTitleLableTxt:@"厂家"];
                    [_twoStd setTxtId:@""];
                    
                    [_threeStd setTitleLableTxt:@"型号"];
                    [_threeStd setTxtId:@""];

                    
                    break;
                case 1:
                    [_twoStd setTitleLableTxt:item.title];
                    [_twoStd setTxtId:item.menuId];
                    [_threeStd setTitleLableTxt:@"型号"];
                    [_threeStd setTxtId:@""];
                    break;
                case 2:
                    [_threeStd setTitleLableTxt:item.title];
                    [_threeStd setTxtId:item.menuId];
                    break;
                    
                    
                case 3:
                    [_threeSubStd setTitleLableTxt:item.title];
                    [_threeSubStd setTxtId:item.menuId];
                    
                    [_oneSubStd setTitleLableTxt:@"厂家"];
                    [_oneSubStd setTxtId:@""];
                    
                    [_twoSubStd setTitleLableTxt:@"设备型号"];
                    [_twoSubStd setTxtId:@""];
                    break;
                case 4:
                    [_oneSubStd setTitleLableTxt:item.title];
                    [_oneSubStd setTxtId:item.menuId];
                    [_twoSubStd setTitleLableTxt:@"设备型号"];
                    [_twoSubStd setTxtId:@""];
                    break;
                case 5:
                    [_twoSubStd setTitleLableTxt:item.title];
                    [_twoSubStd setTxtId:item.menuId];
                    break;
                case 6:
                    [_Farm_type setTitleLableTxt:item.title];
                    [_Farm_type setTxtId:item.menuId];
                    break;
                default:
                    break;
            }
            
        }];
    }
}

-(void)initSubRighmenuView{
    if (self.rightSubDevMenu == nil) {
        CGFloat ScrollHeigh=fDeviceHeight;
        self.rightSubDevMenu = [[UIView alloc]initWithFrame:CGRectMake(fDeviceWidth, 20, fDeviceWidth-_rightOffset, fDeviceHeight - 20)];
        
        
        
        UIScrollView *scollVc=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, fDeviceWidth-_rightOffset, fDeviceHeight)];
       
        [scollVc setBackgroundColor:[UIColor whiteColor]];
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
        
        CGFloat YOffset=10;
        CGFloat editIndex=0;
        CGFloat editHeigh=31;
        
        _DevNameTxt=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_DevNameTxt hintxt:@"名称"];
        _DevNameTxt.delegate=self;
        [scollVc addSubview:_DevNameTxt];
        
        editIndex+=1;
        YOffset+=15;
        _threeSubStd=[[stdTextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30) titletxt:@"设备类型" stdImg:@"dropArrow" sendtag:3];
        [scollVc addSubview:_threeSubStd];
        
        editIndex+=1;
        _oneSubStd=[[stdTextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30) titletxt:@"厂家" stdImg:@"dropArrow" sendtag:4];
        [scollVc addSubview:_oneSubStd];
        
        editIndex+=1;
        _twoSubStd=[[stdTextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30) titletxt:@"设备型号" stdImg:@"dropArrow" sendtag:5];
        [scollVc addSubview:_twoSubStd];
        
        
        
        _oneSubStd.stdtxtDelegate=self;
        _twoSubStd.stdtxtDelegate=self;
        _threeSubStd.stdtxtDelegate=self;
        
        
        editIndex+=1;
        YOffset+=15;
        _DevAddrTxt=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_DevAddrTxt hintxt:@"地址"];
        _DevAddrTxt.delegate=self;
        [scollVc addSubview:_DevAddrTxt];
        
        editIndex+=1;
        _SubDevIdTxt=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevIdTxt hintxt:@"设备ID"];
        _SubDevIdTxt.delegate=self;
        [scollVc addSubview:_SubDevIdTxt];
        
        editIndex+=1;
        YOffset+=15;
        _SubDevControl1=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevControl1 hintxt:@"控制通道1"];
        _SubDevControl1.delegate=self;
        [scollVc addSubview:_SubDevControl1];
        
        editIndex+=1;
        _SubDevControl2=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevControl2 hintxt:@"控制通道2"];
        _SubDevControl2.delegate=self;
        [scollVc addSubview:_SubDevControl2];
        
        editIndex+=1;
        _SubDevControl3=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevControl3 hintxt:@"控制通道3"];
        _SubDevControl3.delegate=self;
        [scollVc addSubview:_SubDevControl3];
        
        editIndex+=1;
        _SubDevControl4=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevControl4 hintxt:@"控制通道4"];
        _SubDevControl4.delegate=self;
        [scollVc addSubview:_SubDevControl4];
        
        editIndex+=1;
        _SubDevMaxValue=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevMaxValue hintxt:@"最高阀值"];
        _SubDevMaxValue.delegate=self;
        [scollVc addSubview:_SubDevMaxValue];
        
        editIndex+=1;
        _SubDevMinValue=[[UITextField alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 30)];
        [self stdInitTxtF:_SubDevMinValue hintxt:@"最低阀值"];
        _SubDevMinValue.delegate=self;
        [scollVc addSubview:_SubDevMinValue];
        
        
        editIndex+=1;
        YOffset+=15;
        UIImageView *logobtnImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex, fDeviceWidth-_rightOffset-20, 50)];
        logobtnImg.image=[UIImage imageNamed:@"logBtn"];
        [scollVc addSubview:logobtnImg];
        
        UIButton* OkBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, YOffset+editHeigh*editIndex-3, fDeviceWidth-_rightOffset-20, 50)];
        
        [OkBtn addTarget:self action:@selector(clickAddToSubTable) forControlEvents:UIControlEventTouchUpInside];
        
        [OkBtn setTitle:@"确  定"forState:UIControlStateNormal];// 添加文字
        [scollVc addSubview:OkBtn];
        ScrollHeigh=YOffset+editHeigh*editIndex-3+150;
        [scollVc setContentSize:CGSizeMake(fDeviceWidth-_rightOffset, ScrollHeigh)];
        
        [self.rightSubDevMenu addSubview:scollVc];
        [self.view addSubview:self.rightSubDevMenu];
        
    }
}

-(void)devSubMenuCilck{
    [self hideRighMenu:_rightSubDevMenu];
}


-(void)clickAddToSubTable{
    deviceInfo *DEV=[[deviceInfo alloc]init];
    DEV.devName=_DevNameTxt.text;
    
    DEV.devType=_threeSubStd.titleLable.text;
    DEV.devTypeId=_threeSubStd.txtId;//设备类型
    
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
    DEV.maxLimit=_SubDevMaxValue.text;
    DEV.minLimit=_SubDevMinValue.text;
    
    if (!_SubTableDataSource) {
        _SubTableDataSource=[[NSMutableArray alloc]init];
    }
    if (_subDeviceShowType==0) {//新建子设备
        [_SubTableDataSource addObject:DEV];
    }
    else{//编辑子设备
        
        [_SubTableDataSource replaceObjectAtIndex:_selectedTableIndex withObject:DEV];
    }
    
    [self.SubTableView reloadData];

    [self setSubDevDictFromArr];
    [self hideRighMenu:self.rightSubDevMenu];
    
}
-(void)setSubDevDictFromArr{
    NSUInteger indexI=_TableView.indexPathForSelectedRow.item;
    deviceInfo * dev=_tableDataSource[indexI];
    
    NSMutableArray* subArr=[[NSMutableArray alloc]initWithArray:_SubTableDataSource];
    [_SubDevDict setObject:subArr forKey:dev.devId];
}
-(NSDictionary *)makeUpLoadDict{
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
   
    [dict setObject:_FarmName.text forKey:@"farmName"];
    [dict setObject:_Farm_type.txtId forKey:@"farmTypeId"];
    [dict setObject:ApplicationDelegate.myLoginInfo.userId forKey:@"userId"];
    [dict setObject:@"" forKey:@"farmId"];
    NSMutableArray *devList=[[NSMutableArray alloc]init];
    
    
    for (deviceInfo *dev in _tableDataSource) {
        NSMutableArray *subDevList=[[NSMutableArray alloc]init];
        NSMutableArray *equipmentSub=[[NSMutableArray alloc]init];
        NSString *keyStr=dev.devId;
        
        subDevList=[_SubDevDict objectForKey:keyStr];
        
         for (deviceInfo *subDev in subDevList)//子设备
         {
             if (subDev.maxLimit.length<1) {
                 subDev.maxLimit=@"null";
             }
             if (subDev.minLimit.length<1) {
                 subDev.minLimit=@"null";
             }
             if (subDev.controlPip1.length<1) {
                 subDev.controlPip1=@"null";
             }
             if (subDev.controlPip2.length<1) {
                 subDev.controlPip2=@"null";
             }
             if (subDev.controlPip3.length<1) {
                 subDev.controlPip3=@"null";
             }
             if (subDev.controlPip4.length<1) {
                 subDev.controlPip4=@"null";
             }
             NSMutableDictionary * subDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        @"",@"equipmentId",
                                        subDev.devName,@"equipmentName",
                                          subDev.devNo,@"equipmentNo",
                                          subDev.devFactoryId,@"equipmentFactoryId",
                                          subDev.devVersionId,@"equipmentModelId",
                                            subDev.devTypeId,@"equipmentType",
                                            subDev.controlPip1,@"controlChannelOne",
                                            subDev.controlPip2,@"controlChannelTwo",
                                            subDev.controlPip3,@"controlChannelThree",
                                            subDev.controlPip4,@"controlChannelFour",
                                            subDev.maxLimit,@"referenceUpLimit",
                                            subDev.minLimit,@"referenceDownLimit",
                                            subDev.devAddr,@"equipmentAddr",
                                            
                                          nil];
             [equipmentSub addObject:subDict];
         }
             
        NSMutableDictionary * pDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"",@"equipmentId",
                                     dev.devName,@"equipmentName",
                                     dev.devNo,@"equipmentNo",
                                     dev.devTypeId,@"equipmentType",
                                     dev.devFactoryId,@"equipmentFactoryId",
                                     dev.devVersionId,@"equipmentModelId",
                                     dev.devAddr,@"equipmentAddr",
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


//上报
-(void)addFarmToSrvFuc{
    [SVProgressHUD showWithStatus:k_Status_Load];
   

    
    NSDictionary *paramDict =[self makeUpLoadDict];

    NSString *urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"Former/farm/farmAdd"];
    
    
    NSLog(@"addFarmToSrvFuc:%@",urlstr);
    // 设置请求格式
    ApplicationDelegate.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    ApplicationDelegate.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
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
                                              
                                              [SVProgressHUD dismiss];
                                              [stdPubFunc stdShowMessage:@"添加成功"];
                                              [self.navigationController popViewControllerAnimated:NO];
                                              
                                              
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

//获取数据类型
-(void)getDataType:(NSInteger)typyNum popRect:(CGRect)rectTmp{
    [SVProgressHUD showWithStatus:k_Status_Load];

    NSString *urlstr=@"";
    
    switch (typyNum) {
        case 0://设备类型
            urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"Former/equipment/equipmentType"];
            break;
        case 1://厂家
            
            if (_oneStd.txtId.length>0) {
                urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"Former/equipment/equipmentFactory?equipmentType=",_oneStd.txtId];
            }
            
            break;
        case 2://设备型号
            if (_twoStd.txtId.length>0)
                urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"Former/equipment/equipmentModel?equipmentFactory=",_twoStd.txtId];
            break;
            
        case 3://设备类型
            urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"Former/equipment/equipmentType"];
            break;
         
        case 4://厂家
            
            if (_threeSubStd.txtId.length>0)
            urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"Former/equipment/equipmentFactory?equipmentType=",_threeSubStd.txtId];
            break;
            
        case 5://设备型号
            if (_oneSubStd.txtId.length>0)
                urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"Former/equipment/equipmentModel?equipmentFactory=",_oneSubStd.txtId];
            break;
        case 6://获取种植类型
             urlstr=[NSString stringWithFormat:@"%@%@",BaseUrl,@"Former/farm/farmType"];
            break;
            
        default:
            break;
    }
    NSLog(@"urlstr:%@",urlstr);
    if (urlstr.length<1) {
        [SVProgressHUD dismiss];
        [stdPubFunc stdShowMessage:@"请先选择上一个选项"];
        return;
    }
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
                                              
                                              [self drawDropDownList:rectTmp.origin.x+rectTmp.size.width/2
                                                ListY:rectTmp.origin.y+rectTmp.size.height
                                                itemWidth:rectTmp.size.width
                                                items:[self praseTypeData:jsonDic TypeNum:typyNum]
                                                drawSender:typyNum];
                                              
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

-(NSMutableArray*)praseTypeData:(NSDictionary*)jDict TypeNum:(NSInteger)Tnum{
    NSMutableArray *arrRt=[[NSMutableArray alloc]init];
    NSMutableArray * arr=[jDict objectForKey:@"data"];
    NSInteger i=0;
    switch (Tnum) {
        case 0:
        case 3:
            for (NSDictionary*dict in arr) {
                i++;
                [arrRt addObject:[YCXMenuItem menuItem:[dict objectForKey:@"equipmentTypeName"]
                                                 image:nil
                                                   tag:100+i
                                              userInfo:@{@"title":@"Menu"}
                                                menuId:[[dict objectForKey:@"equipmentType"]stringValue]]];
            }

            break;
        case 1:
        case 4:
            for (NSDictionary*dict in arr) {
                i++;
                [arrRt addObject:[YCXMenuItem menuItem:[dict objectForKey:@"equipmentFactoryName"]
                                                 image:nil
                                                   tag:100+i
                                              userInfo:@{@"title":@"Menu"}
                                                menuId:[[dict objectForKey:@"equipmentFactoryId"]stringValue]]];
            }
            
            break;
        case 2:
        case 5:
            for (NSDictionary*dict in arr) {
                i++;
                [arrRt addObject:[YCXMenuItem menuItem:[dict objectForKey:@"equipmentModelName"]
                                                 image:nil
                                                   tag:100+i
                                              userInfo:@{@"title":@"Menu"}
                                                menuId:[[dict objectForKey:@"equipmentModelId"]stringValue]]];
            }
            
            break;
        
        case 6:
            for (NSDictionary*dict in arr) {
                i++;
                [arrRt addObject:[YCXMenuItem menuItem:[dict objectForKey:@"typeName"]
                                                 image:nil
                                                   tag:100+i
                                              userInfo:@{@"title":@"Menu"}
                                                menuId:[[dict objectForKey:@"farmTypeId"]stringValue]]];
            }
            
            break;
        default:
            break;
    }
        return arrRt;

}

//从本地字典文件中获取数据类型
-(void)getDataTypenew:(NSInteger)typyNum popRect:(CGRect)rectTmp{

    NSString *urlstr=@"";
    NSMutableArray * itemArr=[[NSMutableArray alloc]init];
    switch (typyNum) {
        case 0://设备类型
            itemArr=[self readOneDataType];
            break;
        case 1://厂家
            if (_oneStd.txtId.length>0) {
                itemArr=[self readTwoDataType:_oneStd.txtId];
            }
            
            break;
        case 2://设备型号
            if (_twoStd.txtId.length>0)
                itemArr=[self readThreeDataType:_oneStd.txtId factoryId:_twoStd.txtId];
            
            break;
            
            
            
        case 3://设备类型
            itemArr=[self readOneDataType];
            break;
            
        case 4://厂家
            
            if (_threeSubStd.txtId.length>0)
                itemArr=[self readTwoDataType:_threeSubStd.txtId];
            break;
            
        case 5://设备型号
            if (_oneSubStd.txtId.length>0)
                itemArr=[self readThreeDataType:_threeSubStd.txtId factoryId:_oneSubStd.txtId];
            break;
        case 6://获取种植类型
            
            itemArr=[self readFarmType];
            break;
            
        default:
            break;
    }
    NSLog(@"urlstr:%@",urlstr);
    if (itemArr.count<1) {
        [stdPubFunc stdShowMessage:@"请先选择上一个选项"];
        return;
    }
    
    [self drawDropDownList:rectTmp.origin.x+rectTmp.size.width/2
                     ListY:rectTmp.origin.y+rectTmp.size.height
                 itemWidth:rectTmp.size.width
                     items:itemArr
                drawSender:typyNum];
}


-(NSMutableArray*)readOneDataType{
   
    NSString *dataFilePath = [DocumentBasePath stringByAppendingFormat:@"/%@.plist", @"getEquipmentType"];
    NSArray * TypeArr=[[NSArray alloc]initWithContentsOfFile:dataFilePath];
    NSInteger i=0;
    NSMutableArray *oneArr=[[NSMutableArray alloc]init];//第1个下拉列表的数据
//    NSMutableArray *twoArr=[[NSMutableArray alloc]init];//第2个下拉列表的数据
//    NSMutableArray *threeArr=[[NSMutableArray alloc]init];//第3个下拉列表的数据
    
    for (NSDictionary* dict in TypeArr) {
        i++;
        [oneArr addObject:[YCXMenuItem menuItem:[dict objectForKey:@"equipmentTypeName"]
                                         image:nil
                                           tag:100+i
                                      userInfo:@{@"title":@"Menu"}
                                        menuId:[[dict objectForKey:@"equipmentType"]stringValue]]];
        
    }
    return oneArr;
}

-(NSMutableArray*)readTwoDataType:(NSString*)typeId{
    
    NSString *dataFilePath = [DocumentBasePath stringByAppendingFormat:@"/%@.plist", @"getEquipmentType"];
    NSArray * TypeArr=[[NSArray alloc]initWithContentsOfFile:dataFilePath];
    NSInteger i=0;
    NSMutableArray *oneArr=[[NSMutableArray alloc]init];//第1个下拉列表的数据
    NSMutableArray *twoArr=[[NSMutableArray alloc]init];//第2个下拉列表的数据
    //    NSMutableArray *threeArr=[[NSMutableArray alloc]init];//第3个下拉列表的数据
    
    for (NSDictionary* dict in TypeArr) {
       
        NSString *idTmp= [[dict objectForKey:@"equipmentType"]stringValue];
        if ([typeId isEqualToString:idTmp]) {//找到对应的id
            oneArr=[dict objectForKey:@"equipmentTypeData"];
            
            for (NSDictionary* dictTmp in oneArr) {
                i++;
                [twoArr addObject:[YCXMenuItem menuItem:[dictTmp objectForKey:@"equipmentFactoryName"]
                                                  image:nil
                                                    tag:100+i
                                               userInfo:@{@"title":@"Menu"}
                                                 menuId:[[dictTmp objectForKey:@"equipmentFactoryId"]stringValue]]];
                
            }
        }
        
    }
    return twoArr;
}

-(NSMutableArray*)readThreeDataType:(NSString*)typeId factoryId:(NSString*)fId{
    
    NSString *dataFilePath = [DocumentBasePath stringByAppendingFormat:@"/%@.plist", @"getEquipmentType"];
    NSArray * TypeArr=[[NSArray alloc]initWithContentsOfFile:dataFilePath];
    NSInteger i=0;
    NSMutableArray *oneArr=[[NSMutableArray alloc]init];//第1个下拉列表的数据
    NSMutableArray *twoArr=[[NSMutableArray alloc]init];//第2个下拉列表的数据
    NSMutableArray *threeArr=[[NSMutableArray alloc]init];//第3个下拉列表的数据
    
    for (NSDictionary* dict in TypeArr) {
        
        NSString *idTmp= [[dict objectForKey:@"equipmentType"]stringValue];
        if ([typeId isEqualToString:idTmp]) {//找到对应的设备类型id
            oneArr=[dict objectForKey:@"equipmentTypeData"];
            
            for (NSDictionary* dictTmp in oneArr) {
               
                 NSString *fidTmp= [[dictTmp objectForKey:@"equipmentFactoryId"]stringValue];
                 if ([fId isEqualToString:fidTmp]) {//找到对应的工厂id
                    twoArr=[dictTmp objectForKey:@"equipmentFactoryDate"];
                     for (NSDictionary* dictfct in twoArr) {
                         i++;
                         [threeArr addObject:[YCXMenuItem menuItem:[dictfct objectForKey:@"equipmentModelName"]
                                                           image:nil
                                                             tag:100+i
                                                        userInfo:@{@"title":@"Menu"}
                                                          menuId:[[dictfct objectForKey:@"equipmentModelId"]stringValue]]];
                     }
                 }
            }
        }
        
    }
    return threeArr;
}

-(NSMutableArray*)readFarmType{
    
    NSString *dataFilePath = [DocumentBasePath stringByAppendingFormat:@"/%@.plist", @"getFarmType"];
    NSArray * TypeArr=[[NSArray alloc]initWithContentsOfFile:dataFilePath];
    NSInteger i=0;
    NSMutableArray *oneArr=[[NSMutableArray alloc]init];//第1个下拉列表的数据
   
    
    for (NSDictionary* dict in TypeArr) {
        i++;
        [oneArr addObject:[YCXMenuItem menuItem:[dict objectForKey:@"typeName"]
                                          image:nil
                                            tag:100+i
                                       userInfo:@{@"title":@"Menu"}
                                         menuId:[[dict objectForKey:@"farmTypeId"]stringValue]]];
        
    }
    return oneArr;
}

@end
