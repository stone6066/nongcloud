//
//  deviceInfo.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "deviceInfo.h"

@implementation deviceInfo

- (NSMutableDictionary *)asignInfoWithDict:(NSDictionary *)dict{
    NSMutableDictionary * DictRt=[[NSMutableDictionary alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    NSMutableArray *farmArr=[[NSMutableArray alloc]init];//存放农场名 id farmTypeId
    NSMutableArray *devArr=[[NSMutableArray alloc]init];//存放设备信息
    NSMutableDictionary *subDevDict=[[NSMutableDictionary alloc]init];//存放所有的子设备 key＝devId
    
    for (NSDictionary *dicttmp in dictArray) {
        farmModel *FmInfo=[[farmModel alloc]init];
        
        FmInfo.farmId=[[dicttmp objectForKey:@"farmId"]stringValue];
        FmInfo.farmName=[dicttmp objectForKey:@"farmName"];
        FmInfo.farmTypeId=[[dicttmp objectForKey:@"farmTypeId"]stringValue];
        FmInfo.farmTypeName=[dicttmp objectForKey:@"typeName"];
        [farmArr addObject:FmInfo];
        NSArray *dictDevice = [dicttmp objectForKey:@"farmObject"];
        for (NSDictionary* dictDev in dictDevice ) {//设备
            deviceInfo *dev=[[deviceInfo alloc]init];
            dev.devId =[[dictDev objectForKey:@"equipmentId"]stringValue];
            dev.devName=[dictDev objectForKey:@"equipmentName"];
            [devArr addObject:dev];
            NSArray *dictSubDevice=[dictDev objectForKey:@"equipSub"];
             NSMutableArray *subDevArr=[[NSMutableArray alloc]init];//存放一个设备的 子设备
            for (NSDictionary* dictSubDev in dictSubDevice ){//子设备
                deviceInfo *devSub=[[deviceInfo alloc]init];
                devSub.devId =[[dictSubDev objectForKey:@"equipmentId"]stringValue];
                devSub.devName=[dictSubDev objectForKey:@"equipmentName"];
                [subDevArr addObject:devSub];
            }
            [subDevDict setObject:subDevArr forKey:dev.devId];//把一个设备的所有子设备存到字典中，key=(设备的)devId
        }
    }
    [DictRt setObject:farmArr forKey:@"farminfo"];
    [DictRt setObject:devArr forKey:@"devinfo"];
    [DictRt setObject:subDevDict forKey:@"subdevinfo"];
    
    return DictRt;
}
@end
