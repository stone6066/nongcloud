//
//  loginInfo.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "loginInfo.h"

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


@implementation loginInfo
- (loginInfo *)asignInfoWithDict:(NSDictionary *)dict{
    
    NSArray *dictArray = [dict objectForKey:@"data"];
    loginInfo *LGInfo=[[loginInfo alloc]init];
    
    for (NSDictionary *dicttmp in dictArray) {
        
    
        LGInfo.userId=[[dicttmp objectForKey:@"userId"]stringValue];
        LGInfo.userName=[dicttmp objectForKey:@"userName"];
        LGInfo.userPhone=[dicttmp objectForKey:@"userPhone"];

        LGInfo.deleteState=[[dicttmp objectForKey:@"deleteState"]stringValue];
        LGInfo.nationId=[[dicttmp objectForKey:@"nationId"]stringValue];
        LGInfo.nationId=[dicttmp objectForKey:@"nationId"];
        LGInfo.lastLongitude=[dicttmp objectForKey:@"lastLongitude"];
        LGInfo.lastLatitude=[dicttmp objectForKey:@"lastLatitude"];
        LGInfo.createTime=[dicttmp objectForKey:@"createTime"];
        LGInfo.orgCode=[dicttmp objectForKey:@"orgCode"];
        LGInfo.orgLevel=[dicttmp objectForKey:@"orgLevel"];
        LGInfo.pushToken=[dicttmp objectForKey:@"pushToken"];
        LGInfo.portrait=[dicttmp objectForKey:@"portrait"];
    
    }
    //NSLog(@"ownerId:%@",LGInfo.ownerId);
    return LGInfo;
    
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    return [objDateformat stringFromDate: date];
}
@end
