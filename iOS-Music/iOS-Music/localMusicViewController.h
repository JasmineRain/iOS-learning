//
//  localMusicViewController.h
//  iOS-Music
//
//  Created by OurEDA on 2018/4/25.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "songCell.h"
#import <BmobSDK/Bmob.h>
#import "songViewController.h"
@interface localMusicViewController : UIViewController<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)NSArray *songList;
@property(strong,nonatomic)NSArray *songFiltedList;
@property(strong,nonatomic)UITableView *songTable;
@property(strong,nonatomic)UISearchController *searchController;
@property NSInteger num;
@end
