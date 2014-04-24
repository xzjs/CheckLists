//
//  ChecklistsViewController.h
//  Checklists
//
//  Created by xzjs on 14-3-11.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController <ItemDetailViewControllerDelegate>

//@property (nonatomic, strong) Checklist *checklist;
@property(nonatomic,strong)NSDictionary * nsd;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
