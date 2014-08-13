//
//  BlueteethDemoViewController.h
//  BicycleFunction
//
//  Created by Darsky on 14/8/10.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlueteethService.h"
#import "BlueteethModel.h"

@interface BlueteethDemoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,BlueteethServiceDelegate>
{
    UILabel *_deviceLabel;
    UITableView *_deviceTableView;
    NSArray *_actionArray;
}


@property (strong, nonatomic) BlueteethService *blueteethService;
@property (strong, nonatomic) BlueteethModel *blue;

- (void)startConnectToDevice:(CBPeripheral*)peripheral withService:(BlueteethService*)service;
@end
