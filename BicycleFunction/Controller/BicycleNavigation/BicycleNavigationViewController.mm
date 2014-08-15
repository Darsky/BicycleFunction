//
//  BicycleNavigationViewController.m
//  BicycleFunction
//
//  Created by Darsky on 7/22/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import "BicycleNavigationViewController.h"
#import "SVProgressHUD.h"
#import "AmbitusSearchView.h"

@interface BicycleNavigationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,BMKRouteSearchDelegate,BMKOfflineMapDelegate,AmbitusSearchViewDelegate>
{
    BOOL _setCenter;
    CLLocationCoordinate2D _userCoordinate;
    BMKUserLocation *_userLocation;
    AmbitusSearchView *_ambSearchView;
    BOOL _Offline;
}

@end

@implementation BicycleNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(70, 20,[UIScreen mainScreen].bounds.size.height-140, [UIScreen mainScreen].bounds.size.width-50)];
//    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(20,0, [UIScreen mainScreen].bounds.size.width-50, [UIScreen mainScreen].bounds.size.height)];
//    _mapView.transform = CGAffineTransformMakeRotation(M_PI);
    _setCenter = YES;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.isSelectedAnnotationViewFront = YES;
    [_mapView setZoomLevel:17];
    [self.view addSubview:_mapView];
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _searcher =[[BMKGeoCodeSearch alloc] init];
    _searcher.delegate = self;
    
    _routeSearch =[[BMKRouteSearch alloc] init];
    _routeSearch.delegate = self;
    
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    backbutton.frame = CGRectMake(10, _mapView.frame.size.height+_mapView.frame.origin.y, 28, 28);
    backbutton.backgroundColor = [UIColor grayColor];
    [backbutton setTitle:@"x" forState:UIControlStateNormal];
    [backbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backbutton.layer.masksToBounds = YES;
    backbutton.layer.cornerRadius = 28/2;
    [backbutton addTarget:self action:@selector(backToMainViewController) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:backbutton];
    
    UIButton *ambitusSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ambitusSearchButton.frame = CGRectMake(self.view.bounds.size.height-70, _mapView.frame.size.height/2, 70, 80);
    ambitusSearchButton.backgroundColor = [UIColor grayColor];
    [ambitusSearchButton setTitle:@"周边" forState:UIControlStateNormal];
    [ambitusSearchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [ambitusSearchButton addTarget:self action:@selector(showOrHideAmbitusSearchView) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:ambitusSearchButton];

    _ambSearchView = [[AmbitusSearchView alloc] initWithFrame:CGRectMake(30, 20, 460, 260)];
    _ambSearchView.delegate = self;
    [self.view addSubview:_ambSearchView];
    _ambSearchView.hidden = YES;
    _Offline = NO;

    

}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _searcher.delegate = nil;
    _routeSearch.delegate = nil;
    _poiSearcher.delegate = nil;
}


#pragma mark - CLLocationManagerDelegate Method


- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    _userCoordinate = userLocation.location.coordinate;
    [_mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{

    [_mapView updateLocationData:userLocation];
    if (_setCenter)
    {
        _userLocation = userLocation;
        _userCoordinate = _userLocation.location.coordinate;
        [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
        _setCenter = NO;
    }
    else
    {
       // [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    }
}

#pragma mark - BMKMapViewDelegate Method
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"长按");
    [SVProgressHUD showWithStatus:@"正在搜索位置.."];

    //发起反向地理编码检索
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    _mapView.userInteractionEnabled = NO;
    CLLocationCoordinate2D  pt = coordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
}

#pragma mark - BMKPoiSearchDelegate Method


//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                           result:(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (_Offline)
    {

        [SVProgressHUD showWithStatus:@"找到所在位置城市，马上开始下载离线地图.."];
        NSArray* records = [_offlineMap searchCity:result.addressDetail.city];
        BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
        [_offlineMap start:oneRecord.cityID];
    }
    else
    {
        if (error == BMK_SEARCH_NO_ERROR)
        {
            _mapView.userInteractionEnabled = YES;
            [SVProgressHUD showSuccessWithStatus:@"找到位置"];
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D coor = result.location;
            annotation.coordinate = coor;
            annotation.title = result.address;
            [_mapView addAnnotation:annotation];
            
        }
        else {
            _mapView.userInteractionEnabled = YES;
            [SVProgressHUD showErrorWithStatus:@"未搜索到位置"];
            NSLog(@"抱歉，未找到结果");
        }

    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.selected = NO;
        return newAnnotationView;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    CLLocationCoordinate2D  pt = mapPoi.pt;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }

}

- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    BMKPlanNode* start = [[BMKPlanNode alloc] init];
    start.name = @"起点";
    start.pt = _userCoordinate;
    
    BMKPlanNode* end = [[BMKPlanNode alloc] init];
    end.name = [view.annotation title];
    end.pt = view.annotation.coordinate;
    

    //普通路线规划代码
    [SVProgressHUD showWithStatus:@"正在规划路径.."];
    BMKWalkingRoutePlanOption *walkingRoutePlanOption = [[BMKWalkingRoutePlanOption alloc] init];
    walkingRoutePlanOption.from = start;
    walkingRoutePlanOption.to = end;
    BOOL flag = [_routeSearch walkingSearch:walkingRoutePlanOption];
    if(flag)
    {
        NSLog(@"walkline检索发送成功");
    }
    else
    {
        NSLog(@"walkline检索");
    }
     
}




- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMKErrorOk)
    {
        [SVProgressHUD dismissWithSuccess:@"路径规划成功"];
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        array = [NSArray arrayWithArray:_mapView.overlays];
        [_mapView removeOverlays:array];
        
        BMKWalkingRouteLine *walkingRouteLine = result.routes[0];

        //起点
        BMKPointAnnotation* itemB = [[BMKPointAnnotation alloc]init];
        itemB.coordinate = walkingRouteLine.starting.location;
        
        //终点
        BMKPointAnnotation* itemE = [[BMKPointAnnotation alloc]init];
        itemE.coordinate = walkingRouteLine.terminal.location;
        [_mapView addAnnotation:itemB];
        [_mapView addAnnotation:itemE];
        
        int index = 0;
        for (BMKWalkingStep *walkingStep in walkingRouteLine.steps)
        {
            index += walkingStep.pointsCount;
         //   [_mapView addOverlay:[BMKPolyline polylineWithPoints:walkingStep.points count:walkingStep.pointsCount]];
        }
        BMKMapPoint *tmpPoints = new BMKMapPoint[index];
        int k = 0;
        for (int i = 0; i < walkingRouteLine.steps.count; i++) {
            BMKBusStep* step = [walkingRouteLine.steps objectAtIndex:i];
			for (int j = 0; j < step.pointsCount; j++) {
                BMKMapPoint pointarray;
                pointarray.x = step.points[j].x;
                pointarray.y = step.points[j].y;
                tmpPoints[k] = pointarray;
                k++;
            }
        }
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:tmpPoints count:index];
		[_mapView addOverlay:polyLine];
    }
    else
    {
        [SVProgressHUD dismissWithError:@"路径规划失败"];
    }
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]])
    {
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

- (void)startDownloadOffLineMAP
{
    _Offline = YES;
    if (!_offlineMap)
    {
        _offlineMap = [[BMKOfflineMap alloc] init];
        _offlineMap.delegate = self;
    }
    CLLocationCoordinate2D  pt = _userCoordinate;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

#pragma mark - BMKOfflineMapDelegate Method

- (void)onGetOfflineMapState:(int)type withState:(int)state
{
    if (state == TYPE_OFFLINE_UPDATE)
    {
        [SVProgressHUD showWithStatus:@"正在更新离线地图..."];
    }
    else if (state == TYPE_OFFLINE_ZIPCNT)
    {
        [SVProgressHUD showWithStatus:@"正在下载离线地图..."];
    }
    else if (state == TYPE_OFFLINE_UNZIP)
    {
        [SVProgressHUD showWithStatus:@"正在解压离线地图..."];
    }
    else if (state == TYPE_OFFLINE_NEWVER)
    {
        [SVProgressHUD showWithStatus:@"正在解压离线地图..."];
    }
    else if (state == TYPE_OFFLINE_UNZIPFINISH)
    {
        [SVProgressHUD showSuccessWithStatus:@"解压离线地图完成..."];
    }
    else if (state == TYPE_OFFLINE_ADD)
    {
        [SVProgressHUD showWithStatus:@"正在添加离线地图..."];
    }
}

- (void)backToMainViewController
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)showOrHideAmbitusSearchView
{
    _ambSearchView.hidden = !_ambSearchView.hidden;
}

#pragma mark - AmbitusSearchViewDelegate Method
- (void)didSearchButtonPressed:(NSString *)searchTitle
{
    if (!_poiSearcher)
    {
        _poiSearcher = [[BMKPoiSearch alloc] init];
        _poiSearcher.delegate = self;
    }
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];
    option.location = _userLocation.location.coordinate;
    option.keyword = searchTitle;
    BOOL flag = [_poiSearcher poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
}

- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        //在此处理正常结果
        [_mapView removeAnnotations:_mapView.annotations];
        for (BMKPoiInfo *poiInfo in poiResultList.poiInfoList)
        {
            BMKPointAnnotation* pointAnnotation = [[BMKPointAnnotation alloc]init];
            pointAnnotation.coordinate = poiInfo.pt;
            pointAnnotation.title = poiInfo.name;
            [_mapView addAnnotation:pointAnnotation];
        }
        [self showOrHideAmbitusSearchView];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

- (void)showNextViewController:(UISwipeGestureRecognizer*)recognizer
{
    [self backToMainViewController];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
