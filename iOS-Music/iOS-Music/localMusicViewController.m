//
//  localMusicViewController.m
//  iOS-Music
//
//  Created by OurEDA on 2018/4/25.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "localMusicViewController.h"
@interface localMusicViewController ()

@end

@implementation localMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect screen=[[UIScreen mainScreen] bounds];
    UIBarButtonItem* backBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnPressed:)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.songTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen.size.width, screen.size.height-108) style:UITableViewStylePlain];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater=self;
    self.searchController.dimsBackgroundDuringPresentation=FALSE;
    
    self.searchController.searchBar.scopeButtonTitles = @[@"中文",@"英文"];
    self.searchController.searchBar.delegate=self;
    
    //self.songTable.tableHeaderView = self.searchController.searchBar;
    [self.searchController.searchBar sizeToFit];
    
    self.rc = [[UIRefreshControl alloc] init];
    self.rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.rc addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    self.songTable.refreshControl = self.rc;
    
    self.songTable.delegate=self;
    self.songTable.dataSource=self;
    self.songTable.rowHeight = 70;
    
    [self.view addSubview:self.songTable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        songCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell"];
        if (cell == nil) {
            cell = [[songCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"songCell"];
        }
        cell.Id = [self.songList[[indexPath row]] objectId];
        cell.nameLabel.text = [self.songList[[indexPath row]] objectForKey:@"MusicName"];
        cell.sizeLabel.text = [self.songList[[indexPath row]] objectForKey:@"MusicSize"];
        cell.infoLabel.text = [self.songList[[indexPath row]] objectForKey:@"MusicAuthor"];
        cell.moreImage.image = [UIImage imageNamed:@"更多.png"];
//    }];
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.num;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed=YES;
    songViewController *songDetail = [[songViewController alloc] init];
    songDetail.title = [self.songList[[indexPath row]] objectForKey:@"MusicName"];
    songDetail.musicId = [self.songList[[indexPath row]] objectForKey:@"MusicId"];
    
    //NSLog(@"%@",songDetail.musicId);
    NSString *url = @"http://music.163.com/song";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer     = [AFJSONRequestSerializer serializer];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:@{@"id": songDetail.musicId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];

        TFHpple *Hpple = [[TFHpple alloc]initWithHTMLData:data];
        NSArray *array =[Hpple searchWithXPathQuery:@"//img"];
        for (TFHppleElement *HppleElement in array) {
            songDetail.imageUrl = [HppleElement objectForKey:@"src"];
            NSLog(@"from localVC %@",songDetail.imageUrl);
        }
        songDetail.songId = [self.songList[[indexPath row]] objectId];
        songDetail.isLike = [self.songList[[indexPath row]] objectForKey:@"isLike"];
        songDetail.player=self.player;
        songDetail.songList = self.songList;
        songDetail.row = [indexPath row];
        songDetail.delegate=self;
        
        [self.navigationController pushViewController:songDetail animated:YES];
        self.hidesBottomBarWhenPushed=NO;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求封面失败");
        songDetail.songId = [self.songList[[indexPath row]] objectId];
        songDetail.isLike = [self.songList[[indexPath row]] objectForKey:@"isLike"];
        songDetail.player=self.player;
        songDetail.songList = self.songList;
        songDetail.row = [indexPath row];
        songDetail.delegate=self;
        [self.navigationController pushViewController:songDetail animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }];

    
}

-(void) filterContentForSearchText:(NSString *)searchText scope:(NSInteger)scope{
    if([searchText length]==0){
        self.songFiltedList = [NSMutableArray arrayWithArray:self.songList];
        return;
    }
    NSPredicate *scopePredicate;
    NSArray *tempArray;
    //NSLog(@"%@",self.songList);
    
    switch (scope) {
        case 0:
            scopePredicate = [NSPredicate predicateWithFormat:@"%K  contains[c] %@",@"\\ndata.MusicName",searchText];
            tempArray = [self.songList filteredArrayUsingPredicate:scopePredicate];
            self.songFiltedList = [NSMutableArray arrayWithArray:tempArray];
            self.num = self.songFiltedList.count;
            NSLog(@"%ld",self.num);
            NSLog(@"%@",self.songFiltedList);
            break;
        case 1:
            scopePredicate = [NSPredicate predicateWithFormat:@"%K contains[c] %@",@"data.MusicName",searchText];
            tempArray = [self.songList filteredArrayUsingPredicate:scopePredicate];
            self.songFiltedList = [NSMutableArray arrayWithArray:tempArray];
            self.num = self.songFiltedList.count;
            NSLog(@"%ld",self.num);
            NSLog(@"%@",self.songFiltedList);
            break;
        default:
            self.songFiltedList = [NSMutableArray arrayWithArray:self.songList];
            self.num = self.songFiltedList.count;
            NSLog(@"%ld",self.num);
            NSLog(@"%@",self.songFiltedList);
            break;
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    [self updateSearchResultsForSearchController:self.searchController];
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = searchController.searchBar.text;
    NSLog(@"%@", searchString);
    //NSLog(@"%@", searchController.searchBar.selectedScopeButtonIndex);
    [self filterContentForSearchText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self.songTable reloadData];
}

-(void)backBtnPressed:(id)sender{
    NSLog(@"return from localMusic");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    //reload data
    NSLog(@"localView will appear");
    UIColor *lightRed= [UIColor colorWithRed:213/255.0 green:59/255.0 blue:51/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = lightRed;
    [self refreshTable];
}

-(void)refreshTable{
    NSLog(@"refresh from %@",self.tableName);
    BmobQuery *bquery = [BmobQuery queryWithClassName:self.tableName];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        self.songList = [NSArray arrayWithArray:array];
        self.num = self.songList.count;
        [self.songTable reloadData];
        [self.rc endRefreshing];
    }];
}

//实现协议NextViewControllerDelegate中的方法

#pragma mark - NextViewControllerDelegate method

- (void)changeNum:(NSString *)tfText{
    if([self.navigationItem.title isEqualToString:@"我的收藏"]&&[tfText isEqualToString:@"YES"]){
        //self.num--;
    }
}

@end
