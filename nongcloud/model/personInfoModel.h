//
//  personInfoModel.h
//  nongcloud
//
//  Created by tianan-apple on 16/7/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

//"userId":1,
//"userName":"超级管理员",
//"userPhone":"13711111111",
//"userLogin":"admin",
//"userPassword":"0b4e7a0e5fe84ad35fb5f95b9ceeac79",
//"deleteState":1,
//"nationId":1,
//"lastLongitude":"1121212.11",
//"lastLatitude":"121312.33",
//"createTime":null,
//"orgCode":"100",
//"orgLevel":1,
//"pushToken":"0",
//"portrait":null

@interface personInfoModel : NSObject
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *userPhone;
@property(nonatomic,copy)NSString *lastLongitude;
@property(nonatomic,copy)NSString *lastLatitude;

@end
