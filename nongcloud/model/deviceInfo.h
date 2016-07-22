//
//  deviceInfo.h
//  nongcloud
//
//  Created by tianan-apple on 16/7/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface deviceInfo : NSObject
@property(nonatomic,copy)NSString *devName;//设备名称
@property(nonatomic,copy)NSString *devType;//设备类型
@property(nonatomic,copy)NSString *devTypeId;//设备类型ID
@property(nonatomic,copy)NSString *devFactory;//厂家
@property(nonatomic,copy)NSString *devFactoryId;//厂家
@property(nonatomic,copy)NSString *devVersion;//型号
@property(nonatomic,copy)NSString *devVersionId;//型号
@property(nonatomic,copy)NSString *devNo;//设备ID

@property(nonatomic,copy)NSString *devAddr;//设备地址

@property(nonatomic,copy)NSString *controlPip1;//控制通道1
@property(nonatomic,copy)NSString *controlPip2;//控制通道2
@property(nonatomic,copy)NSString *controlPip3;//控制通道3
@property(nonatomic,copy)NSString *controlPip4;//控制通道4

@property(nonatomic,copy)NSString *maxLimit;//上限值
@property(nonatomic,copy)NSString *minLimit;//下限值

@end
