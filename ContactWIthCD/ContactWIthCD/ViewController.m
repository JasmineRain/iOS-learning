//
//  ViewController.m
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "ViewController.h"
#import "sort.h"
#import "Person+CoreDataClass.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSManagedObjectContext *context;
}
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

    NSError *error = nil;
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingString:@"Person.sqlite"]];
    
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) {
        [NSException raise:@"DB Error" format:@"%@", [error localizedDescription]];
    }
    
    context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = psc;
//-------------------
    NSManagedObject *s1 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [s1 setValue:@"小明" forKey:@"name"];
    [s1 setValue:@"001" forKey:@"uid"];
    [s1 setValue:@"ssdut@EXAMPLE.com" forKey:@"email"];
    [s1 setValue:@"1234235433" forKey:@"tel"];

    if ([context save:&error]) {
        NSLog(@"Succeed!");
    } else {
        [NSException raise:@"插入错误" format:@"%@", [error localizedDescription]];
    }
    
    NSManagedObject *s2 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [s2 setValue:@"明小" forKey:@"name"];
    [s2 setValue:@"002" forKey:@"uid"];
    [s2 setValue:@"ssdut@EXAMPLE.com" forKey:@"email"];
    [s2 setValue:@"1234235433" forKey:@"tel"];
    
    if ([context save:&error]) {
        NSLog(@"Succeed!");
    } else {
        [NSException raise:@"插入错误" format:@"%@", [error localizedDescription]];
    }
    
//--------------------
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid LIKE '*'"];
    request.predicate = predicate;
    
    self.demoArray = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    //-------------------------
    self.demoArray = [self.demoArray arrayWithPinYinFirstLetterFormat];
    NSLog(@"------  after sort ---------%@",self.demoArray);
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
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reusableFlag];
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseflag"];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusableFlag];
        
        NSLog(@"______");
    }
    NSDictionary *dict = self.demoArray[indexPath.section];
    NSMutableArray *array = dict[@"content"];
    cell.textLabel.text=[[array objectAtIndex:[indexPath row] ] valueForKey:@"Name"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.demoArray count];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dict = self.demoArray[section];
    NSMutableArray *array = dict[@"content"];
    return [array count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSInteger selectedIndex=[indexPath row];
    NSDictionary *dict = self.demoArray[indexPath.section];
    NSMutableArray *array = dict[@"content"];
    DetailViewController *detail=[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detail.uuid = [[array objectAtIndex:[indexPath row]] valueForKey:@"uid"];
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
    NSError *error = nil;
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingString:@"Person.sqlite"]];

    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) {
        [NSException raise:@"DB Error" format:@"%@", [error localizedDescription]];
    }

    context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = psc;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid LIKE '*'"];
    request.predicate = predicate;

    self.demoArray = [context executeFetchRequest:request error:&error];
    NSLog(@"%ld",self.demoArray.count);
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
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



