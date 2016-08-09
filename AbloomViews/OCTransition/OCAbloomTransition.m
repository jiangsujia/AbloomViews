//
//  OCAbloomTransition.m
//  ASFTransitionTest
//
//  Created by 姜苏珈 on 16/1/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "OCAbloomTransition.h"

@implementation OCAbloomTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = self.fromView;
    UIView *toView = self.toView;
    
    //Take Snapshot of fromeView
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    UIView *abloomView = fromView;
    abloomView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    abloomView.clipsToBounds = YES;
    abloomView.contentMode = UIViewContentModeScaleAspectFill;
    abloomView.alpha = 1;

    
    CGRect fromFrame = fromVC.view.frame;
    CGRect toFrame = toVC.view.frame;
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];

    if (self.isPresenting) {
        if (fromView.frame.origin.y >= AHeight/2) {
            duration = 1.25*duration;
        }
        
        //Setup the initial view states
        toView.alpha = 0;
        [fromVC.view setFrame:fromFrame];
        //edit by tujinguo 修改toViwe动画起始位置
        [toVC.view setFrame:CGRectMake(CGRectGetMinX(toView.frame), CGRectGetMinY(toView.frame), 0, 0)];
        
        
        [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
        [containerView addSubview:abloomView];
        [containerView addSubview:toVC.view];
        toVC.view.alpha = 0;
        
        toFrame.origin.y = 0;
        CGRect stayFrame = CGRectMake(CGRectGetMinX(toView.frame), CGRectGetMinY(toView.frame), CGRectGetWidth(toView.frame), CGRectGetHeight(toView.frame));

        [UIView animateWithDuration:duration
                         animations:^{
                             toVC.view.alpha = 1;
                             [toVC.view setFrame:toFrame];
                             abloomView.frame = [containerView convertRect:stayFrame fromView:fromView.superview];
                             [containerView bringSubviewToFront:abloomView];
        }
                         completion:^(BOOL finished) {
                             toView.alpha = 1;
                             [transitionContext completeTransition:YES];
                             [abloomView removeFromSuperview];
                             [fromVC.view removeFromSuperview];
                         }];
    }else
    {
        if (toView.frame.origin.y > AHeight/2) {
            duration = 1.25*duration;
        }
        
        [toVC.view setFrame:toFrame];
        [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
        [containerView addSubview:abloomView];
        [containerView addSubview:toVC.view];
        [containerView bringSubviewToFront:abloomView];

        toVC.view.alpha = 0;
        CGRect stayFrame = CGRectMake(toView.frame.origin.x, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);

        toFrame.origin.y = 0;
        [UIView animateWithDuration:duration
                         animations:^{
                             toVC.view.alpha = 1;
                             [toVC.view setFrame:toFrame];
                             abloomView.frame = [containerView convertRect:stayFrame fromView:toView.superview];
                             abloomView.alpha = 0;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                             [abloomView removeFromSuperview];
                             [fromVC.view removeFromSuperview];
                         }];
    }
    
}

@end
