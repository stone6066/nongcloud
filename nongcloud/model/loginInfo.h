//
//  loginInfo.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface loginInfo : NSObject

@property(nonatomic,copy)NSString *userId;//用户id
@property(nonatomic,copy)NSString *userName;//用户昵称
@property(nonatomic,copy)NSString *userPhone;//手机
@property(nonatomic,copy)NSString *deleteState;//删除标志 0删除
@property(nonatomic,copy)NSString *nationId;//地区id
@property(nonatomic,copy)NSString *lastLongitude;//最近登陆经度
@property(nonatomic,copy)NSString *lastLatitude;//最近登陆纬度
@property(nonatomic,copy)NSString *createTime;//创建时间
@property(nonatomic,copy)NSString *orgCode;//组织机构代码
@property(nonatomic,copy)NSString *orgLevel;//组织机构级别
@property(nonatomic,copy)NSString *pushToken;//消息推送关键key
@property(nonatomic,copy)NSString *portrait;//头像路径


- (loginInfo *)asignInfoWithDict:(NSDictionary *)dict;
@end
