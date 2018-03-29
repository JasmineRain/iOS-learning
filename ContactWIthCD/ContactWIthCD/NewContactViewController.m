//
//  NewContactViewController.m
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "NewContactViewController.h"

@interface NewContactViewController ()<UITextFieldDelegate>
{
    NSManagedObjectContext *context;
}
@property (strong,nonatomic) NSUserDefaults *myUserDefaults;
@end

@implementation NewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *lightBlue= [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    // Do any additional setup after loading the view from its nib.
    CGRect screen=[[UIScreen mainScreen] bounds];
    UIButton *myBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 50)];
    //    [myBackButton setBackgroundColor:[UIColor yellowColor]];
    [myBackButton setTitle:@"Back" forState:UIControlStateNormal];
    [myBackButton setTitleColor:lightBlue forState:UIControlStateNormal];
    [myBackButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myBackButton];
    UIButton *myFinishButton = [[UIButton alloc] initWithFrame:CGRectMake(screen.size.width-80, 20, 80, 50)];
    //    [myFinishButton setBackgroundColor:[UIColor greenColor]];
    [myFinishButton setTitle:@"Finish" forState:UIControlStateNormal];
    [myFinishButton setTitleColor:lightBlue forState:UIControlStateNormal];
    [myFinishButton addTarget:self action:@selector(finishButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myFinishButton];
    self.myUserDefaults=[NSUserDefaults standardUserDefaults];
    
    UILabel *Name=[[UILabel alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
    Name.text=@"Name";
    [self.view addSubview:Name];
    UILabel *Email=[[UILabel alloc] initWithFrame:CGRectMake(20, 170, 50, 50)];
    Email.text=@"Email";
    [self.view addSubview:Email];
    UILabel *PhoneNumber=[[UILabel alloc] initWithFrame:CGRectMake(20, 240, 50, 50)];
    PhoneNumber.text=@"Phone";
    [self.view addSubview:PhoneNumber];
    UITextField *name=[[UITextField alloc] initWithFrame:CGRectMake(80, 100, screen.size.width-100, 50)];
    name.borderStyle=UITextBorderStyleRoundedRect;
    [name setTag:1];
    name.delegate=self;
    [self.view addSubview:name];
    UITextField *email=[[UITextField alloc] initWithFrame:CGRectMake(80, 170, screen.size.width-100, 50)];
    email.borderStyle=UITextBorderStyleRoundedRect;
    [email setTag:2];
    email.delegate=self;
    [self.view addSubview:email];
    UITextField *phoneNumber=[[UITextField alloc] initWithFrame:CGRectMake(80, 240, screen.size.width-100, 50)];
    phoneNumber.borderStyle=UITextBorderStyleRoundedRect;
    [phoneNumber setTag:3];
    phoneNumber.delegate=self;
    [self.view addSubview:phoneNumber];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) backButtonPressed:(id)sender{
    NSLog(@"back Button Pressed");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) finishButtonPressed:(id)sender{
    NSLog(@"finish Button Pressed");
    UITextField *name = [self.view viewWithTag:1];
    UITextField *email = [self.view viewWithTag:2];
    UITextField *tel = [self.view viewWithTag:3];

    NSString *uuid = [NSUUID UUID].UUIDString;
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

    NSManagedObject *s1 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [s1 setValue:name.text forKey:@"name"];
    [s1 setValue:uuid forKey:@"uid"];
    [s1 setValue:email.text forKey:@"email"];
    [s1 setValue:tel.text forKey:@"tel"];
    if ([context save:&error]) {
        NSLog(@"Succeed!");
    } else {
        [NSException raise:@"插入错误" format:@"%@", [error localizedDescription]];
    }
    [self.navigationController popViewControllerAnimated:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return TRUE;
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


