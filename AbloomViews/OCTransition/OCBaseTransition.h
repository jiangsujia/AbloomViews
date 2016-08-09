//
//  OCBaseTransition.h
//  ASFTransitionTest
//
//  Created by 姜苏珈 on 16/1/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OCBaseTransition : NSObject<UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>
@property (nonatomic, readwrite, assign, getter = isPresenting) BOOL presenting;

@end
