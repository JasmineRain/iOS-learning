//
//  customTableViewCell.h
//  Wechat
//
//  Created by OurEDA on 2018/3/25.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTableViewCell : UITableViewCell
@property(strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) UILabel *contentLabel;
@property(strong, nonatomic) UIImageView *leftImage;
@property(strong, nonatomic) UILabel *timeLabel;
@end
