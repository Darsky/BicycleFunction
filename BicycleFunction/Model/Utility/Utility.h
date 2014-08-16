//
//  Utility.h
//  BicycleFunction
//
//  Created by Darsky on 8/16/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    UtilityAlertTypeWarning,
    UtilityAlertTypeSuccess,
    UtilityAlertTypeError,
}UtilityAlertType;

@interface Utility : NSObject

+ (void)showMessageWithMessage:(NSString*)message withMessageType:(UtilityAlertType)type;

@end
