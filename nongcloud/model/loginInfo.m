//
//  loginInfo.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "loginInfo.h"

//"userId":68,
//"positionId":2,
//"levelId":1,
//"userName":"测试用户",
//"userPhone":"15111111111",
//"createTime":1467011137000,
//"lastLoginIp":"127.0.0.1",
//"lastLoginTime":1467011177000,
//"userStatus":1,
//"deleteStatus":0,
//"createuserId":2,
//"communityId":6,
//"lockNum":0,
//"lockTime":1467011177000,
//"lockIp":null,
//"communityName":"罗马公元"


@implementation loginInfo
- (loginInfo *)asignInfoWithDict:(NSDictionary *)dict{
    
    NSArray *dictArray = [dict objectForKey:@"data"];
    loginInfo *LGInfo=[[loginInfo alloc]init];
    
    for (NSDictionary *dicttmp in dictArray) {
        
    
    LGInfo.userId=[[dicttmp objectForKey:@"userId"]stringValue];
    LGInfo.positionId=[[dicttmp objectForKey:@"positionId"]stringValue];
    LGInfo.levelId=[[dicttmp objectForKey:@"levelId"]stringValue];
    LGInfo.userName=[dicttmp objectForKey:@"userName"];
    LGInfo.userPhone=[dicttmp objectForKey:@"userPhone"];
    LGInfo.communityId=[[dicttmp objectForKey:@"communityId"]stringValue];
    LGInfo.communityName=[dicttmp objectForKey:@"communityName"];
    
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
