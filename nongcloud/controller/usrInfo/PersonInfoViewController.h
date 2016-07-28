//
//  PersonInfoViewController.h
//  nongcloud
//
//  Created by tianan-apple on 16/7/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,strong)NSMutableArray *tableData;
@property(nonatomic,copy)NSString *userId;

@end
