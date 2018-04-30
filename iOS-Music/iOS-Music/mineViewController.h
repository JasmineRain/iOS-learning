//
//  mineViewController.h
//  iOS-Music
//
//  Created by OurEDA on 2018/4/24.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "localMusicViewController.h"
#import <BmobSDK/Bmob.h>
@interface mineViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *functionList;
@property (nonatomic,strong) UITableView *songMenu;
@property (nonatomic,strong) NSArray *listTeams;
@property NSInteger num;
@end
