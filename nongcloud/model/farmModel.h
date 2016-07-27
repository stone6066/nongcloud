//
//  farmModel.h
//  nongcloud
//
//  Created by tianan-apple on 16/7/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface farmModel : NSObject
@property(nonatomic,copy)NSString *farmName;//农场名
@property(nonatomic,copy)NSString *farmId;//农场id
@property(nonatomic,copy)NSString *farmImg;//农场图片
@property(nonatomic,copy)NSString *farmAddress;//农场地址
@property(nonatomic,copy)NSString *farmNation;//农场地区
@property(nonatomic,copy)NSString *createTime;//农场创建时间
@property(nonatomic,copy)NSString *deleteState;//农场删除状态 0删除 1正常
@property(nonatomic,copy)NSString *farmTypeId;//农场类型 蔬菜 水果等
@property(nonatomic,copy)NSString *userId;//农场类型 蔬菜 水果等
@property(nonatomic,copy)NSString *farmTypeName;//农场类型 蔬菜 水果等
- (NSMutableArray *)asignInfoWithDict:(NSDictionary *)dict;

@end
