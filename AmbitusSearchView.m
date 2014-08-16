//
//  AmbitusSearchView.m
//  BicycleFunction
//
//  Created by Darsky on 14/8/16.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import "AmbitusSearchView.h"

@implementation AmbitusSearchView
static NSString *cellInentifier = @"AmbitusSearchCell";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _resultArray = [NSMutableArray array];
        _resultTableView = [[UITableView alloc] initWithFrame:self.bounds];
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
        [self addSubview:_resultTableView];
        _resultTableView.hidden = YES;
        
        _boardingView = [[UIView alloc] initWithFrame:self.bounds];
        UIButton *foodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        foodButton.frame = CGRectMake(20, 10, 80, 40);
        foodButton.backgroundColor = [UIColor whiteColor];
        [foodButton setTitle:@"美食" forState:UIControlStateNormal];
        [foodButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [foodButton addTarget:self action:@selector(didSearchButtonTouch:) forControlEvents:UIControlEventTouchDown];
        foodButton.layer.borderColor = [UIColor grayColor].CGColor;
        foodButton.layer.borderWidth = 0.5;
        [_boardingView addSubview:foodButton];
        
        UIButton *hotelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        hotelButton.frame = CGRectMake(120, 10, 80, 40);
        hotelButton.backgroundColor = [UIColor whiteColor];
        [hotelButton setTitle:@"酒店" forState:UIControlStateNormal];
        [hotelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [hotelButton addTarget:self action:@selector(didSearchButtonTouch:) forControlEvents:UIControlEventTouchDown];
        hotelButton.layer.borderColor = [UIColor grayColor].CGColor;
        hotelButton.layer.borderWidth = 0.5;
        [_boardingView addSubview:hotelButton];
        [self addSubview:_boardingView];
        
        UIButton *sceneryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sceneryButton.frame = CGRectMake(20, 50, 80, 40);
        sceneryButton.backgroundColor = [UIColor whiteColor];
        [sceneryButton setTitle:@"景点" forState:UIControlStateNormal];
        [sceneryButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sceneryButton addTarget:self action:@selector(didSearchButtonTouch:) forControlEvents:UIControlEventTouchDown];
        sceneryButton.layer.borderColor = [UIColor grayColor].CGColor;
        sceneryButton.layer.borderWidth = 0.5;
        [_boardingView addSubview:sceneryButton];
        [self addSubview:_boardingView];
        
        
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInentifier];
    }
    
    return cell;
}

- (void)didSearchButtonTouch:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(didSearchButtonPressed:)])
    {
        [self.delegate didSearchButtonPressed:sender.titleLabel.text];
    }
}

@end
