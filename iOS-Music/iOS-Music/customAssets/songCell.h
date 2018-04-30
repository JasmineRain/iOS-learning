//
//  songCell.h
//  iOS-Music
//
//  Created by OurEDA on 2018/4/30.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface songCell : UITableViewCell
@property(strong, nonatomic) UILabel *nameLabel;
@property(strong, nonatomic) UIImageView *moreImage;
@property(strong, nonatomic) UILabel *sizeLabel;
@property(strong, nonatomic) UILabel *infoLabel;
@property NSString* Id;
@end
