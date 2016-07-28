//
//  ListTableViewCell.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class farmModel,deviceInfo,listCellModel ;

@interface ListTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLbl;
@property(nonatomic,strong)UILabel *timeLbl;
@property(nonatomic,strong)UIImageView *titleImage;
@property(nonatomic,copy)NSString *cellId;
@property(nonatomic,copy)NSString *noticeContent;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *myType;

-(void)showUiFarmCell:(farmModel*)NModel image:(NSString*)imgName;
-(void)showUiDevCell:(deviceInfo*)NModel image:(NSString*)imgName;
-(farmModel*)praseFarmData:(ListTableViewCell *)LVC;
-(void)showUiUsrCell:(listCellModel*)NModel;
@end
