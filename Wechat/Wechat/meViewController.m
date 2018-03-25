//
//  meViewController.m
//  Wechat
//
//  Created by OurEDA on 2018/3/21.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "meViewController.h"

@interface meViewController ()

@end

@implementation meViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor purpleColor];
    //self.title= @"Wechat(99+)";
    //self.navigationController.tabBarItem.title = @"Me";
    //self.tabBarItem.title = @"Me";
    CGRect screen=[[UIScreen mainScreen] bounds];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, screen.size.width, 80) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.rowHeight = 70;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    
    
    self.tableView2=[[UITableView alloc]initWithFrame:CGRectMake(0, 150, screen.size.width, screen.size.height-100) style:UITableViewStyleGrouped];
    self.tableView2.dataSource=self;
    self.tableView2.delegate=self;
    self.tableView2.sectionHeaderHeight = 5;
    self.tableView2.rowHeight = 55;
    self.tableView2.scrollEnabled = NO;
    [self.view addSubview:self.tableView2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    if([tableView isEqual:self.tableView]){
        customTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cusCell"];
        if (cell == nil) {
            cell = [[customTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cusCell"];
        }
        //    NSInteger rowIndex=[indexPath row];
        cell.leftImage.image = [UIImage imageNamed:@"group-o.png"];
        cell.leftImage.contentMode = UIViewContentModeScaleAspectFill;
        cell.titleLabel.text = @"Wolverine";
        cell.contentLabel.text = @"weixinhao here";
        cell.timeLabel.text = @"QR";
        return cell;
    }
    else{
        static NSString *reuseFlag = @"reuseableFlag";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseFlag];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseFlag];
            NSLog(@"%ld", [indexPath row]);
        }
        cell.textLabel.text = @"settings";
        cell.imageView.image = [UIImage imageNamed:@"moments.png"];
        return cell;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([tableView isEqual:self.tableView])
        return 1;
    else
        return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual:self.tableView])
        return 1;
    else
        return 2;
}

@end
