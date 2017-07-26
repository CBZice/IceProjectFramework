//
//  EPGetAddress.m
//  ExpressPay
//
//  Created by shoujizhifu on 2017/7/14.
//  Copyright © 2017年 hairong. All rights reserved.
//

#import "EPGetAddress.h"
#import <MapKit/MapKit.h>

#define kCLMessage_AppDenied @"请到设置->隐私->定位服务中开启[运通管家]定位服务，否则不能进行定位"

@interface EPGetAddress ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic,strong)MKMapView *mapView;

@property (nonatomic, copy) getAddressBlock block;



@end

@implementation EPGetAddress

static EPGetAddress *address1;

+ (instancetype)shareAddressBlock:(getAddressBlock)address {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        address1 = [[EPGetAddress alloc] init];
    });
    [address1 getAddress:address];
    return address1;
}

-(void)getAddress:(getAddressBlock)address {
    _block = address;
    [self initLocation];
}

- (void)initLocation{
    self.locationManager=[[CLLocationManager alloc]init];;
    
    //判断当前设备定位服务是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"设备尚未打开定位服务");
    }
    
    //判断当前设备版本大于iOS8以后的话执行里面的方法
    if ([UIDevice currentDevice].systemVersion.floatValue >=8.0) {
        //持续授权
        // [locationManager requestAlwaysAuthorization];
        //当用户使用的时候授权
        [self.locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        NSString *message = @"您的手机目前未开启定位服务，如欲开启定位服务，请至设定开启定位服务功能";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
    }
    self.mapView.delegate=self;
    [self initMapView];
}
#pragma mark - 初始化
- (void)initMapView
{
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(MAXFLOAT,MAXFLOAT, WIDTH, 300)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
//    _mapView.hidden = YES;
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.lastObject;
    [keyWindow addSubview:_mapView];
}

/**
 *  跟踪到用户位置时会调用该方法
 *  @param mapView   地图
 *  @param userLocation 大头针模型
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%@", userLocation.location);
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    
    //    latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    //    longitude= [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    CLLocation *c = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    //创建位置 ￼反向地理编码
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    
    [revGeo reverseGeocodeLocation:c completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error||placemarks.count==0) {
        } else {//编码成功
            //显示最前面的地标信息
            CLPlacemark *firstPlacemark = [placemarks firstObject];
            //            _updateEquipView.locationLabel.text = firstPlacemark.name;
            //            commercialAdress = firstPlacemark.name;
            if (_block) {
                _block(firstPlacemark.name, coordinate.longitude, coordinate.latitude);
            }
        }
    }];
    [self.locationManager stopUpdatingLocation];
    _mapView.delegate = nil;
    _mapView = nil;
}
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    _block(nil,0,0);
}

// 获取当前主控制器
- (UIViewController *)viewController
{
    for (UIView* next = [_mapView superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
