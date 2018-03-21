//
//  contactsViewController.m
//  Wechat
//
//  Created by OurEDA on 2018/3/21.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "contactsViewController.h"
#import "sort.h"
@interface contactsViewController ()

@end

@implementation contactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor blueColor];
    //self.title= @"Wechat(99+)";
    //self.navigationController.tabBarItem.title = @"Contacts";
    //self.tabBarItem.title = @"Contacts";
    CGRect screen=[[UIScreen mainScreen] bounds];
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *plistPath=[bundle pathForResource:@"Contacts"ofType:@"plist"];
    self.dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.boxpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Contacts.plist"];
    [self.dict writeToFile:self.boxpath atomically:YES];
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    
    self.demoArray=[self.boxdic allValues];
    self.demoArray = [self.demoArray arrayWithPinYinFirstLetterFormat];
    NSLog(@"------  after sort ---------%@",self.demoArray);
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 80, screen.size.width, screen.size.height-100) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.sectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(nonnull UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reusableFlag=@"resuableFlag";
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reusableFlag];
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseflag"];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableFlag];
        
        NSLog(@"______");
    }
    NSDictionary *dict = self.demoArray[indexPath.section];
    NSMutableArray *array = dict[@"content"];
    cell.textLabel.text=[[array objectAtIndex:[indexPath row] ] objectForKey:@"Name"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.demoArray count];
}

//-------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if (section == 0) {
    //        return 1;
    //    } else {
    //        NSDictionary *dict = self.demoArray[section];
    //        NSMutableArray *array = dict[@"content"];
    //        return [array count];
    //    }
    NSDictionary *dict = self.demoArray[section];
    NSMutableArray *array = dict[@"content"];
    return [array count];
}


- (void)viewWillAppear:(BOOL)animated{
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    self.demoArray=[self.boxdic allValues];
    self.demoArray = [self.demoArray arrayWithPinYinFirstLetterFormat];
    NSLog(@"****after reloading****,%@",self.demoArray);
    [self.tableView reloadData];
}

//添加TableView头视图标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSDictionary *dict = self.demoArray[section];
    NSString *title = dict[@"firstLetter"];
    return title;
}


//添加索引栏标题数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *resultArray = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
    for (NSDictionary *dict in self.demoArray) {
        NSString *title = dict[@"firstLetter"];
        [resultArray addObject:title];
    }
    return resultArray;
}


//点击索引栏标题时执行
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
    if ([title isEqualToString:UITableViewIndexSearch]) {
        [tableView setContentOffset:CGPointZero animated:NO];//tabview移至顶部
        return NSNotFound;
    } else {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index] - 1; // -1 添加了搜索标识
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
