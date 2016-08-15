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
    
    toView.hidden = YES;
   
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
//        toView.alpha = 0;
        [fromVC.view setFrame:fromFrame];
        
        UIView *toViewSuperView = toView;
        CGFloat originY = CGRectGetMinY(toView.frame);
        CGFloat originX = CGRectGetMinX(toView.frame);
        while (![toViewSuperView isEqual:toVC.view]) {
            toViewSuperView = toViewSuperView.superview;
            originY += CGRectGetMinY(toViewSuperView.frame);
            originX += CGRectGetMinX(toViewSuperView.frame);
        }
        
        [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
        [containerView addSubview:abloomView];
        [containerView addSubview:toVC.view];
        
        toVC.view.alpha = 0;
        
        CGRect stayFrame = CGRectMake(originX, originY, CGRectGetWidth(toView.frame), CGRectGetHeight(toView.frame));
        
        
        [UIView animateWithDuration:duration/2 animations:^{
            toVC.view.alpha = 1;
            abloomView.frame = [containerView convertRect:stayFrame fromView:fromView.superview];
            [containerView bringSubviewToFront:abloomView];
            
            CGFloat scaleY = CGRectGetHeight(abloomView.frame) / CGRectGetHeight(toVC.view.frame);
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
            scaleAnimation.fromValue = [NSNumber numberWithFloat:scaleY];
            scaleAnimation.toValue = [NSNumber numberWithFloat:1];
            scaleAnimation.duration = duration/2;
            scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [toVC.view.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];

        } completion:^(BOOL finished) {
            toView.alpha = 1;
            toView.hidden = NO;
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
        [containerView sendSubviewToBack:toVC.view];
        [containerView bringSubviewToFront:abloomView];
        

        CGRect stayFrame = CGRectMake(CGRectGetMinX(toView.frame), CGRectGetMinY(toView.frame), CGRectGetWidth(toView.frame), CGRectGetHeight(toView.frame));

        toFrame.origin.y = 0;
        
        [UIView animateWithDuration:duration/2 animations:^{
            fromVC.view.alpha = 0;
            
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
            scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
            scaleAnimation.toValue = [NSNumber numberWithFloat:0];
            scaleAnimation.duration = duration/2;
            scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"transfom.position"];
            moveAnimation.fromValue = [NSValue valueWithCGPoint:fromVC.view.layer.position];
            moveAnimation.fromValue = [NSValue valueWithCGPoint:abloomView.layer.position];

            CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
            groupAnimation.duration = duration/2;
            [groupAnimation setAnimations:@[scaleAnimation, moveAnimation]];
            
            [fromVC.view.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
            
            toVC.view.alpha = 1;
            [toVC.view setFrame:toFrame];
            abloomView.frame = [containerView convertRect:stayFrame fromView:toView.superview];
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [abloomView removeFromSuperview];
            [fromVC.view removeFromSuperview];
            [fromVC.view.layer removeAnimationForKey:@"groupAnimation"];
        }];
    }
    
}

@end
