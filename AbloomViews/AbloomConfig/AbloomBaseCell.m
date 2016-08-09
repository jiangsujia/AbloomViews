//
//  AbloomBaseCell.m
//  AbloomViews
//
//  Created by 姜苏珈 on 16/5/11.
//  Copyright © 2016年 姜苏珈. All rights reserved.
//

#import "AbloomBaseCell.h"
@interface AbloomBaseCell ()

@end
@implementation AbloomBaseCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
