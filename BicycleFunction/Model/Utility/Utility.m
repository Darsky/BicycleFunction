//
//  Utility.m
//  BicycleFunction
//
//  Created by Darsky on 8/16/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (id)sharedUtility
{
    static Utility *utility = nil;
    //
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{utility = [[Utility alloc] init];});
    //
    return utility;
}

+ (void)showMessageWithMessage:(NSString*)message withMessageType:(UtilityAlertType)type
{
    switch (type) {
        case UtilityAlertTypeWarning:
        {
            [[Utility sharedUtility] showAlertWithTitle:@"警告" andMessage:message ];
        }
            break;
        case UtilityAlertTypeSuccess:
        {
            [[Utility sharedUtility] showAlertWithTitle:@"恭喜" andMessage:message ];
        }
            break;
        case UtilityAlertTypeError:
        {
            [[Utility sharedUtility] showAlertWithTitle:@"错误" andMessage:message ];
        }
            break;
        default:
            break;
    }
}

- (void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"好的"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
