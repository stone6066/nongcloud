//
//  ListTableViewCell.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ListTableViewCell.h"
#import "PublicDefine.h"
#import "farmModel.h"
#import "deviceInfo.h"
#import "listCellModel.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat CellWidth= self.contentView.frame.size.width-4;
        
        _titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(30,0,CellWidth-30-55,35)];
        _titleLbl.font=[UIFont systemFontOfSize:13];
        [self addSubview:_titleLbl];
        
        
    
        _timeLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-150,2,110,35)];
        _timeLbl.font=[UIFont systemFontOfSize:10];

        [self addSubview:_timeLbl];
        
        _titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(8,10,15,15)];

        [self addSubview:_titleImage];

        
    }
    return self;
}

-(void)showUiFarmCell:(farmModel*)NModel image:(NSString*)imgName{
    
    _titleLbl.text=NModel.farmName;
    _titleImage.image=[UIImage imageNamed:imgName];
    _cellId=NModel.farmId;
    
}

-(void)showUiDevCell:(deviceInfo*)NModel image:(NSString*)imgName{
    
    _titleLbl.text=NModel.devName;
    _titleImage.image=[UIImage imageNamed:imgName];
    
}

-(void)showUiUsrCell:(listCellModel*)NModel{
    
    _titleLbl.text=NModel.cellName;
    _titleImage.image=[UIImage imageNamed:NModel.cellImg];
    _cellId=NModel.cellId;
    
}

-(farmModel*)praseFarmData:(ListTableViewCell *)LVC{
    farmModel *RTM=[[farmModel alloc]init];
    RTM.farmId=LVC.cellId;
    return RTM;
}

@end
