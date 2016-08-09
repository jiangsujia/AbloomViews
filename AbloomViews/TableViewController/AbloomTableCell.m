//
//  AbloomTableCell.m
//  AbloomViews
//
//  Created by 姜苏珈 on 16/5/11.
//  Copyright © 2016年 姜苏珈. All rights reserved.
//

#import "AbloomTableCell.h"

#define kAbloomWidth AWidth
#define kAbloomHeight AWidth/2

static const CGFloat kAbloomTopPadding = 20;
static const CGFloat kAbloomLeftPadding = 20;

@interface AbloomTableCell()
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation AbloomTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.abloomView = [[UIImageView alloc] initWithFrame:CGRectMake(kAbloomLeftPadding, kAbloomTopPadding, kAbloomWidth - 2*kAbloomLeftPadding, kAbloomHeight)];
    self.abloomView.clipsToBounds = YES;
    self.abloomView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.abloomView];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kAbloomLeftPadding, CGRectGetMaxY(self.abloomView.frame) + kAbloomTopPadding, AWidth - 40, 30)];
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.contentLabel];
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    _infoDic = infoDic;
    self.abloomView.image = [UIImage imageNamed:infoDic[@"image"]];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",infoDic[@"content"]];
}


+ (CGFloat)heightOfContent:(NSDictionary *)dictionary {
    CGFloat height = 0;
    height = kAbloomTopPadding + kAbloomHeight + kAbloomTopPadding + 30;
    return height;
}
@end
