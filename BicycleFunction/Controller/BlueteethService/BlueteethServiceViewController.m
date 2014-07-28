//
//  BlueteethServiceViewController.m
//  BicycleFunction
//
//  Created by Darsky on 14/7/27.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import "BlueteethServiceViewController.h"

@implementation BlueteethServiceViewController
static NSString *cellIdentifier = @"DeviceListTableViewCell";

- (void)loadView
{
    [super loadView];
    _deviceListTableView = [[UITableView alloc] initWithFrame:CGRectMake(50,
                                                                         20,
                                                                         [UIScreen mainScreen].bounds.size.height-100,
                                                                         [UIScreen mainScreen].bounds.size.width-30)];
    _deviceListTableView.delegate = self;
    _deviceListTableView.dataSource = self;
    
    [self.view addSubview:_deviceListTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _deviceArray = [NSMutableArray array];
    _blueteethService = [[BlueteethService alloc] initWithServiceTarget:self];
    [_blueteethService addObserver:self forKeyPath:@"dicoveredPeripherals" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"%@ %@ %@ ", keyPath, object, change);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_blueteethService startBlueteethService];
}

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
