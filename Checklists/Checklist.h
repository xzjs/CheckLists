//
//  Checklist.h
//  Checklists
//
//  Created by xzjs on 14-3-31.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject<NSCoding>

@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSMutableArray *items;

@property(nonatomic,copy)NSString *iconName;



-(int)countUncheckedItems;

@end
