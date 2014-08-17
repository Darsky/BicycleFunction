//
//  BlueteethServiceViewController.m
//  BicycleFunction
//
//  Created by Darsky on 14/7/27.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import "BlueteethServiceViewController.h"
#import "BlueteethDemoViewController.h"

@implementation BlueteethServiceViewController
static NSString *cellIdentifier = @"DeviceListTableViewCell";

- (void)loadView
{
    [super loadView];
    _deviceListTableView = [[UITableView alloc] initWithFrame:CGRectMake(50,
                                                                         20,
                                                                         [UIScreen mainScreen].bounds.size.height-100,
                                                                         [UIScreen mainScreen].bounds.size.width-70)];
    _deviceListTableView.delegate = self;
    _deviceListTableView.dataSource = self;
    
    [self.view addSubview:_deviceListTableView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(5, 30, 40, 30);
    [_backButton setTitle:@"back" forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _backButton.userInteractionEnabled = YES;
    [_backButton addTarget:self
                    action:@selector(pushToDemoView)
          forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_backButton];
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

- (void)didUpdateConnectPeripheral:(NSArray *)connects
{
    if (_deviceArray.count >0)
    {
        [_deviceArray removeAllObjects];
    }
    [_deviceArray addObjectsFromArray:connects];
    [_deviceListTableView reloadData];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlueteethDemoViewController *viewController = [[BlueteethDemoViewController alloc] init];
    [self presentViewController:viewController
                       animated:YES
                     completion:^{
                         [viewController startConnectToDevice:_deviceArray[indexPath.row] withService:_blueteethService];}
     ];
    
}

- (void)pushToDemoView
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
