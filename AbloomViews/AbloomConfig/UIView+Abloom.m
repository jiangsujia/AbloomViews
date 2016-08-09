//
//  UIView+Abloom.m
//  AbloomViews
//
//  Created by 姜苏珈 on 16/5/11.
//  Copyright © 2016年 姜苏珈. All rights reserved.
//

#import "UIView+Abloom.h"
#import <objc/runtime.h>
static const void *AbloomDefaultKey = &AbloomDefaultKey;

@implementation UIView (Abloom)
@dynamic abloomView;

- (UIImageView *)abloomView {
    return objc_getAssociatedObject(self, AbloomDefaultKey);
}

- (void)setAbloomView:(UIImageView *)abloomView {
    objc_setAssociatedObject(self, AbloomDefaultKey, abloomView, OBJC_ASSOCIATION_RETAIN);
}

@end
