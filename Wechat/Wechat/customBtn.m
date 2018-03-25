//
//  customBtn.m
//  Wechat
//
//  Created by OurEDA on 2018/3/25.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "customBtn.h"

@implementation customBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//+ (instancetype)buttonWithType:(UIButtonType)buttonType{
//    customBtn *cusbtn = [super buttonWithType:buttonType];
//    if(cusbtn){
//        cusbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        // 开启button的imageView的剪裁属性，根据imageView的contentMode属性选择是否开启
//        cusbtn.imageView.layer.masksToBounds = YES;
//        cusbtn.layer.masksToBounds = YES;
//        self = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
//
//
//    }
//
//    return cusbtn;
//}

+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        //self.titleLabel.textColor = [UIColor blackColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    NSLog(@"%@",self);
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageY = 0;
    CGFloat imageX = 15;
    CGFloat imageW = 40;
    CGFloat imageH = 40;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = 15;
    CGFloat titleW = 200;
    CGFloat titleX = 61;
    CGFloat titleH = 15;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
