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
#import "BlueteethServiceViewController.h"
#import "GyroscopeViewController.h"

#define cycleWidth 230.0

@interface MainViewController ()<MainCycleViewDelegate>
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
    self.view.backgroundColor = [UIColor blackColor];
    //TODO:用你的页面名字替换"测试"
    _itemsArray = [@[@"导航",@"蓝牙",@"陀螺仪",@"测试"] mutableCopy];
    _mainCycleView = [[MainCycleView alloc] initWithFrame:CGRectMake(self.view.frame.size.height/2-cycleWidth/2,
                                                                     320/2-cycleWidth/2,
                                                                     cycleWidth,
                                                                     cycleWidth)
                                                withItems:_itemsArray];
    _mainCycleView.delegate = self;
    [self.view addSubview:_mainCycleView];
}

- (void)loadView
{
    [super loadView];

}



- (void)showNextViewController:(UISwipeGestureRecognizer*)recognizer
{
    NSLog(@"kakaka");

}

- (void)didSelectAButton:(NSString *)buttonName
{
    if ([_itemsArray containsObject:buttonName])
    {
        switch ([_itemsArray indexOfObject:buttonName])
        {
            case 0:
            {
                BicycleNavigationViewController *bicycleNavigationViewController = nil;
                bicycleNavigationViewController = [[BicycleNavigationViewController alloc] init];
                [self.navigationController pushViewController:bicycleNavigationViewController
                                                     animated:YES];
            }
                break;
            case 1:
            {
                BlueteethServiceViewController *viewController = [[BlueteethServiceViewController alloc] init];
                [self.navigationController pushViewController:viewController animated:YES];
            }
                break;
            case 2:
            {
                GyroscopeViewController *viewController = [[GyroscopeViewController alloc] init];
                [viewController setDirection:UISwipeGestureRecognizerDirectionLeft];
                [self.navigationController pushViewController:viewController animated:YES];
                
            }
                break;
            case 3:
            {
                //TODO:在这里初始化你的ViewController并push
                BlueteethServiceViewController *viewController = [[BlueteethServiceViewController alloc] init];
                [self.navigationController pushViewController:viewController animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
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
