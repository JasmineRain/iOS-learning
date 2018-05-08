//
//  discoverViewController.h
//  iOS-Music
//
//  Created by OurEDA on 2018/4/24.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface discoverViewController : UIViewController
@property(nonatomic,strong)NSString *str;
@property(nonatomic,strong)NSURL *url;
@property(nonatomic,strong)WKWebView *webView;
@property(strong, nonatomic) CALayer *progresslayer;
@end

