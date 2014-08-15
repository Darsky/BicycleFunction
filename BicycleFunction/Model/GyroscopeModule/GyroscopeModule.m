//
//  GyroscopeModule.m
//  BicycleFunction
//
//  Created by Darsky on 8/15/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import "GyroscopeModule.h"

@implementation GyroscopeModule

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)launchMotionManager
{
    self.motionManager = [[CMMotionManager alloc] init];
    if (!self.motionManager.accelerometerAvailable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您的设备无法使用陀螺仪"
                                                       delegate:nil
                                              cancelButtonTitle:@""
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    _userAttitudeSetted = NO;
//    self.motionManager.gyroUpdateInterval = 2.0;
//    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
//                                    withHandler:^(CMGyroData *gyroData, NSError *error)
//    {
//        NSLog(@"旋转角度:X:%.3f,Y:%.3f,X:%.3f",gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z);
//    }];
    
    self.motionManager.accelerometerUpdateInterval=2.0;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
    {
        NSLog(@"加速计:X:%.3f,Y:%.3f,Z:%.3f",accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
    }];

    
}


- (void)stopMotionManager
{
    [self.motionManager stopAccelerometerUpdates];
}

@end
