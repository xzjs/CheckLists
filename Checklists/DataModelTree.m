//
//  DataModelTree.m
//  Checklists
//
//  Created by 何潭碧 on 14-4-21.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "DataModelTree.h"

@implementation DataModelTree

- (id)initWithName:(NSString *)name children:(NSArray *)children
{
    self = [super init];
    if (self) {
        self.children = children;
        self.name = name;
        self.checked=-2;
    }
    return self;
}

+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)children
{
    return [[self alloc] initWithName:name children:children];
}

@end
