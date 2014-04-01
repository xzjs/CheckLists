//
//  Checklist.m
//  Checklists
//
//  Created by xzjs on 14-3-31.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "Checklist.h"

@implementation Checklist

-(id)init{
    if((self =[super init])){
        self.items = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return self;
}

@end
