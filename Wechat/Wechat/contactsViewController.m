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
@property(strong,nonatomic) customBtn* nf;
@property(strong,nonatomic) customBtn* gc;
@property(strong,nonatomic) customBtn* tags;
@property(strong,nonatomic) customBtn* oa;
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
    //NSLog(@"------  after sort ---------%@",self.demoArray);
    
//    UIButton *newFriends =[[UIButton alloc] initWithFrame:CGRectMake(0, 70, screen.size.width, 40)];
//    [newFriends setTitle:@"New Friends" forState:UIControlStateNormal];
//    [newFriends setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [newFriends setImage:[UIImage imageNamed:@"register.png"] forState:UIControlStateNormal];
//    newFriends.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [self.view addSubview:newFriends];
    self.nf = [[customBtn alloc] initWithFrame:CGRectMake(0, 70, screen.size.width, 50)];
    [self.nf setTitle:@"New Friends" forState:UIControlStateNormal];
    [self.nf setImage:[UIImage imageNamed:@"register.png"] forState:UIControlStateNormal];
    [self.nf addTarget:self action:@selector(nfPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nf];
    
    UIView *horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(15, 115, screen.size.width-30, 1)];
    horizontalLine1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:horizontalLine1];
  
    self.gc = [[customBtn alloc] initWithFrame:CGRectMake(0, 120, screen.size.width, 50)];
    [self.gc setTitle:@"Group Chats" forState:UIControlStateNormal];
    [self.gc setImage:[UIImage imageNamed:@"register.png"] forState:UIControlStateNormal];
    [self.gc addTarget:self action:@selector(gcPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.gc];
    UIView *horizontalLine2 = [[UIView alloc]initWithFrame:CGRectMake(15, 165, screen.size.width-30, 1)];
    horizontalLine2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:horizontalLine2];
    
    
    
    
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 180, screen.size.width, screen.size.height-100) style:UITableViewStyleGrouped];
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
    cell.imageView.image = [UIImage imageNamed:@"person.png"];
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
    //NSLog(@"****after reloading****,%@",self.demoArray);
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

-(void)nfPressed:(id)sender{
    NSLog(@"new friends button preseed");
}

-(void)gcPressed:(id)sender{
    NSLog(@"group chats button preseed");
}
@end
