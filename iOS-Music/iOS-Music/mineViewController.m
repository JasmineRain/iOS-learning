//
//  mineViewController.m
//  iOS-Music
//
//  Created by OurEDA on 2018/4/24.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "mineViewController.h"

#define CellIdentifier @"CellIdentifier"

@interface mineViewController ()

@end

@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect screen=[[UIScreen mainScreen] bounds];
    self.player = [[AVPlayer alloc]init];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"functionList" ofType:@"plist"];
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    
    self.functionList = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen.size.width, 290) style:UITableViewStylePlain];
    self.functionList.rowHeight = 70;
    self.functionList.scrollEnabled=NO;
    self.functionList.delegate=self;
    self.functionList.dataSource=self;
    [self.view addSubview:self.functionList];
    
    //for all list
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Music"];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.songNum = [array count];
        self.songList = [NSArray arrayWithArray:array];
    }];
    
    //for like list
    BmobQuery *bquery2 = [BmobQuery queryWithClassName:@"Like"];
    bquery2.cachePolicy = kBmobCachePolicyNetworkElseCache;
    [bquery2 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.likeNum = [array count];
        self.likeList = [NSArray arrayWithArray:array];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listTeams count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    
    NSDictionary *rowDict = self.listTeams[row];
    cell.textLabel.text = rowDict[@"name"];
    NSString *imagePath = [[NSString alloc] initWithFormat:@"%@.png",rowDict[@"image"]];
    cell.imageView.image = [UIImage imageNamed:imagePath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    localMusicViewController* localMusicVC = [[localMusicViewController alloc] init];
    localMusicVC.player=self.player;
    if(indexPath.row==0){
        localMusicVC.title = @"本地音乐";
        localMusicVC.num=self.songNum;
        localMusicVC.songList = [NSArray arrayWithArray:self.songList];
        localMusicVC.tableName=@"Music";
    }
    if(indexPath.row==3){
        localMusicVC.title = @"我的收藏";
        localMusicVC.num=self.likeNum;
        localMusicVC.songList = [NSArray arrayWithArray:self.likeList];
        localMusicVC.tableName=@"Like";
    }
    switch (indexPath.row) {
        case 0:
            NSLog(@"enter with tablename %ld",indexPath.row);
            [self.navigationController pushViewController:localMusicVC animated:YES];
            break;
        case 3:
            NSLog(@"enter with tablename %ld",indexPath.row);
            [self.navigationController pushViewController:localMusicVC animated:YES];
//            BmobQuery *bquery2 = [BmobQuery queryWithClassName:@"Like"];
//            bquery2.cachePolicy = kBmobCachePolicyNetworkElseCache;
//            [bquery2 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                self.likeNum = [array count];
//                self.likeList = [NSArray arrayWithArray:array];
//            }];
            break;
    }
}


- (void)viewWillAppear:(BOOL)animated{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"functionList" ofType:@"plist"];
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    [self.functionList reloadData];
    BmobQuery *bquery2 = [BmobQuery queryWithClassName:@"Like"];
    bquery2.cachePolicy = kBmobCachePolicyNetworkElseCache;
    [bquery2 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.likeNum = [array count];
        self.likeList = [NSArray arrayWithArray:array];
    }];
    
}

@end
