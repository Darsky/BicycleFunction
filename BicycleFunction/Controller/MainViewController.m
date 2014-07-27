//
//  MainViewController.m
//  BicycleFunction
//
//  Created by Darsky on 7/22/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import "MainViewController.h"
#import "MainCycleView.h"
#import "BicycleNavigationViewController.h"

#define cycleWidth 230.0

@interface MainViewController ()
{
    MainCycleView *_mainCycleView;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor blackColor];
    _mainCycleView = [[MainCycleView alloc] initWithFrame:CGRectMake(self.view.frame.size.height/2-cycleWidth/2,
                                                                     320/2-cycleWidth/2,
                                                                     cycleWidth,
                                                                     cycleWidth)];
    [self.view addSubview:_mainCycleView];
}



- (void)showNextViewController:(UISwipeGestureRecognizer*)recognizer
{
    NSLog(@"kakaka");
    BicycleNavigationViewController *bicycleNavigationViewController = nil;
    bicycleNavigationViewController = [[BicycleNavigationViewController alloc] init];
    [self.navigationController pushViewController:bicycleNavigationViewController
                                         animated:YES];
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
