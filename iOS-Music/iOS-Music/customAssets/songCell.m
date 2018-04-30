//
//  songCell.m
//  iOS-Music
//
//  Created by OurEDA on 2018/4/30.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "songCell.h"

@implementation songCell

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
    CGRect screen = [[UIScreen mainScreen] bounds];
    if(self){
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
        self.sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 80, 20)];
        self.sizeLabel.font = [UIFont systemFontOfSize:15];
        self.sizeLabel.textColor = [UIColor grayColor];
        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, 200, 20)];
        self.infoLabel.font = [UIFont systemFontOfSize:15];
        self.infoLabel.textColor = [UIColor grayColor];
        self.moreImage = [[UIImageView alloc] initWithFrame:CGRectMake(screen.size.width-40, 15, 32, 32)];
        self.moreImage.contentMode = UIViewContentModeScaleAspectFill;
        self.moreImage.clipsToBounds = YES;
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.sizeLabel];
        [self addSubview:self.infoLabel];
        [self addSubview:self.moreImage];
    }
    
    
    
    return self;
}

@end
