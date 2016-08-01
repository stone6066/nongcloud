//
//  UsrInfoViewController.m
//  nongcloud
//
//  Created by tianan-apple on 16/7/28.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "UsrInfoViewController.h"
#import "PublicDefine.h"
#import "ListTableViewCell.h"
#import "listCellModel.h"
#import "UIImageView+WebCache.h"
#import "PersonInfoViewController.h"
#import "AlertPswViewController.h"


@interface UsrInfoViewController ()

@end

@implementation UsrInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _iconImg=[[UIImageView alloc]init];
    [self loadTopNav];
    [self loadTopVc];
    listCellModel *LM1=[[listCellModel alloc]init];
    LM1.cellName=@"个人资料";
    LM1.cellImg=@"person";
    
    listCellModel *LM2=[[listCellModel alloc]init];
    LM2.cellName=@"密码服务";
    LM2.cellImg=@"psw";

    
    listCellModel *LM3=[[listCellModel alloc]init];
    LM3.cellName=@"设置";
    LM3.cellImg=@"setting";

    
    _tableData=[[NSArray alloc]initWithObjects:LM1,LM2,LM3, nil];
    [self loadTableView];
    [_TableView reloadData];
    [self getPerinfoFromSvr:ApplicationDelegate.myLoginInfo.userId];//获取头像
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTopNav{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 18, fDeviceWidth, 40)];
    topLbl.text=@"我的账户";
    [topLbl setTextAlignment:NSTextAlignmentCenter];
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    
    UIView * topStaus=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopStausHight)];
    topStaus.backgroundColor=stausBarColor;
    [TopView addSubview:topStaus];
    
    
    [self.view addSubview:TopView];
}

-(void)clickleftbtn
{
    [self.navigationController popViewControllerAnimated:NO];
}


static NSString * const MarketCellId = @"UsrTableCell";
-(void)loadTableView{
    CGFloat devH= fDeviceHeight*0.618;
    
    UIView *bottomVc=[[UIView alloc]initWithFrame:CGRectMake(0, fDeviceHeight*(1-0.618), fDeviceWidth, devH)];
  
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, fDeviceWidth, 130)];
    self.TableView.tag=0;
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    self.TableView.tableFooterView = [[UIView alloc]init];
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:MarketCellId];
    
    [bottomVc addSubview:self.TableView];
    
    
    UIImageView *logobtnImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 190, fDeviceWidth-20, 50)];
    logobtnImg.image=[UIImage imageNamed:@"logout"];
    [bottomVc addSubview:logobtnImg];
    
    UIButton *LoginOutBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 186, fDeviceWidth-20, 50)];
    
    [LoginOutBtn addTarget:self action:@selector(clicklogoutbtn) forControlEvents:UIControlEventTouchUpInside];
    
    [LoginOutBtn setTitle:@"退出登录"forState:UIControlStateNormal];// 添加文字
    [bottomVc addSubview:LoginOutBtn];
    [self.view addSubview: bottomVc];
}
-(void)clicklogoutbtn{
    ApplicationDelegate.isLogin=NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
}
-(void)loadTopVc{
    CGFloat devH= fDeviceHeight*(1-0.618)-TopSeachHigh;
    UIView *topVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, devH)];
    topVc.backgroundColor=topSearchBgdColor;
    
    
    _iconImgNew=[[UIImageView alloc]initWithFrame:CGRectMake((fDeviceWidth-(devH-20))/2, 10, devH-20, devH-20)];
    
    _iconImgNew.image=[UIImage imageNamed:@"name"];
    //[_iconImg sd_setImageWithURL:[NSURL URLWithString:@"http://img1.cache.netease.com/catchpic/F/FA/FAE5092DBC8408FD891B53D4A92AE5DA.jpg"]];
    
    _iconImgNew.layer.masksToBounds = YES;
    _iconImgNew.layer.cornerRadius = CGRectGetHeight(_iconImgNew.bounds)/2;
    //    注意这里的ImageView 的宽和高都要相等
    //    layer.cornerRadiu 设置的是圆角的半径
    //    属性border 添加一个镶边
    _iconImgNew.layer.borderWidth = 0.5f;
    _iconImgNew.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [topVc addSubview:_iconImgNew];

    UIButton *iconBtn=[[UIButton alloc]initWithFrame:CGRectMake((fDeviceWidth-(devH-20))/2, 10, devH-20, devH-20)];
    [iconBtn addTarget:self action:@selector(iconbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topVc addSubview:iconBtn];
    [self.view addSubview:topVc];
}

