//
//  discoverViewController.m
//  Wechat
//
//  Created by OurEDA on 2018/3/21.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "discoverViewController.h"

@interface discoverViewController ()

@end

@implementation discoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view.
   // self.view.backgroundColor = [UIColor greenColor];
    //self.title= @"Wechat(99+)";
    //self.navigationController.tabBarItem.title = @"Discover";
    //self.tabBarItem.title = @"Discover";
    CGRect screen=[[UIScreen mainScreen] bounds];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height-44) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.rowHeight = 55;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *reuseFlag = @"reuseableFlag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseFlag];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseFlag];
        NSLog(@"%ld", [indexPath row]);
    }
    cell.textLabel.text = @"coments";
    cell.imageView.image = [UIImage imageNamed:@"moments.png"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger selectedIndex = [indexPath row];
    NSLog(@"click %ld", selectedIndex);
}

@end
