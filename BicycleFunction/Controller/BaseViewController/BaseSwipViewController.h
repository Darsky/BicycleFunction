//
//  BaseSwipViewController.h
//  BicycleFunction
//
//  Created by Darsky on 7/22/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSwipViewController : UIViewController<UIGestureRecognizerDelegate>

@property (assign,nonatomic) UISwipeGestureRecognizerDirection direction;

@end
