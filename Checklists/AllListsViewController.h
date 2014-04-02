//
//  AllListsViewController.h
//  Checklists
//
//  Created by xzjs on 14-3-31.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"

@class DataModel;

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)DataModel *dataModel;

@end
