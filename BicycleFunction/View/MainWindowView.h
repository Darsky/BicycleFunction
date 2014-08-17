//
//  MainWindowView.h
//  BicycleFunction
//
//  Created by Darsky on 14/8/17.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainWindowView : UIView
{
    UILabel *_titleLabel;
    UIButton *_cancelButton ;
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)title;

@end
