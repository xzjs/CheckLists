//
//  itemDetailViewController.h
//  Checklists
//
//  Created by xzjs on 14-3-14.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class itemDetailViewController;
@class ChecklistsItem;

@protocol ItemDetailViewControllerDelegate <NSObject>
-(void) itemDetailViewControllerDidCancel:(itemDetailViewController *)controller;
-(void) itemDetailViewController:(itemDetailViewController*)controller didFinishAddingItem:(ChecklistsItem*)item;
-(void) itemDetailViewController:(itemDetailViewController*)controller didFinishEditingItem:(ChecklistsItem*)item;

@end

@interface itemDetailViewController : UITableViewController<UITextFieldDelegate>
@property(nonatomic,weak)id<ItemDetailViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic,strong) ChecklistsItem *itemToEdit;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
