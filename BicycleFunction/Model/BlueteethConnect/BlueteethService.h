//
//  BlueteethService.h
//  BicycleFunction
//
//  Created by Darsky on 14/7/27.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BlueteethModel.h"

@protocol BlueteethServiceDelegate <NSObject>
@optional

- (void)didUpdateConnectPeripheral:(NSArray*)connects;
- (void)stopConnectPeripheralScan;
- (void)didDiscoverReadCharacteristic:(CBCharacteristic*)characteristic;
- (void)didDiscoverWriteCharacteristic:(CBCharacteristic*)characteristic;
- (void)didPeripheralConnectSuccess;

@end

@interface BlueteethService : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    NSTimer *_connectTimer;
    CBPeripheral *_connectPeripheral;
    CBCharacteristic *_readCharacteristic;
    BOOL _BlueteethAvilabel;
}

@property (assign, nonatomic) id <BlueteethServiceDelegate> delegate;
@property (strong, nonatomic) CBCentralManager *manager;
@property (assign, nonatomic) id target;
@property (strong, nonatomic) NSMutableArray *dicoveredPeripherals;
@property (strong, nonatomic) NSMutableArray *observedPeripherals;


- (id)initWithServiceTarget:(id)target;

//对模块的操作
- (void)startBlueteethService;
- (NSArray*)getConnectedDevice;
- (BOOL)didBlueteethAvilabel;
- (BOOL)connect:(CBPeripheral *)peripheral;

//通过模块对蓝牙的操作
- (void)startObservedPeripheral:(BlueteethModel *)model;
-(void)writeChar:(NSData *)data forBlue:(BlueteethModel*)blue;
@end
