//
//  ViewController.m
//  Pic_Slider
//
//  Created by OurEDA on 2018/3/8.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect screen = [[UIScreen mainScreen] bounds];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    [scrollView setContentSize:CGSizeMake(screen.size.width*4, screen.size.height)];
    [scrollView setDelegate:self];
    
    scrollView.pagingEnabled = YES;
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    [imageView1 setImage:[UIImage imageNamed:@"001.jpg"]];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(screen.size.width, 0, screen.size.width, screen.size.height)];
    [imageView2 setImage:[UIImage imageNamed:@"002.jpg"]];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(screen.size.width*2, 0, screen.size.width, screen.size.height)];
    [imageView3 setImage:[UIImage imageNamed:@"003.jpg"]];
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(screen.size.width*3, 0, screen.size.width, screen.size.height)];
    [imageView4 setImage:[UIImage imageNamed:@"004.jpg"]];
    
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView1.clipsToBounds = YES;
    imageView2.contentMode = UIViewContentModeScaleAspectFill;
    imageView2.clipsToBounds = YES;
    imageView3.contentMode = UIViewContentModeScaleAspectFill;
    imageView3.clipsToBounds = YES;
    imageView4.contentMode = UIViewContentModeScaleAspectFill;
    imageView4.clipsToBounds = YES;
    
    
    
    [scrollView addSubview:imageView1];
    [scrollView addSubview:imageView2];
    [scrollView addSubview:imageView3];
    [scrollView addSubview:imageView4];
    
    
    [self.view addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, screen.size.height-60,screen.size.width , 30)];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [pageControl setCurrentPage:offset.x/bounds.size.width];
    NSLog(@"%ld",pageControl.currentPage);
}

-(void)pageChanged:(id)sender{
    CGSize viewSize  = scrollView.frame.size;
    CGRect rectBounds =     CGRectMake(pageControl.currentPage*viewSize.width, 0, viewSize.width, viewSize.height);
    [scrollView scrollRectToVisible:rectBounds animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
