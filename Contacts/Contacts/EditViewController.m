//
//  EditViewController.m
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController () <UITextFieldDelegate>

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *lightBlue= [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1];
    CGRect screen=[[UIScreen mainScreen] bounds];
    self.boxpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Contacts.plist"];
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    
    
    // Do any additional setup after loading the view from its nib.
    
    
/*
 for nav buttons
*/
    UIButton *myBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 80, 50)];
    //    [myBackButton setBackgroundColor:[UIColor yellowColor]];
    [myBackButton setTitle:@"Back" forState:UIControlStateNormal];
    [myBackButton setTitleColor:lightBlue forState:UIControlStateNormal];
    [myBackButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myBackButton];
    UIButton *myEditButton = [[UIButton alloc] initWithFrame:CGRectMake(screen.size.width-80,20, 80, 50)];
    [myEditButton setTitle:@"Finish" forState:UIControlStateNormal];
    [myEditButton setTitleColor:lightBlue forState:UIControlStateNormal];
    [myEditButton addTarget:self action:@selector(finishButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myEditButton];
    self.myUserDefaults=[NSUserDefaults standardUserDefaults];
    
/*
 for labels and textfields
*/
    UILabel *Name=[[UILabel alloc] initWithFrame:CGRectMake(20, 100, 50, 50)];
    Name.text=@"Name";
    [self.view addSubview:Name];
    UILabel *Email=[[UILabel alloc] initWithFrame:CGRectMake(20, 170, 50, 50)];
    Email.text=@"Email";
    [self.view addSubview:Email];
    UILabel *PhoneNumber=[[UILabel alloc] initWithFrame:CGRectMake(20, 240, 50, 50)];
    PhoneNumber.text=@"Phone";
    [self.view addSubview:PhoneNumber];
    
    //-----
    
    self.name=[[UITextField alloc] initWithFrame:CGRectMake(80, 100, screen.size.width-100, 50)];
    self.name.borderStyle=UITextBorderStyleRoundedRect;
    [self.name setTag:1];
    [self.name setTextAlignment:NSTextAlignmentCenter];
    self.name.delegate=self;
    [self.view addSubview:self.name];
    self.email=[[UITextField alloc] initWithFrame:CGRectMake(80, 170, screen.size.width-100, 50)];
    self.email.borderStyle=UITextBorderStyleRoundedRect;
    [self.email setTag:2];
    [self.email setTextAlignment:NSTextAlignmentCenter];
    self.email.delegate=self;
    [self.view addSubview:self.email];
    self.phoneNumber=[[UITextField alloc] initWithFrame:CGRectMake(80, 240, screen.size.width-100, 50)];
    self.phoneNumber.borderStyle=UITextBorderStyleRoundedRect;
    [self.phoneNumber setTag:3];
    [self.phoneNumber setTextAlignment:NSTextAlignmentCenter];
    self.phoneNumber.delegate=self;
    [self.view addSubview:self.phoneNumber];
    self.boxpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/Contacts.plist"];
    self.boxdic = [[NSMutableDictionary alloc] initWithContentsOfFile:self.boxpath];
    self.result = [[NSDictionary alloc] initWithDictionary:[self.boxdic objectForKey:self.uuid]];
    
    
    [self.name setText:[self.result objectForKey:@"Name"]];
    [self.email setText:[self.result objectForKey:@"Email"]];
    [self.phoneNumber setText:[self.result objectForKey:@"PhoneNumber"]];
    
    
/*
 for delete button
*/
    
    self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake((screen.size.width-300)/2, screen.size.height-60, 300, 40)];
    [self.deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundColor:lightBlue];
    self.deleteBtn.layer.cornerRadius = 20;
    [self.deleteBtn addTarget:self action:@selector(deleteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteBtn];
}



-(void) backButtonPressed:(id)sender{
    NSLog(@"back Button Pressed");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) deleteBtnPressed:(id)sender{
    NSLog(@"delete button pressed");
    UIAlertController *myDemoAlertControl = [UIAlertController alertControllerWithTitle:@"Sure to delete?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [myDemoAlertControl addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.boxdic removeObjectForKey:self.uuid];
        [self.boxdic writeToFile:self.boxpath atomically:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    [myDemoAlertControl addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Delete operation aborted");
    }]];
    [self presentViewController:myDemoAlertControl animated:YES completion:nil];
}

-(void)finishButtonPressed:(id)sender{
    NSLog(@"finish button pressed");
    NSLog(@"%@",self.uuid);
    NSLog(@"%@",self.self.name.text);
    NSLog(@"%@",self.self.email.text);
    [self.boxdic setValue:@{@"UUID":self.uuid,@"Name":self.name.text,@"Email":self.email.text,@"PhoneNumber":self.phoneNumber.text} forKey:self.uuid];	
    [self.boxdic writeToFile:self.boxpath atomically:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return TRUE;
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

@end


