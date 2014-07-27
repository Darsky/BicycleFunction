//
//  MainCycleView.m
//  BicycleFunction
//
//  Created by Darsky on 7/22/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import "MainCycleView.h"

@implementation MainCycleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        UIButton *demoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        demoButton.frame = CGRectMake(self.frame.size.width/2-55/2, -10, 55, 55);
        [demoButton setBackgroundColor:[UIColor greenColor]];
        demoButton.layer.borderWidth = 2;
        demoButton.layer.borderColor = [UIColor whiteColor].CGColor;
        demoButton.layer.masksToBounds = YES;
        demoButton.layer.cornerRadius = 55/2;
        [self addSubview:demoButton];
        
        _rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(roteThisView:)];
        [self addGestureRecognizer:_rotationGesture];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

- (void)roteThisView:(UIRotationGestureRecognizer*)recognizer
{
    self.transform = CGAffineTransformMakeRotation(recognizer.rotation);
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        /* TODO:校准代码
        CGAffineTransform transform = self.transform;
        NSLog(@"++++++++ transform(%f,%f,%f,%f,%f,%f)", transform.a, transform.b, transform.c, transform.d, transform.tx, transform.ty);
        CGFloat rotate = acosf(transform.a);
        if (transform.b < 0) {
            rotate+= M_PI;
        }
        CGFloat degree = rotate/M_PI * 180;
        NSLog(@"+++++++++ degree : %f", degree);
        CGAffineTransform newTransForm = CGAffineTransformRotate(transform, -M_PI/2);
        [self setTransform:newTransForm];
        CGFloat newRotate = acosf(newTransForm.a);
        if (newTransForm.b < 0) {
            newRotate+= M_PI;
        }
        CGFloat newDegree = newRotate/M_PI * 180;
        NSLog(@"+++++++++ newDegree : %f", newDegree);
         */
    }
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.width-20));
    CGContextSetStrokeColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(ctx, 5.0);
    // CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor greenColor] CGColor]));
    CGContextDrawPath(ctx, kCGPathStroke);
}


@end
