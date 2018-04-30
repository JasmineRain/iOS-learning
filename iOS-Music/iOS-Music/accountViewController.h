//
//  accountViewController.h
//  iOS-Music
//
//  Created by OurEDA on 2018/4/24.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "personalCell.h"

@interface accountViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *accountInfo;
@property (nonatomic,strong) UITableView *accountFunction;
@property (nonatomic,strong) NSArray *listTeams;
@end
