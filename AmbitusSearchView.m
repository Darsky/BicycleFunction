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
        foodButton.frame = CGRectMake(10, 10, 40, 40);
        foodButton.backgroundColor = [UIColor whiteColor];
        [foodButton setTitle:@"美食" forState:UIControlStateNormal];
        [foodButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [foodButton addTarget:self action:@selector(didSearchButtonTouch:) forControlEvents:UIControlEventTouchDown];
        foodButton.layer.borderColor = [UIColor grayColor].CGColor;
        foodButton.layer.borderWidth = 0.5;
        [_boardingView addSubview:foodButton];
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
