//
//  loginInfo.h
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface loginInfo : NSObject
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *positionId;
@property(nonatomic,copy)NSString *levelId;
@property(nonatomic,copy)NSString *userName;//用户姓名
@property(nonatomic,copy)NSString *userPhone;//用户电话
@property(nonatomic,copy)NSString *createTime;//创建时间
@property(nonatomic,copy)NSString *lastLoginIp;
@property(nonatomic,copy)NSString *lastLoginTime;//最近登陆时间
@property(nonatomic,copy)NSString *userStatus;
@property(nonatomic,copy)NSString *deleteStatus;//删除状态
@property(nonatomic,copy)NSString *communityId;//小区id
@property(nonatomic,copy)NSString *lockNum;
@property(nonatomic,copy)NSString *lockTime;
@property(nonatomic,copy)NSString *lockIp;
@property(nonatomic,copy)NSString *communityName;//小区名
- (loginInfo *)asignInfoWithDict:(NSDictionary *)dict;
@end
