//
//  HttpManager.m
//  iOS-Music
//
//  Created by OurEDA on 2018/5/5.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "HttpManager.h"

#define kBaseUrl @"http://music.163.com/"

@implementation HttpManager

+ (void)getRequestWithApi:(NSString *)api params:(NSDictionary *)params successBlock:(successBlock)successBlock failureBlock:(failureBlock)failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置固定参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
    
    dic[@"version"]       = infoDic[@"CFBundleShortVersionString"];
    dic[@"devicetype"]    = @"ios";
    dic[@"systemversion"] = [UIDevice currentDevice].systemVersion;
    
    NSString *url = [kBaseUrl stringByAppendingString:api];
    
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSInteger code = [dic[@"errorCode"] integerValue];
        
        if (code == 22000) {
            successBlock(dic[@"data"]);
        }else {
            
            NSError *error = [NSError errorWithDomain:@"" code:code userInfo:responseObject[@"data"]];
            failureBlock(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

+ (NSArray *)filterImage:(NSString *)html
{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                [resultArray addObject:src];
            }
        }
    }
    
    return resultArray;
}

@end
