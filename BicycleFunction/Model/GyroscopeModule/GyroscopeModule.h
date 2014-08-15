//
//  GyroscopeModule.h
//  BicycleFunction
//
//  Created by Darsky on 8/15/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@protocol GyroscopeModuleDelegate <NSObject>


@end


@interface GyroscopeModule : NSObject
{
    BOOL _userAttitudeSetted;
}

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) CMAttitude *userAttitude;
@property (assign, nonatomic) CMRotationMatrix userRotationMatrix;
- (void)launchMotionManager;
- (void)stopMotionManager;

@end
