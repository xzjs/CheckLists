//
//  ChecklistsItem.h
//  Checklists
//
//  Created by xzjs on 14-3-12.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistsItem : NSObject<NSCoding>

@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)BOOL checked;

-(void)toggleChecked;

@end
