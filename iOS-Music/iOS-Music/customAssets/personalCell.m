//
//  personalCell.m
//  iOS-Music
//
//  Created by OurEDA on 2018/4/25.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "personalCell.h"

@implementation personalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        CGRect screen = [[UIScreen mainScreen] bounds];
        self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        self.avatar.contentMode = UIViewContentModeScaleAspectFill;
        self.avatar.clipsToBounds = YES;
        [self.avatar.layer setCornerRadius:25];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, 200, 30)];
        self.levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, 200, 20)];
        self.levelLabel.font = [UIFont systemFontOfSize:15];
        self.levelLabel.textColor = [UIColor grayColor];
        UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(10, 75, screen.size.width-20, 1)];
        divider.backgroundColor = [UIColor grayColor];
        
        self.activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, (screen.size.width)/3, 15)];
        self.activityLabel.font = [UIFont systemFontOfSize:15];
        self.activityLabel.textColor = [UIColor grayColor];
        self.activityNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 105, (screen.size.width)/3, 15)];
        self.activityNumber.font = [UIFont systemFontOfSize:15];
        self.activityLabel.textAlignment = NSTextAlignmentCenter;
        self.activityNumber.textAlignment = NSTextAlignmentCenter;
        
        self.followLabel = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width)/3, 85, (screen.size.width)/3, 15)];
        self.followLabel.font = [UIFont systemFontOfSize:15];
        self.followLabel.textColor = [UIColor grayColor];
        self.followNumber = [[UILabel alloc] initWithFrame:CGRectMake((screen.size.width)/3, 105, (screen.size.width)/3, 15)];
        self.followNumber.font = [UIFont systemFontOfSize:15];
        self.followLabel.textAlignment = NSTextAlignmentCenter;
        self.followNumber.textAlignment = NSTextAlignmentCenter;
        
        self.fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*(screen.size.width)/3, 85, (screen.size.width)/3, 15)];
        self.fansLabel.font = [UIFont systemFontOfSize:15];
        self.fansLabel.textColor = [UIColor grayColor];
        self.fansNumber = [[UILabel alloc] initWithFrame:CGRectMake(2*(screen.size.width)/3, 105, (screen.size.width)/3, 15)];
        self.fansNumber.font = [UIFont systemFontOfSize:15];
        self.fansLabel.textAlignment = NSTextAlignmentCenter;
        self.fansNumber.textAlignment = NSTextAlignmentCenter;
        
        UIView *divider2 = [[UIView alloc] initWithFrame:CGRectMake(10, 135, screen.size.width-20, 1)];
        divider2.backgroundColor = [UIColor redColor];

        [self addSubview:self.nameLabel];
        [self addSubview:self.levelLabel];
        [self addSubview:self.avatar];
        [self addSubview:divider];
        [self addSubview:self.activityLabel];
        [self addSubview:self.activityNumber];
        [self addSubview:self.followLabel];
        [self addSubview:self.followNumber];
        [self addSubview:self.fansLabel];
        [self addSubview:self.fansNumber];
        [self addSubview:divider2];
    }
    
    return self;
}

@end
