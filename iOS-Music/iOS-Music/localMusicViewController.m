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
    self.songTable.tableHeaderView = self.searchController.searchBar;
    [self.searchController.searchBar sizeToFit];
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
        //    NSInteger rowIndex=[indexPath row];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Music"];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        cell.Id = [array[[indexPath row]] objectId];
        cell.nameLabel.text = [array[[indexPath row]] objectForKey:@"MusicName"];
        cell.sizeLabel.text = [array[[indexPath row]] objectForKey:@"MusicSize"];
        cell.infoLabel.text = [array[[indexPath row]] objectForKey:@"MusicAuthor"];
        cell.moreImage.image = [UIImage imageNamed:@"更多.png"];
    }];
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.num;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    songViewController *songDetail = [[songViewController alloc] init];
    [self.navigationController pushViewController:songDetail animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)backBtnPressed:(id)sender{
    NSLog(@"return from localMusic");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
