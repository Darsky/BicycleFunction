//
//  AmbitusSearchView.h
//  BicycleFunction
//
//  Created by Darsky on 14/8/16.
//  Copyright (c) 2014年 Darsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@protocol AmbitusSearchViewDelegate <NSObject>

- (void)didSearchButtonPressed:(NSString*)searchTitle;

@end

@interface AmbitusSearchView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_boardingView;
    UITableView *_resultTableView;
    NSMutableArray *_resultArray;
}

@property (assign, nonatomic) id <AmbitusSearchViewDelegate> delegate;

@end
