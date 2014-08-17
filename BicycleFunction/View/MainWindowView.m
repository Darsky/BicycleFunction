//
//  MainWindowView.m
//  BicycleFunction
//
//  Created by Darsky on 14/8/17.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import "MainWindowView.h"

@implementation MainWindowView

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width-60, 30)];
        _titleLabel.backgroundColor = [UIColor grayColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(self.frame.size.width-30, 5, 30, 30);
        [_cancelButton setBackgroundColor:[UIColor lightGrayColor]];
        [_cancelButton setTitle:@"X" forState:UIControlStateNormal];
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 30/2;
        [self addSubview:_cancelButton];
    }
    return self;
}

@end
