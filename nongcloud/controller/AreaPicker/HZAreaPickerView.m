//
//  HZAreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "HZAreaPickerView.h"
#import <QuartzCore/QuartzCore.h>

#define kDuration 0.3

@interface HZAreaPickerView ()
{
    NSArray *provinces, *cities, *areas;
}

@end

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize datasource=_datasource;
@synthesize pickerStyle=_pickerStyle;
@synthesize locate=_locate;

- (void)dealloc
{
    self.datasource = nil;
    self.delegate = nil;
//    [_locate release];
//    [_locatePicker release];
//    [provinces release];
//    [super dealloc];
}

-(HZLocation *)locate
{
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}
- (IBAction)cancalClick:(id)sender {
    //[self.delegate pickerDidChaneStatus:nil];
    [self cancelPicker];
}
- (IBAction)okClick:(id)sender {
    [self.delegate pickerDidChaneStatus:self];
    [self cancelPicker];
}




- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle withDelegate:(id <HZAreaPickerDelegate>)delegate andDatasource:(id <HZAreaPickerDatasource>)datasource
{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"HZAreaPickerView" owner:self options:nil] objectAtIndex:0] ;
    if (self) {
        self.delegate = delegate;
        self.pickerStyle = pickerStyle;
        self.datasource = datasource;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        [self.okBtn setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-100, 8, 46, 30)];
        provinces = [self.datasource areaPickerData:self] ;
        cities = [[provinces objectAtIndex:0] objectForKey:@"provinceData"];//cities
        self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"province"];//state
        self.locate.stateid = [[provinces objectAtIndex:0] objectForKey:@"nationId"];
        if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            self.locate.cityid = [[cities objectAtIndex:0] objectForKey:@"nationId"];
            areas = [[cities objectAtIndex:0] objectForKey:@"cityData"];//areas
            if (areas.count > 0) {
                self.locate.district = [[areas objectAtIndex:0]objectForKey:@"district"];
                self.locate.districtid = [[areas objectAtIndex:0]objectForKey:@"nationId"];
            } else{
                self.locate.district = @"";
                self.locate.districtid = @"";
            }
            
        } else{
            self.locate.city = [cities objectAtIndex:0];
        }
    }
        
    return self;
    
}



#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        return 3;
    } else{
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
                return [areas count];
                break;
            }
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"province"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"city"];
                break;
            case 2:
                if ([areas count] > 0) {
                    return [[areas objectAtIndex:row] objectForKey:@"district"];
                    //return [areas objectAtIndex:row];
                    break;
                }
            default:
                return  @"";
                break;
        }
    } else{
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"province"];
                break;
            case 1:
                return [cities objectAtIndex:row];
                break;
            default:
                return @"";
                break;
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"provinceData"];//cities
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                areas = [[cities objectAtIndex:0] objectForKey:@"cityData"];//areas
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"province"];
                self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                
                self.locate.stateid = [[provinces objectAtIndex:row] objectForKey:@"nationId"];
                self.locate.cityid = [[cities objectAtIndex:0] objectForKey:@"nationId"];
                
                if ([areas count] > 0) {
                    self.locate.district = [[areas objectAtIndex:0] objectForKey:@"district"];
                    self.locate.districtid = [[areas objectAtIndex:0] objectForKey:@"nationId"];
                } else{
                    self.locate.district = @"";
                    self.locate.districtid = @"";
                }
                break;
            case 1:
                areas = [[cities objectAtIndex:row] objectForKey:@"cityData"];//areas
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                self.locate.cityid = [[cities objectAtIndex:row] objectForKey:@"nationId"];
                if ([areas count] > 0) {
                    self.locate.district = [[areas objectAtIndex:0] objectForKey:@"district"];
                    self.locate.districtid = [[areas objectAtIndex:0] objectForKey:@"nationId"];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 2:
                if ([areas count] > 0) {
                    self.locate.district = [[areas objectAtIndex:row] objectForKey:@"district"];
                    self.locate.districtid = [[areas objectAtIndex:row] objectForKey:@"nationId"];
                } else{
                    self.locate.districtid = @"";
                    self.locate.district = @"";
                }
                break;
            default:
                break;
        }
    } else{
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"provinceData"];//cities
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"province"];
                self.locate.city = [cities objectAtIndex:0];
                break;
            case 1:
                self.locate.city = [cities objectAtIndex:row];
                break;
            default:
                break;
        }
    }
    
//    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
//        [self.delegate pickerDidChaneStatus:self];
//    }

}


#pragma mark - animation

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, [UIScreen mainScreen].bounds.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}

@end
