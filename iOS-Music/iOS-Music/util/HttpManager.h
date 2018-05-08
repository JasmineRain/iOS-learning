//
//  HttpManager.h
//  iOS-Music
//
//  Created by OurEDA on 2018/5/5.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);

@interface HttpManager : NSObject

+ (void)getRequestWithApi:(NSString *)api params:(NSDictionary *)params successBlock:(successBlock)successBlock failureBlock:(failureBlock)failureBlock;

@end
