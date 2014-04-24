//
//  DbUtil.h
//  Checklists
//
//  Created by xzjs on 14-4-24.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sqlite3.h"
#import "IDNumber.h"

@interface DbUtil : NSObject

-(NSString*)getPath;

-(sqlite3*)open;

-(void)close:(sqlite3*)db;

-(void)createTable:(sqlite3*)db;

-(void)insert:(IDNumber*)per;



@end
