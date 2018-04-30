//
//  personalCell.h
//  iOS-Music
//
//  Created by OurEDA on 2018/4/25.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personalCell : UITableViewCell
@property(strong, nonatomic) UILabel *nameLabel;
@property(strong, nonatomic) UIImageView *avatar;
@property(strong, nonatomic) UILabel *levelLabel;
@property(strong, nonatomic) UILabel *activityLabel;
@property(strong, nonatomic) UILabel *followLabel;
@property(strong, nonatomic) UILabel *fansLabel;
@property(strong, nonatomic) UILabel *activityNumber;
@property(strong, nonatomic) UILabel *followNumber;
@property(strong, nonatomic) UILabel *fansNumber;

@end
