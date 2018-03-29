//
//  DetailViewController.m
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    NSManagedObjectContext *context;
}
@property (strong,nonatomic) NSUserDefaults *myUserDefaults;
@property (strong,nonatomic) NSArray *result;
@property (strong,nonatomic) UIButton *nameBtn;
@property (strong,nonatomic) UIButton *telBtn;
@property (strong,nonatomic) UIButton *emailBtn;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *lightBlue= [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    CGRect screen=[[UIScreen mainScreen] bounds];

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

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid = %@",self.uuid];
    request.predicate = predicate;

    self.result = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }


    


    
    // Do any additional setup after loading the view from its nib.
    UIButton *myBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 50)];
    [myBackButton setTitle:@"Back" forState:UIControlStateNormal];
    [myBackButton setTitleColor:lightBlue forState:UIControlStateNormal];
    [myBackButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myBackButton];
    UIButton *myEditButton = [[UIButton alloc] initWithFrame:CGRectMake(screen.size.width-80,20, 80, 50)];
    [myEditButton setTitle:@"Edit" forState:UIControlStateNormal];
    [myEditButton setTitleColor:lightBlue forState:UIControlStateNormal];
    [myEditButton addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myEditButton];
    self.myUserDefaults=[NSUserDefaults standardUserDefaults];
    

    /*
     for name label and button
     */
    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 80, 40)];
    nameLabel.text = @"     Name";
    //[nameLabel setBackgroundColor:lightBlue];
    [self.view addSubview:nameLabel];
    self.nameBtn=[[UIButton alloc] initWithFrame:CGRectMake(80, 100, screen.size.width-80, 40)];
    [self.nameBtn setTitle:[[self.result lastObject] valueForKey:@"name"] forState:UIControlStateNormal];
    [self.nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.nameBtn addTarget:self action:@selector(nameBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nameBtn];
    UIView *horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(15, 145, screen.size.width-30, 1)];
    horizontalLine1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:horizontalLine1];
    
    /*
     for tel label and button
     */
    UILabel *telLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 221, 80, 40)];
    telLabel.text=@"     Tel";
    [self.view addSubview:telLabel];
    //[telLabel setBackgroundColor:lightBlue];
    self.telBtn=[[UIButton alloc] initWithFrame:CGRectMake(80, 221, screen.size.width-80, 40)];
    [self.telBtn setTitle:[[self.result lastObject] valueForKey:@"tel"]  forState:UIControlStateNormal];
    [self.telBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.telBtn addTarget:self action:@selector(telBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.telBtn];
    UIView *horizontalLine3 = [[UIView alloc]initWithFrame:CGRectMake(15, 266, screen.size.width-30, 1)];
    horizontalLine3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:horizontalLine3];
    
    
    /*
     for email label and button
     */
    UILabel *emaiLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 160, 80, 40)];
    emaiLabel.text=@"     Email";
    [self.view addSubview:emaiLabel];
    self.emailBtn=[[UIButton alloc] initWithFrame:CGRectMake(80, 160, screen.size.width-80, 40)];
    [self.emailBtn setTitle:[[self.result lastObject] valueForKey:@"email"]  forState:UIControlStateNormal];
    
    [self.emailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.emailBtn addTarget:self action:@selector(emailBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.emailBtn];
    UIView *horizontalLine2 = [[UIView alloc]initWithFrame:CGRectMake(15, 205, screen.size.width-30, 1)];
    horizontalLine2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:horizontalLine2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) backButtonPressed:(id)sender{
    NSLog(@"back Button Pressed");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) editButtonPressed:(id)sender{
    NSLog(@"edit Button Pressed");
    EditViewController *editVC = [[EditViewController alloc] initWithNibName:@"EditViewController" bundle:nil];
    editVC.uuid = self.uuid;
    [self.navigationController pushViewController:editVC animated:YES];
}


/*
 for button of label pressed
 */
-(void) nameBtnPressed:(UIButton*)sender{
    UIAlertController *myDemoAlertControl = [UIAlertController alertControllerWithTitle:@"What to do" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [myDemoAlertControl addAction:[UIAlertAction actionWithTitle:@"Do sth." style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //.............
    }]];
    [myDemoAlertControl addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //.............
    }]];
    [self presentViewController:myDemoAlertControl animated:YES completion:nil];
}

/*
 for button of tel pressed
 */

-(void) telBtnPressed:(UIButton*)sender{
    UIAlertController *myDemoAlertControl2 = [UIAlertController alertControllerWithTitle:@"What to do" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [myDemoAlertControl2 addAction:[UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"] options:@{} completionHandler:^(BOOL success){
            NSLog(@"Is open success: %d",success);
        }];
    }]];
    [myDemoAlertControl2 addAction:[UIAlertAction actionWithTitle:@"Message" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://10086"] options:@{} completionHandler:^(BOOL success){
            NSLog(@"Is open success: %d",success);
        }];
    }]];
    [myDemoAlertControl2 addAction:[UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //.............
    }]];
    [self presentViewController:myDemoAlertControl2 animated:YES completion:nil];
}


/*
 for button of email pressed
 */
-(void) emailBtnPressed:(UIButton*)sender{
    UIAlertController *myDemoAlertControl3 = [UIAlertController alertControllerWithTitle:@"What to do" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [myDemoAlertControl3 addAction:[UIAlertAction actionWithTitle:@"Email" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://123123123@qq.com"] options:@{} completionHandler:^(BOOL success){
            NSLog(@"Is open success: %d",success);
        }];
    }]];
    [myDemoAlertControl3 addAction:[UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //.............
    }]];
    [self presentViewController:myDemoAlertControl3 animated:YES completion:nil];
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

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid = %@",self.uuid];
    request.predicate = predicate;

    self.result = [context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }

     [self.nameBtn setTitle:[[self.result lastObject] valueForKey:@"name"]  forState:UIControlStateNormal];
     [self.telBtn setTitle:[[self.result lastObject] valueForKey:@"tel"]  forState:UIControlStateNormal];
     [self.emailBtn setTitle:[[self.result lastObject] valueForKey:@"email"]  forState:UIControlStateNormal];
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


