//
//  songViewController.m
//  iOS-Music
//
//  Created by OurEDA on 2018/4/30.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "songViewController.h"

@interface songViewController ()

@end

@implementation songViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect screen=[[UIScreen mainScreen] bounds];
    UIBarButtonItem* backBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnPressed:)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)backBtnPressed:(id)sender{
    NSLog(@"return from songDetail");
    [self.navigationController popViewControllerAnimated:YES];
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
