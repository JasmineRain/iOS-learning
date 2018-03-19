//
//  NewContactViewController.m
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "NewContactViewController.h"

@interface NewContactViewController ()<UITextFieldDelegate>
@property (strong,nonatomic) NSUserDefaults *myUserDefaults;
@property (strong,nonatomic) NSDictionary *boxdic;
@property (strong,nonatomic) NSString *boxpath;
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
    self.boxpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Contacts.plist"];
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    
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
    //NSLog(@"%@", name.text);
    //NSLog(@"%@", email.text);
    //NSLog(@"%@", tel.text);
    NSString *uuid = [NSUUID UUID].UUIDString;
    
    [self.boxdic setValue:@{@"UUID":uuid,@"Name":name.text,@"Email":email.text,@"PhoneNumber":tel.text} forKey:uuid];
    [self.boxdic writeToFile:self.boxpath atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    NSLog(@"after saving:____");
    NSLog(@"%@", data1);
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


