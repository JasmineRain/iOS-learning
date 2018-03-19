//
//  ViewController.h
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewContactViewController.h"
#import "DetailViewController.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDataSource>
@property (strong,nonatomic)NSArray *demoArray;
@property (strong,nonatomic) NSUserDefaults *myUserDefaults;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic,strong) NSString *boxpath;
@property (nonatomic,strong) NSMutableDictionary *boxdic;
@end

