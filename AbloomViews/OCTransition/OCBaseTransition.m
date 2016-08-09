//
//  OCBaseTransition.m
//  ASFTransitionTest
//
//  Created by 姜苏珈 on 16/1/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "OCBaseTransition.h"

@implementation OCBaseTransition
#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.30f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _presenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _presenting = NO;
    return self;
}

@end
