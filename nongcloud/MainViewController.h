//
//  MainViewController.h
//  nongcloud
//
//  Created by tianan-apple on 16/7/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic)NSMutableArray *dataSource;
@property (nonatomic,strong)UICollectionView *collectionView;
@end
