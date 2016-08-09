//
//  UIViewController+Transition.h
//  ASFTransitionTest
//
//  Created by 姜苏珈 on 16/1/4.
//  Copyright © 2016年  Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIViewController (Transition)

@property (nonatomic, strong, nonnull) UIImageView  *  showAlboomView;

@property (nonatomic, strong, nonnull) UIImageView  *  dimissAbloomView;

@property (nonatomic, strong, nonnull) NSString *  dimissFrameString;

/**
 *  展示PresentAbloomViewController之前 为present创建showAbloomView （针对于Table）
 *
 *  @param tableView tableView
 *  @param indexPath 行数
 *
 *  @return
 */
- (UIImageView *__nonnull)transitionViewByTableView:(UITableView *__nonnull)tableView indexPath:(NSIndexPath *__nonnull)indexPath;

/**
 *  展示
 *
 *  @param toController 将要展示的VC
 *  @param flag
 *  @param completion
 */
- (void)presentAbloomViewController:(UIViewController *__nonnull)toController animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;

/**
 *  消失
 *
 *  @param flag
 *  @param completion
 */
- (void)dimissAbloomViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion;
@end
