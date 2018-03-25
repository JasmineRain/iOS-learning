//
//  meViewController.h
//  Wechat
//
//  Created by OurEDA on 2018/3/21.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customTableViewCell.h"
@interface meViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *tableView2;
@end
