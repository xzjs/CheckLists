//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by xzjs on 14-3-11.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ChecklistItem.h"
#import "Checklist.h"

@interface ChecklistViewController ()

@end

@implementation ChecklistViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  //self.title = self.checklist.name;
    self.title=self.nsd[@"title"];
    [self.webView loadHTMLString:self.nsd[@"content"] baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegate

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
/*//  NSInteger newRowIndex = [_items count];
    NSInteger newRowIndex = [self.checklist.items count];
    
  [self.checklist.items addObject:item];

  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
  NSArray *indexPaths = @[indexPath];
  [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];

//  [self saveChecklistItems];
	
  [self dismissViewControllerAnimated:YES completion:nil];*/
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item
{
/*//  NSInteger index = [_items indexOfObject:item];
    NSInteger index = [self.checklist.items indexOfObject:item];
    
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  [self configureTextForCell:cell withChecklistItem:item];

//  [self saveChecklistItems];

  [self dismissViewControllerAnimated:YES completion:nil];*/
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  /*if ([segue.identifier isEqualToString:@"AddItem"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
  } else if ([segue.identifier isEqualToString:@"EditItem"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
    controller.delegate = self;

    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//    controller.itemToEdit = _items[indexPath.row];
      controller.itemToEdit = self.checklist.items[indexPath.row];
      
  }*/
}

- (IBAction)Collect:(id)sender {
}
@end
