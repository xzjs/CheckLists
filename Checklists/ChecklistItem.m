//
//  ChecklistItem.m
//  Checklists
//
//  Created by xzjs on 14-3-12.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem

-(id)init{
    if((self = [super init])){
        self.itemId = [DataModel nextChecklistItemId];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  if ((self = [super init])) {
    self.text = [aDecoder decodeObjectForKey:@"Text"];
    self.checked = [aDecoder decodeBoolForKey:@"Checked"];
      self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
      self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
      self.itemId = [aDecoder decodeIntegerForKey:@"ItemID"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  [aCoder encodeObject:self.text forKey:@"Text"];
  [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInteger:self.itemId forKey:@"ItemID"];
}

- (void)toggleChecked
{
  self.checked = !self.checked;
}

@end
