//
//  BicycleNavigationViewController.h
//  BicycleFunction
//
//  Created by Darsky on 7/22/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "BNCoreServices.h"


@interface BicycleNavigationViewController : UIViewController
{
    BMKMapView *_mapView;
    BMKOfflineMap *_offlineMap;
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_searcher;
    BMKRouteSearch *_routeSearch;
}

@end
