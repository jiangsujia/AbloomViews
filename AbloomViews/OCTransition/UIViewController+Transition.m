//
//  UIViewController+Transition.m
//  ASFTransitionTest
//
//  Created by 姜苏珈 on 16/1/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "UIViewController+Transition.h"
#import <objc/runtime.h>
#import "OCAbloomTransition.h"
#import "AbloomBaseCell.h"

static const void *AbloomTransitionKey = &AbloomTransitionKey;
static const void *AbloomTransitionDimissKey = &AbloomTransitionDimissKey;
static const void *AbloomTransitionDismissFrameKey = &AbloomTransitionDismissFrameKey;
@implementation UIViewController (Transition)
@dynamic showAlboomView;
@dynamic dimissAbloomView;
@dynamic dimissFrameString;
- (UIView *)showAlboomView
{
    return objc_getAssociatedObject(self, AbloomTransitionKey);
}

- (void)setShowAlboomView:(UIImageView *)showAlboomView
{
    objc_setAssociatedObject(self, AbloomTransitionKey, showAlboomView, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)dimissAbloomView
{
    return objc_getAssociatedObject(self, AbloomTransitionDimissKey);
}

- (void)setDimissAbloomView:(UIImageView *)dimissAbloomView
{
    objc_setAssociatedObject(self, AbloomTransitionDimissKey, dimissAbloomView, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)dimissFrameString
{
    return objc_getAssociatedObject(self, AbloomTransitionDismissFrameKey);
}

- (void)setDimissFrameString:(NSString *)dimissFrameString
{
    objc_setAssociatedObject(self, AbloomTransitionDismissFrameKey,dimissFrameString, OBJC_ASSOCIATION_RETAIN);
}


- (UIImageView *__nonnull)transitionViewByTableView:(UITableView *__nonnull)tableView indexPath:(NSIndexPath *__nonnull)indexPath;
{
    AbloomBaseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.showAlboomView = [self transitionViewByTableView:tableView indexPath:indexPath image:cell.abloomView.image];
    self.showAlboomView.contentMode = UIViewContentModeScaleAspectFill;
    self.showAlboomView.clipsToBounds = YES;
    return self.showAlboomView;
}


- (UIImageView *)transitionViewByTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath image:(UIImage *)image
{
    AbloomBaseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect cellInTableRect = [tableView rectForRowAtIndexPath:indexPath];
    CGRect cellRect = [tableView convertRect:cellInTableRect toView:[tableView superview]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(cellRect) + CGRectGetMinX(cell.abloomView.frame), CGRectGetMinY(cellRect) + CGRectGetMinY(cell.abloomView.frame), CGRectGetWidth(cell.abloomView.frame), CGRectGetHeight(cell.abloomView.frame))];
    imageView.image = image;
    return imageView;
}



- (void)presentAbloomViewController:(UIViewController *)toController animated:(BOOL)flag completion:(void (^)(void))completion
{
    OCAbloomTransition *transition = [[OCAbloomTransition alloc] init];
    transition.fromView = self.showAlboomView;
    toController.dimissAbloomView = self.showAlboomView;
    toController.dimissFrameString = NSStringFromCGRect(self.showAlboomView.frame);
    transition.toView = toController.showAlboomView;
    [toController setTransitioningDelegate:transition];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:toController animated:flag completion:completion];
}

- (void)dimissAbloomViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion;
{
    
    OCAbloomTransition *transition = [[OCAbloomTransition alloc] init];
    transition.fromView = self.showAlboomView;
    self.dimissAbloomView = [[UIImageView alloc] initWithFrame:CGRectFromString(self.dimissFrameString)];
    self.dimissAbloomView.image = self.showAlboomView.image;
    transition.toView = self.dimissAbloomView;
    [self setTransitioningDelegate:transition];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self dismissViewControllerAnimated:YES completion:completion];
}




@end
