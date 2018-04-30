//
//  accountViewController.m
//  iOS-Music
//
//  Created by OurEDA on 2018/4/24.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "accountViewController.h"
#define CellIdentifier @"CellIdentifier"
@interface accountViewController ()

@end

@implementation accountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect screen=[[UIScreen mainScreen] bounds];
    self.accountInfo=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, screen.size.width, 130) style:UITableViewStylePlain];
    self.accountInfo.dataSource=self;
    self.accountInfo.delegate=self;
    self.accountInfo.scrollEnabled = NO;
    self.accountInfo.rowHeight = 130;
    [self.view addSubview:self.accountInfo];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"accountFunctionList" ofType:@"plist"];
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    self.accountFunction = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, screen.size.width, screen.size.height-258) style:UITableViewStylePlain];
    self.accountFunction.dataSource=self;
    self.accountFunction.delegate=self;
    self.accountFunction.rowHeight=60;
    self.accountFunction.scrollEnabled = NO;
    [self.view addSubview:self.accountFunction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:self.accountInfo]){
        personalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cusCell"];
        if (cell == nil) {
            cell = [[personalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cusCell"];
        }
        //    NSInteger rowIndex=[indexPath row];
        cell.avatar.image = [UIImage imageNamed:@"dog.png"];
        cell.nameLabel.text = @"轻寒戏雨";
        cell.levelLabel.text = @"Lv:8";
        cell.activityLabel.text = @"动态";
        cell.activityNumber.text = @"6";
        cell.followLabel.text = @"关注";
        cell.followNumber.text = @"6";
        cell.fansLabel.text = @"粉丝";
        cell.fansNumber.text = @"6";
        return cell;
    }else{
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
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([tableView isEqual:self.accountInfo])
        return 1;
    else{
        return [self.listTeams count];
    }
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