-(void)iconbtnClick{
    [self btnActionForEditPortrait:nil];
}
#pragma mark table delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MarketCellId forIndexPath:indexPath];
    //
    //    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    listCellModel *LM=_tableData[indexPath.item];
    [cell showUiUsrCell:LM];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.item) {
        case 0:
            [self pushPersonInfo];
            break;
        case 1:
            [self pushAlertPswView];
            break;
        default:
            break;
    }
   
}
-(void)pushPersonInfo{
    PersonInfoViewController *Pvc=[[PersonInfoViewController alloc]init];
    [Pvc setUserId:ApplicationDelegate.myLoginInfo.userId];
    Pvc.view.backgroundColor=collectionBgdColor;
    [self.navigationController pushViewController:Pvc animated:YES];
}
-(void)pushAlertPswView{
    AlertPswViewController *Pvc=[[AlertPswViewController alloc]init];
    Pvc.view.backgroundColor=collectionBgdColor;
    [self.navigationController pushViewController:Pvc animated:YES];
}


//从相册中选取图片或拍照
- (void)btnActionForEditPortrait:(id) sender {
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}
#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}

-(NSData *)makeMyUpImg:(UIImage*)valueToSend{
    
    UIImage* tmpImage = (UIImage*)valueToSend;
    UIImage* contextedImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    if ([valueToSend isKindOfClass:[UIImage class]]) {
        
        if (tmpImage.imageOrientation == UIImageOrientationUp) {
            
            contextedImage = tmpImage;
            
        }
        
        else{
            
            switch (tmpImage.imageOrientation ) {
                    
                case UIImageOrientationDown:
                    
                case UIImageOrientationDownMirrored:
                    
                    transform = CGAffineTransformTranslate(transform, tmpImage.size.width, tmpImage.size.height);
                    
                    transform = CGAffineTransformRotate(transform, M_PI);
                    
                    break;
                    
                case UIImageOrientationLeft:
                    
                case UIImageOrientationLeftMirrored:
                    
                    transform = CGAffineTransformTranslate(transform, tmpImage.size.width, 0);
                    
                    transform = CGAffineTransformRotate(transform, M_PI_2);
                    
                    break;
                    
                case UIImageOrientationRight:
                    
                case UIImageOrientationRightMirrored:
                    
                    transform = CGAffineTransformTranslate(transform, 0,tmpImage.size.height);
                    
                    transform = CGAffineTransformRotate(transform, -M_PI_2);
                    
                    break;
                    
                default:
                    
                    break;
                    
            }
            
            
            switch (tmpImage.imageOrientation) {
                    
                case UIImageOrientationUpMirrored:
                    
                case UIImageOrientationDownMirrored:
                    
                    transform = CGAffineTransformTranslate(transform, tmpImage.size.width, 0);
                    
                    transform = CGAffineTransformScale(transform, -1, 1);
                    
                    break;
                    
                case UIImageOrientationLeftMirrored:
                    
                case UIImageOrientationRightMirrored:
                    
                    transform = CGAffineTransformTranslate(transform, tmpImage.size.height, 0);
                    
                    transform = CGAffineTransformScale(transform, -1, 1);
                    
                    break;
                    
                default:
                    
                    break;
                    
            }
            
            CGContextRef ctx = CGBitmapContextCreate(NULL, tmpImage.size.width, tmpImage.size.height, CGImageGetBitsPerComponent(tmpImage.CGImage), 0, CGImageGetColorSpace(tmpImage.CGImage), CGImageGetBitmapInfo(tmpImage.CGImage));
            
            
            CGContextConcatCTM(ctx, transform);
            
            
            
            switch (tmpImage.imageOrientation) {
                    
                case UIImageOrientationLeft:
                    
                case UIImageOrientationLeftMirrored:
                    
                case UIImageOrientationRight:
                    
                case UIImageOrientationRightMirrored:
                    
                    CGContextDrawImage(ctx, CGRectMake(0, 0, tmpImage.size.height,tmpImage.size.width), tmpImage.CGImage);
                    
                    break;
                    
                default:
                    
                    CGContextDrawImage(ctx, CGRectMake(0, 0, tmpImage.size.width, tmpImage.size.height), tmpImage.CGImage);
                    
                    break;
                    
            }
            
            CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
            
            contextedImage = [UIImage imageWithCGImage:cgimg];
            
            CGContextRelease(ctx);
            
            CGImageRelease(cgimg);
            
            
        }
    }
    NSData *data = UIImageJPEGRepresentation(contextedImage, 0.1);
    return data;
}
#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{

    NSData *imageData=[self makeMyUpImg:currentImage];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    _imgFullpath=fullPath;
    NSLog(@"fullPath:%@",fullPath);
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    _isFullScreen = NO;
    
    [self.iconImg setImage:savedImage];
    [self imgUpload];
    self.iconImg.tag = 100;
    [_iconImgNew setImage:savedImage];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)loadProgress{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(fDeviceWidth/2-75, 180, 150, 20)];
    _progressView.transform = CGAffineTransformMakeScale(1.0f,2.0f);
    [_progressView setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    [view addSubview:_progressView];
    
    [self.view addSubview:view];
    
}

