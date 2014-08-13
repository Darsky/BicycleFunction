//
//  BlueteethModel.h
//  BicycleFunction
//
//  Created by Darsky on 14/8/13.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface BlueteethModel : NSObject

@property (strong, nonatomic) CBPeripheral *connectPeripheral;
@property (strong, nonatomic) CBCharacteristic *writeCharacteristic;
@property (strong, nonatomic) CBCharacteristic *readCharacteristic;
@end
