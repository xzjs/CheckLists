//
//  ChecklistsViewController.h
//  Checklists
//
//  Created by xzjs on 14-3-11.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "itemDetailViewController.h"

@interface ChecklistsViewController : UITableViewController<ItemDetailViewControllerDelegate>
- (IBAction)addItem:(id)sender;

@end
