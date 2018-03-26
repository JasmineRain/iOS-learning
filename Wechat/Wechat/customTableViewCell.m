//
//  customTableViewCell.m
//  Wechat
//
//  Created by OurEDA on 2018/3/25.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "customTableViewCell.h"

@implementation customTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect screen = [[UIScreen mainScreen] bounds];
        self.leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        self.leftImage.contentMode = UIViewContentModeScaleAspectFill;
        self.leftImage.clipsToBounds = YES;
        [self.leftImage.layer setCornerRadius:10];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 30)];
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, 200, 20)];
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        self.contentLabel.textColor = [UIColor grayColor];
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen.size.width - 60, 10, 50, 20)];
        self.timeLabel.font = [UIFont systemFontOfSize:15];
        self.timeLabel.textColor = [UIColor grayColor];
        [self addSubview:self.leftImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}
@end
