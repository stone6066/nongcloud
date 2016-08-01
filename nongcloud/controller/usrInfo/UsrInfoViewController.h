//
//  UsrInfoViewController.h
//  nongcloud
//
//  Created by tianan-apple on 16/7/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StdUploadFileApi.h"

@interface UsrInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,uploadProgressDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,strong)NSArray *tableData;
@property(nonatomic,copy)NSString *imgFullpath;
@property(nonatomic,assign)BOOL isFullScreen;
@property(nonatomic,strong)UIImageView *iconImg;
@property(nonatomic,strong)UIImageView *iconImgNew;
@property(nonatomic,strong)UIProgressView *progressView;
@end
