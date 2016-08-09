//
//  AbloomTableCell.h
//  AbloomViews
//
//  Created by 姜苏珈 on 16/5/11.
//  Copyright © 2016年 姜苏珈. All rights reserved.
//

#import "AbloomBaseCell.h"

@interface AbloomTableCell : AbloomBaseCell
@property (nonatomic, strong) NSDictionary *infoDic;
+ (CGFloat)heightOfContent:(NSDictionary *)dictionary;
@end
