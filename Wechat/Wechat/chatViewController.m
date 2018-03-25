//
//  chatViewController.m
//  Wechat
//
//  Created by OurEDA on 2018/3/21.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "chatViewController.h"

@interface chatViewController ()

@end

@implementation chatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view.

    CGRect screen=[[UIScreen mainScreen] bounds];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, screen.size.width, screen.size.height-100) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    customTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cusCell"];
    if (cell == nil) {
        cell = [[customTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cusCell"];
    }
    //    NSInteger rowIndex=[indexPath row];
    cell.leftImage.image = [UIImage imageNamed:@"group-o.png"];
    cell.leftImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.titleLabel.text = @"ID here";
    cell.contentLabel.text = @"Content here";
    cell.timeLabel.text = @"time";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
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
