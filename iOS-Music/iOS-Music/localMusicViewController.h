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
#import <AFNetworking.h>
#import "TFHpple.h"
@interface localMusicViewController : UIViewController<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,NextViewControllerDelegate>

@property(strong,nonatomic)NSArray *songList;
@property(strong,nonatomic)NSString *tableName;
@property(strong,nonatomic)NSArray *songFiltedList;
@property(strong,nonatomic)UITableView *songTable;
@property (nonatomic, strong)AVPlayer *player;
@property(strong,nonatomic)UISearchController *searchController;
@property(strong,nonatomic)UIRefreshControl *rc;
@property NSInteger num;

-(void) filterContentForSearchText:(NSString*)searchText scope:(NSInteger)scope;
@end
