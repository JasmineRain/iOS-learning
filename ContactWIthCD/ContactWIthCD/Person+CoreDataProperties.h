//
//  Person+CoreDataProperties.h
//  ContactWIthCD
//
//  Created by OurEDA on 2018/3/28.
//  Copyright © 2018年 OurEDA. All rights reserved.
//
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSUUID *uid;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *tel;
@property (nullable, nonatomic, copy) NSString *email;

@end

NS_ASSUME_NONNULL_END
