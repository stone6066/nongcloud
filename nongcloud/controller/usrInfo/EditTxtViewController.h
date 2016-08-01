//
//  EditTxtViewController.h
//  nongcloud
//
//  Created by tianan-apple on 16/8/1.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTxtViewController : UIViewController
@property(nonatomic,strong)UITextField *txtField;
@property(nonatomic,copy)NSString *viewTitle;
@property (nonatomic, copy) void (^EditTxtBlock) (EditTxtViewController *,NSString *);
@end
