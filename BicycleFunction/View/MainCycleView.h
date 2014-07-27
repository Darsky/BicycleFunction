//
//  MainCycleView.h
//  BicycleFunction
//
//  Created by Darsky on 7/22/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCycleView : UIView<UIGestureRecognizerDelegate>
{
    NSMutableArray *_buttonsArray;
    UIRotationGestureRecognizer *_rotationGesture;
}

@end
