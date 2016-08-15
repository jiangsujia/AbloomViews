//
//  AbloomDismissViewController.m
//  AbloomViews
//
//  Created by 姜苏珈 on 16/8/9.
//  Copyright © 2016年 姜苏珈. All rights reserved.
//

#import "AbloomDismissViewController.h"
#import "UIViewController+Transition.h"
@interface AbloomDismissViewController()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *returnButton;
@property (nonatomic, strong) UIImage *shownImage;
@property (nonatomic, strong) UILabel *textLabel;
@end
@implementation AbloomDismissViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildUI];

}

- (instancetype)initWithShownmage:(UIImage *)image {
    if (self = [super init]) {
        _shownImage = image;
        //注意 请将需要展示的View放到这里在创建 在并没有ViewDidload的时候 我们需要获取到showAbloomView的高度和宽度，以及image
        self.showAlboomView = [[UIImageView alloc] init];
        self.showAlboomView.clipsToBounds = YES;
        self.showAlboomView.contentMode = UIViewContentModeScaleAspectFill;
        
        if (_shownImage) {
            CGSize imageSize = _shownImage.size;
            CGFloat scale = imageSize.width / imageSize.height;
            CGFloat height = AWidth / scale;
            self.showAlboomView.frame = CGRectMake(0, 0, AWidth, height);
            self.showAlboomView.image = _shownImage;
        }
    }
    return self;
}

- (void)buildUI {
 
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, AWidth, AHeight)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    [_scrollView addSubview:self.showAlboomView];
    
    UIImage *returnImage = [UIImage imageNamed:@"dismissViewReturn"];
    _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_returnButton setImage:returnImage forState:UIControlStateNormal];
    [_returnButton setImageEdgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    [_returnButton addTarget:self action:@selector(actionReturn:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_returnButton];
    
    _returnButton.frame = CGRectMake(0, 30, returnImage.size.width*0.75 + 40, returnImage.size.height*0.75 + 40);
    
    NSString *text = @"所有要求对方容纳你的任性和坏脾气以及必须满足各种要求的女孩子，最后会吃很大的苦头。期待对方一生只爱你一个人的，也会吃苦。女人最好有一半要活得像个男人。像他们一样不把情爱当做生命唯一源泉，而要做些更重要的事。像他们一样习惯承担和付出。像他们一样运用理性。像他们一样习惯孤独天性自由";
    _textLabel = [[UILabel alloc] init];
    _textLabel.text = text;
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.font = [UIFont systemFontOfSize:14];
    _textLabel.numberOfLines = 0;
    _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_scrollView addSubview:_textLabel];
    
    CGSize sizeOfText = [text boundingRectWithSize:CGSizeMake(AWidth - 60, AHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil ] context:nil].size;
    _textLabel.frame = CGRectMake(30, CGRectGetMaxY(self.showAlboomView.frame), sizeOfText.width, sizeOfText.height);
    _scrollView.contentSize = CGSizeMake(AWidth, CGRectGetMaxY(_textLabel.frame));
}

- (void)actionReturn:(id)sender {
    [self dimissAbloomViewControllerAnimated:YES completion:nil];
}


@end
