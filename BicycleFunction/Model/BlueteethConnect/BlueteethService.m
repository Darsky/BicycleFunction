//
//  BlueteethService.m
//  BicycleFunction
//
//  Created by Darsky on 14/7/27.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import "BlueteethService.h"
#import "SVProgressHUD.h"

#define     BLE_UUID_DEVICE_INFORMATION_SERVICE   0x180A

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
        _observedPeripherals = [NSMutableArray array];
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
        if ([self.delegate respondsToSelector:@selector(didUpdateConnectPeripheral:)])
        {
            [self.delegate didUpdateConnectPeripheral:_dicoveredPeripherals];
        }
    }
}

-(BOOL)connect:(CBPeripheral *)peripheral
{
    NSLog(@"connect start");
    _connectPeripheral = nil;
    [_manager connectPeripheral:peripheral
                       options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES]
                                                           forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
    
    //开一个定时器监控连接超时的情况
    
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
    NSLog(@"Did connect to peripheral: %@", peripheral);
    _connectPeripheral = peripheral;
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    if ([self.delegate respondsToSelector:@selector(didPeripheralConnectSuccess)])
    {
        [self.delegate didPeripheralConnectSuccess];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error)
    {
        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);

        return;
    }
    for (CBService *service in peripheral.services)
    {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFE0"]])
        {
            NSLog(@"Service found with UUID: %@", service.UUID);
            [peripheral discoverCharacteristics:nil forService:service];
        }
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFE5"]])
        {
            NSLog(@"Service found with UUID: %@", service.UUID);
            [peripheral discoverCharacteristics:nil forService:service];
        }

//        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFE5"]])
//        {
//            [peripheral discoverCharacteristics:nil forService:service];
//        }
          //  [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    
    if (error)
    {
        NSLog(@"Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFE0"]])
    {
        for (CBCharacteristic *characteristic in service.characteristics)
        {
            NSLog(@"Discovered read characteristics:%@ for service: %@", characteristic.UUID, service.UUID);
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE4"]])
            {
                _readCharacteristic = characteristic;
                if ([self.delegate respondsToSelector:@selector(didDiscoverReadCharacteristic:)])
                {
                    [self.delegate didDiscoverReadCharacteristic:characteristic];
                }
            }
        }
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFE5"]])
    {
        for (CBCharacteristic * characteristic in service.characteristics)
        {
            
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE9"]])
            {
                NSLog(@"Discovered write characteristics:%@ for service: %@", characteristic.UUID, service.UUID);
                if ([self.delegate respondsToSelector:@selector(didDiscoverWriteCharacteristic:)])
                {
                    [self.delegate didDiscoverWriteCharacteristic:characteristic];
                }
            }
            
        }

    }
    
    
}

- (BOOL)didBlueteethAvilabel
{
    return YES;
}

- (NSArray*)getConnectedDevice
{
    NSMutableArray *connectedDeviceArray = [NSMutableArray array];
    for (CBPeripheral *device in _dicoveredPeripherals)
    {
        if (device.state == CBPeripheralStateConnected)
        {
            [connectedDeviceArray addObject:device];
        }
    }
    return connectedDeviceArray;
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
- (void)startObservedPeripheral:(BlueteethModel *)model
{
    model.connectPeripheral.delegate = self;
    [model.connectPeripheral setNotifyValue:YES forCharacteristic:model.readCharacteristic];
}

-(void)writeChar:(NSData *)data forBlue:(BlueteethModel*)blue
{
    blue.connectPeripheral.delegate = self;
    [blue.connectPeripheral writeValue:data
                     forCharacteristic:blue.writeCharacteristic
                                  type:CBCharacteristicWriteWithResponse];
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"write Value%@",characteristic.value);
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSString *readString = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    NSLog(@"%@",readString);
}



-(void)writeChar:(NSData *)data
{
    //[_connectPeripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

@end
