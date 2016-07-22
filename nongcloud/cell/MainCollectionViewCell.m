//
//  MainCollectionViewCell.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MainCollectionViewCell.h"
#import "PublicDefine.h"
#import "farmModel.h"

@implementation MainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        //这里需要初始化ImageView；
        CGFloat imgWidth=self.frame.size.width-40;
        CGFloat imgHeigh=self.frame.size.height-50;
        self.farmImg = [[UIImageView alloc] initWithFrame:CGRectMake(20,15,imgWidth,imgHeigh)];
        [self.farmImg setUserInteractionEnabled:true];
        
        self.farmName = [[UILabel alloc] initWithFrame:CGRectMake(20, self.frame.size.height-20, imgWidth, 20)];
        self.farmName.textAlignment = NSTextAlignmentCenter;
        self.farmName.text = @"111";
        [self.farmName setTextColor:whiteTxtColor];
        [self.farmName setFont:[UIFont systemFontOfSize:12]];
        self.farmName.backgroundColor=cellNameColor;
        //设置边缘弯曲角度
        self.farmName.layer.cornerRadius = 10;
        
        self.farmName.clipsToBounds = YES;//（iOS7以后需要设置）
        
//        self.clickButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
//        
//        //先设置不可见；
//        [self.deleteButton setHidden:true];
        
        //self.layer.borderWidth = 0.5;
        
        [self addSubview:self.farmImg];
        [self addSubview:self.farmName];
        //self.backgroundColor=[UIColor yellowColor];
        //[self addSubview:self.deleteButton];
    }
    return self;
}
-(void)showUiMainCell:(farmModel*)NModel{
    _farmName.text=NModel.farmName;
    _farmImg.image=[UIImage imageNamed:NModel.farmImg];
    _cellId=NModel.farmId;
}
@end
