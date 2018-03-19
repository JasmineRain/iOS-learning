//
//  EditViewController.h
//
//  Created by OurEDA on 2018/3/14.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewContactViewController.h"
@interface EditViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,assign) NSString *uuid;
@property (strong,nonatomic) NSUserDefaults *myUserDefaults;
@property (strong,nonatomic) NSDictionary *result;
@property (strong,nonatomic) NSMutableDictionary *boxdic;
@property (strong,nonatomic) NSString *boxpath;

@property (strong,nonatomic) UITextField *name;
@property (strong,nonatomic) UITextField *email;
@property (strong,nonatomic) UITextField *phoneNumber;
@property (strong,nonatomic) UIButton *deleteBtn;
@end


