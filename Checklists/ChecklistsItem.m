//
//  ChecklistsItem.m
//  Checklists
//
//  Created by xzjs on 14-3-12.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "ChecklistsItem.h"

@implementation ChecklistsItem

-(void)toggleChecked{
    self.checked=!self.checked;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}
@end
