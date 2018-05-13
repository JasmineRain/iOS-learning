//
//  UIImage.m
//  iOS-Music
//
//  Created by OurEDA on 2018/5/8.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "UIImage.h"

@implementation UIImageScale

- (UIImage *)TransformtoSize:(UIImage *)img size:(CGSize)newsize{
    
    UIGraphicsBeginImageContext(newsize);
    
    [self drawInRect:CGRectMake(0,0, newsize.width, newsize.height)];
    
    
    UIImage*TransformedImg=UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    
    returnTransformedImg;
}

@end
