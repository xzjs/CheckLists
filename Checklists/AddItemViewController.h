//
//  AddItemViewController.h
//  Checklists
//
//  Created by xzjs on 14-3-14.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddItemViewController;
@class ChecklistsItem;

@protocol AddItemViewCOntrollerDelegate <NSObject>
-(void) addItemViewControllerDidCancel:(AddItemViewController *)controller;
-(void) addItemViewController:(AddItemViewController*)controller didFinishAddingItem:(ChecklistsItem *)item;
-(void) addItemViewController:(AddItemViewController*)controller didFinishEditingItem:(ChecklistsItem*)item;

@end

@interface AddItemViewController : UITableViewController<UITextFieldDelegate>
@property(nonatomic,weak)id<AddItemViewCOntrollerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic,strong) ChecklistsItem *itemToEdit;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
