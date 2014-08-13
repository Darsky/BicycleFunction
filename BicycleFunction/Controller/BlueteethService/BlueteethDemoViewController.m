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
    
    _deviceLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height/2-150/2, 0, 150, 30)];
    [self.view addSubview:_deviceLabel];
    _actionArray = @[@"打开第一个led",@"打开第二个led",@"关闭所有led",@"监听",@"取消监听"];
    self.blue = [[BlueteethModel alloc] init];
    _blueteethService = [[BlueteethService alloc] initWithServiceTarget:self];
    _deviceTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, [UIScreen mainScreen].bounds.size.height-100, [UIScreen mainScreen].bounds.size.width-90)];
    _deviceTableView.delegate = self;
    _deviceTableView.dataSource = self;
    [self.view addSubview:_deviceTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)startConnectToDevice:(CBPeripheral*)peripheral withService:(BlueteethService*)service;
{
    self.blue.connectPeripheral = peripheral;
    self.blueteethService = service;
    self.blueteethService.delegate = self;
    if (self.blue.connectPeripheral != nil)
    {
        if ([_blueteethService connect: self.blue.connectPeripheral])
        {
            [SVProgressHUD showWithStatus:@"正在连接"];
            
        }
        else
        {
            [SVProgressHUD dismissWithError:@"连接失败"];
        }
        _deviceLabel.text = self.blue.connectPeripheral.name;
    }

}

#pragma mark - UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _actionArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _actionArray[indexPath.row];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NSData* demoData = [@"LED1ON" dataUsingEncoding:NSUTF8StringEncoding];
            [self.blueteethService writeChar:demoData forBlue:self.blue ];
        }
            break;
        case 1:
        {
            NSData* demoData = [@"LED2ON" dataUsingEncoding:NSUTF8StringEncoding];
            [self.blueteethService writeChar:demoData forBlue:self.blue ];
        }
            break;
        case 2:
        {
            NSData* demoData = [@"LEDOFF" dataUsingEncoding:NSUTF8StringEncoding];
            [self.blueteethService writeChar:demoData forBlue:self.blue ];
        }
            break;
        case 3:
        {
            [self.blueteethService startObservedPeripheral:self.blue];
        }
            break;
            
        default:
            break;
    }
}

- (void)didDiscoverReadCharacteristic:(CBCharacteristic*)characteristic
{
    self.blue.readCharacteristic = characteristic;
}
- (void)didDiscoverWriteCharacteristic:(CBCharacteristic*)characteristic
{
    self.blue.writeCharacteristic = characteristic;
}

- (void)didPeripheralConnectSuccess
{
    [SVProgressHUD dismissWithSuccess:@"连接成功"];
}


@end
