//
//  Person+CoreDataProperties.m
//  ContactWIthCD
//
//  Created by OurEDA on 2018/3/28.
//  Copyright © 2018年 OurEDA. All rights reserved.
//
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic uid;
@dynamic name;
@dynamic tel;
@dynamic email;

@end
