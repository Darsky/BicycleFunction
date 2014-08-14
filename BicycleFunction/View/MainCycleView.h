//
//  MainCycleView.h
//  BicycleFunction
//
//  Created by Darsky on 7/22/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MainCycleViewDelegate <NSObject>

- (void)didSelectAButton:(NSString*)buttonName;

@end

@interface MainCycleView : UIView<UIGestureRecognizerDelegate>
{
    NSMutableArray *_buttonsArray;
    UIRotationGestureRecognizer *_rotationGesture;
}

- (id)initWithFrame:(CGRect)frame withItems:(NSArray*)items;
@property (assign, nonatomic) id <MainCycleViewDelegate> delegate;

@end
