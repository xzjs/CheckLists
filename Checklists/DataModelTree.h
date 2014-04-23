//
//  DataModelTree.h
//  Checklists
//
//  Created by 何潭碧 on 14-4-21.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModelTree : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *children;
@property (assign,nonatomic)BOOL checked;

- (id)initWithName:(NSString *)name children:(NSArray *)array;

+ (id)dataObjectWithName:(NSString *)name children:(NSArray *)children;

@end
