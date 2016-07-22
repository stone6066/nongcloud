//
//  MainCollectionViewCell.h
//  nongcloud
//
//  Created by tianan-apple on 16/7/15.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class farmModel;

@interface MainCollectionViewCell : UICollectionViewCell
@property(strong,nonatomic) UIImageView *farmImg;
@property(strong,nonatomic) UILabel *farmName;
@property(nonatomic,strong)UIButton *clickButton;
@property(nonatomic,copy)NSString *cellId;

-(void)showUiMainCell:(farmModel*)NModel;
@end
