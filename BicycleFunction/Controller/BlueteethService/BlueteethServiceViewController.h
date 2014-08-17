//
//  BlueteethServiceViewController.h
//  BicycleFunction
//
//  Created by Darsky on 14/7/27.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import "BaseSwipViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BlueteethService.h"
#import "BlueteethModel.h"

@interface BlueteethServiceViewController : BaseSwipViewController<UITableViewDataSource,UITableViewDelegate,BlueteethServiceDelegate>
{
    UITableView *_deviceListTableView;
    NSMutableArray *_deviceArray;
    BlueteethService *_blueteethService;
    UIButton *_backButton;
    
}

@end
