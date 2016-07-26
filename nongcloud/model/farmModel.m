//
//  farmModel.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "farmModel.h"


//"farmId":5,
//"userId":1,
//"farmName":"新建农场名字",
//"farmAddress":null,
//"farmNation":null,
//"createTime":1468984537000,
//"deleteState":"1",
//"farmTypeId":1

@implementation farmModel
- (NSMutableArray *)asignInfoWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"data"];
    farmModel *FmInfo=[[farmModel alloc]init];
    
    for (NSDictionary *dicttmp in dictArray) {
        
        FmInfo.farmImg=@"farmImg";
        FmInfo.farmId=[[dicttmp objectForKey:@"farmId"]stringValue];
        FmInfo.userId=[[dicttmp objectForKey:@"userId"]stringValue];
        FmInfo.farmName=[dicttmp objectForKey:@"farmName"];
        
        FmInfo.farmAddress=[dicttmp objectForKey:@"farmAddress"];
        FmInfo.farmNation=[[dicttmp objectForKey:@"farmNation"]stringValue];
        
        FmInfo.createTime=[self stdTimeToStr:[[dict objectForKey:@"createTime"]stringValue]];
        FmInfo.deleteState=[dicttmp objectForKey:@"deleteState"];
        FmInfo.farmTypeId=[[dicttmp objectForKey:@"farmTypeId"]stringValue];
       
        [arr addObject:FmInfo];
    }
    //NSLog(@"ownerId:%@",LGInfo.ownerId);
    return arr;
    
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [objDateformat stringFromDate: date];
}

@end
