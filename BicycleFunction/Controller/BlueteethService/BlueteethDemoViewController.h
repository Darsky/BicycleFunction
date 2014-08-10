//
//  BlueteethDemoViewController.h
//  BicycleFunction
//
//  Created by Darsky on 14/8/10.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlueteethService.h"

@interface BlueteethDemoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_deviceTableView;
    NSMutableArray *_deviceArray;
}


@property (strong, nonatomic) BlueteethService *blueteethService;
@end
