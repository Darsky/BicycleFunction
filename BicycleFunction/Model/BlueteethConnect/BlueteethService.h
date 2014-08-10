//
//  BlueteethService.h
//  BicycleFunction
//
//  Created by Darsky on 14/7/27.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol BlueteethServiceDelegate <NSObject>
@optional

- (void)didUpdateConnectPeripheral:(NSArray*)connects;

@end

@interface BlueteethService : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    NSTimer *_connectTimer;
    CBPeripheral *_connectPeripheral;
    BOOL _BlueteethAvilabel;
}

@property (assign, nonatomic) id <BlueteethServiceDelegate> delegate;
@property (strong, nonatomic) CBCentralManager *manager;
@property (assign, nonatomic) id target;
@property (strong, nonatomic) NSMutableArray *dicoveredPeripherals;

- (id)initWithServiceTarget:(id)target;

//对模块的操作
- (void)startBlueteethService;
- (NSArray*)getConnectedDevice;
- (BOOL)didBlueteethAvilabel;
- (BOOL)connect:(CBPeripheral *)peripheral;

//通过模块对蓝牙的操作

@end
