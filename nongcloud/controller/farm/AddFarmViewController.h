//
//  AddFarmViewController.h
//  nongcloud
//
//  Created by tianan-apple on 16/7/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class stdTextField;
@interface AddFarmViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,strong)UITableView *SubTableView;
@property(nonatomic,strong)UITextField *FarmName;
@property(nonatomic,strong)stdTextField *Farm_type;
@property(nonatomic,strong)NSMutableArray *tableDataSource;//所有设备
@property(nonatomic,strong)NSMutableArray *SubTableDataSource;//某一个设备的所有子设备
//@property(nonatomic,strong)NSMutableArray *SubDevData;//所有子设备
@property(nonatomic,strong)NSMutableDictionary *SubDevDict;//所有子设备
@property(nonatomic,assign)NSInteger  pageindex;
@property(nonatomic,assign)NSInteger  subPageindex;
@property(nonatomic,assign)NSInteger  showType;//0新建农场  1修改农场
@property(nonatomic,strong)UIView *rightDevMenu;
@property(nonatomic,assign)CGFloat  rightOffset;

@property(nonatomic,strong)UITextField *DevName;//添加设备-设备名称
@property(nonatomic,strong)stdTextField *oneStd;//添加设备-设备类型
@property(nonatomic,strong)stdTextField *twoStd;//添加设备-厂家
@property(nonatomic,strong)stdTextField *threeStd;//添加设备-型号
@property(nonatomic,strong)UITextField *DevIdTxt;//添加设备-设备ID


@property(nonatomic,strong)UIView *rightSubDevMenu;//添加子设备菜单视图
@property(nonatomic,strong)stdTextField *oneSubStd;//添加子设备-设备厂家
@property(nonatomic,strong)stdTextField *twoSubStd;//添加子设备-型号
@property(nonatomic,strong)stdTextField *threeSubStd;//添加子设备-设备类型

@property(nonatomic,strong)UITextField *DevNameTxt;//添加子设备-设备名称
@property(nonatomic,strong)UITextField *DevAddrTxt;//添加子设备-地址
@property(nonatomic,strong)UITextField *SubDevIdTxt;//添加子设备-设备Id
@property(nonatomic,strong)UITextField *SubDevControl1;//添加子设备-控制通道1
@property(nonatomic,strong)UITextField *SubDevControl2;//添加子设备-控制通道2
@property(nonatomic,strong)UITextField *SubDevControl3;//添加子设备-控制通道3
@property(nonatomic,strong)UITextField *SubDevControl4;//添加子设备-控制通道4

@property(nonatomic,strong)UITextField *SubDevMaxValue;//添加子设备-最高阀值
@property(nonatomic,strong)UITextField *SubDevMinValue;//添加子设备-最低阀值
@property(nonatomic,assign)NSInteger deviceShowType;//设备编辑类型 0新建 1编辑
@property(nonatomic,assign)NSInteger subDeviceShowType;//设备编辑类型 0新建 1编辑
@property(nonatomic,assign)NSInteger selectedTableIndex;//设备编辑类型 0新建 1编辑

@end
