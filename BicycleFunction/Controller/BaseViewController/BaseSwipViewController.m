//
//  BaseSwipViewController.m
//  BicycleFunction
//
//  Created by Darsky on 7/22/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import "BaseSwipViewController.h"

@interface BaseSwipViewController ()
{
    UISwipeGestureRecognizer *_swipGesture;
}

@end

@implementation BaseSwipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showNextViewController:)];
    _swipGesture.direction = self.direction;
    _swipGesture.delegate = self;
    [self.view addGestureRecognizer:_swipGesture];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view != self.view)
    {
        return NO;
    }
    return YES;
}

- (void)showNextViewController:(UISwipeGestureRecognizer*)recognizer
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
