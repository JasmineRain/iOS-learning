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
    
    UIColor *lightGrey= [UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:1];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"functionList" ofType:@"plist"];
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    
    self.functionList = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen.size.width, 290) style:UITableViewStylePlain];
    self.functionList.rowHeight = 70;
    self.functionList.scrollEnabled=NO;
    self.functionList.delegate=self;
    self.functionList.dataSource=self;
    [self.view addSubview:self.functionList];
    
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Music"];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.num = [array count];
        //NSLog(@"%ld",num);
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
    localMusicVC.title = @"本地音乐";
    localMusicVC.num=self.num;
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:localMusicVC animated:YES];
            break;
        default:
            break;
    }
}


- (void)viewWillAppear:(BOOL)animated{
//    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
//    self.demoArray=[self.boxdic allValues];
//    self.demoArray = [self.demoArray arrayWithPinYinFirstLetterFormat];
//    NSLog(@"****after reloading****,%@",self.demoArray);
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"functionList" ofType:@"plist"];
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    [self.functionList reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
