//
//  BlueteethService.m
//  BicycleFunction
//
//  Created by Darsky on 14/7/27.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import "BlueteethService.h"
#import "SVProgressHUD.h"


@implementation BlueteethService

- (id)initWithServiceTarget:(id)target
{
    self = [super init];
    if (self)
    {
        if (!_manager)
        {
            self.delegate = target;
            _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        }
        _dicoveredPeripherals = [NSMutableArray array];
    }
    return self;
}

- (void)startBlueteethService
{
    [_manager scanForPeripheralsWithServices:nil options:nil];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    if(![_dicoveredPeripherals containsObject:peripheral])
    {
        [_dicoveredPeripherals addObject:peripheral];
    }
    NSLog(@"dicoveredPeripherals:%@", _dicoveredPeripherals);
}

-(BOOL)connect:(CBPeripheral *)peripheral
{
    NSLog(@"connect start");
    _connectPeripheral = nil;
    [_manager connectPeripheral:peripheral
                       options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
    
    //开一个定时器监控连接超时的情况
    _connectTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f
                                                     target:self
                                                   selector:@selector(connectTimeout:)
                                                   userInfo:peripheral
                                                    repeats:NO];
    
    return (YES);
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            _BlueteethAvilabel = NO;
            [_manager stopScan];
            break;
        case 5:
            break;
        default:
            break;
    }
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [_connectTimer invalidate];//停止时钟
    
    NSLog(@"Did connect to peripheral: %@", peripheral);
    _connectPeripheral = peripheral;
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
}

- (BOOL)didBlueteethAvilabel
{
    return YES;
}

- (void)connectTimeout:(CBPeripheral *)peripheral
{
    if (!peripheral.isConnected)
    {
        [SVProgressHUD showErrorWithStatus:@"连接超时"
                                  duration:3.0];
        [_connectTimer invalidate];//停止时钟
    }
}

-(void)writeChar:(NSData *)data
{
    //[_connectPeripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

@end
