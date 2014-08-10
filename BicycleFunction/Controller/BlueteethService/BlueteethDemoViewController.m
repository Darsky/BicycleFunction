//
//  BlueteethDemoViewController.m
//  BicycleFunction
//
//  Created by Darsky on 14/8/10.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import "BlueteethDemoViewController.h"

@implementation BlueteethDemoViewController
static NSString *cellIdentifier = @"DeviceListTableViewCell";


- (void)viewDidLoad
{
    [super viewDidLoad];
    _deviceArray = [NSMutableArray array];
    _deviceTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 0, [UIScreen mainScreen].bounds.size.height-100, [UIScreen mainScreen].bounds.size.width-40)];
    _deviceTableView.delegate = self;
    _deviceTableView.dataSource = self;
    [self.view addSubview:_deviceTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_deviceArray addObjectsFromArray:[self.blueteethService getConnectedDevice]];
}

#pragma mark - UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _deviceArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    CBPeripheral *peripheral = _deviceArray[indexPath.row];
    cell.textLabel.text = peripheral.name;
    return  cell;
}

@end