-(void)imgUpload{
    NSString *Path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    StdUploadFileApi *upRequst=[[StdUploadFileApi alloc]init];
    upRequst.delegate=self;
    [self loadProgress];
    if (_iconImg.image) {
        NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"Former/login/upImg?userId=",ApplicationDelegate.myLoginInfo.userId];
        [upRequst stdUploadFileWithProgress:urlstr filePath:Path fileName:@"currentImage.png" mimeType:@"image/jpeg" pragram:nil];
        
    }

}


#pragma mark StdUploadFileApi delegate
-(void)stdUploadProgress:(float)progress{
    [_progressView setProgress:progress];
    if (progress>0.99) {
        UIView *view = (UIView*)[self.view viewWithTag:108];
        [view removeFromSuperview];
    }
    
    NSLog(@"上传进度：%f",progress);
}
-(void)stdUploadError:(NSError *)err
{
    //NSLog(@"%@",err);
}

-(void)stdUploadSucc:(NSURLResponse *)Response responseObject:(id)respObject{
     NSLog(@"stdUploadSucc：%@----%@",Response,respObject);
}


-(void)getPerinfoFromSvr:(NSString*)usrid{

    NSString *urlstr=[NSString stringWithFormat:@"%@%@%@",BaseUrl,@"Former/login/userInfo?userId=",usrid];
    NSLog(@"getPerinfoSrvFuc:%@",urlstr);
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [ApplicationDelegate.httpManager POST:urlstr
                               parameters:nil
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          //NSLog(@"数据：%@",jsonDic);
                                          NSString *suc=[jsonDic objectForKey:@"msg"];
                                          
                                          //
                                          if ([suc isEqualToString:@"success"]) {
                                              //成功
                                              NSArray *usrArr=[jsonDic objectForKey:@"data"];
                                              for (NSDictionary *dicttmp in usrArr) {
                                                  
                                                  NSString *imgUrl=[dicttmp objectForKey:@"portrait"];
                                                  imgUrl=[NSString stringWithFormat:@"%@%@",BaseUrl,imgUrl];
                                                  NSLog(@"imgUrl:%@",imgUrl);
                                                  [_iconImgNew sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
   
                                              }

                                        
                                              
                                          } else {
                                              //失败
                                              [SVProgressHUD showErrorWithStatus:suc];
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                          
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      NSLog(@"error:%@",error);
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                  }];
    
}
@end
