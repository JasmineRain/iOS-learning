//
//  ViewController.m
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "ViewController.h"
#import "sort.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIColor *lightBlue= [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    self.myUserDefaults=[NSUserDefaults standardUserDefaults];
    CGRect screen=[[UIScreen mainScreen] bounds];
    /*
     for table view
     */
    NSBundle *bundle=[NSBundle mainBundle];
    NSString *plistPath=[bundle pathForResource:@"Contacts"ofType:@"plist"];
    self.dict=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.boxpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Contacts.plist"];
    [self.dict writeToFile:self.boxpath atomically:YES];
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    
    self.demoArray=[self.boxdic allValues];
    //---------
    self.demoArray = [self.demoArray arrayWithPinYinFirstLetterFormat];
    //NSLog(@"%@",self.demoArray);
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 80, screen.size.width, screen.size.height-100) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /*
     for the button
     */
    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(screen.size.width-80,20, 80, 50)];
    [self.addBtn setTitle:@"Add" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:lightBlue forState:UIControlStateNormal];
    //[self.addBtn setBackgroundColor:[UIColor greenColor]];
    
    [self.addBtn addTarget:self action:@selector(addContactsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
}


/*
 events for Add button pressed
 */
-(void) addContactsButtonPressed:(id)sender{
    NSLog(@"Add button pressed.");
    NewContactViewController *myNewContactVC=[[NewContactViewController alloc] init];
    [self.navigationController pushViewController:myNewContactVC animated:YES];
}


-(nonnull UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reusableFlag=@"resuableFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reusableFlag];
    //    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseflag"];
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
    if (section == 0) {
        return 1;
    } else {
        NSDictionary *dict = self.demoArray[section];
        NSMutableArray *array = dict[@"content"];
        return [array count];
    }
}

//----------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSInteger selectedIndex=[indexPath row];
    NSDictionary *dict = self.demoArray[indexPath.section];
    NSMutableArray *array = dict[@"content"];
    DetailViewController *detail=[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detail.uuid = [[array objectAtIndex:[indexPath row]] objectForKey:@"UUID"];
    //detail.uuid=[[self.demoArray objectAtIndex:selectedIndex] objectForKey:@"UUID"];
    //NSLog(@"%@",detail.uuid);
    [self.navigationController pushViewController:detail animated:YES];
    //    NSLog(@"selected index: %ld",selectedIndex+1);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    self.demoArray=[self.boxdic allValues];
    self.demoArray = [self.demoArray arrayWithPinYinFirstLetterFormat];
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

@end


