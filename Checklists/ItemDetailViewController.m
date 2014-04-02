//
//  AddItemViewController.m
//  Checklists
//
//  Created by xzjs on 14-3-14.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  if (self.itemToEdit != nil) {
    self.title = @"Edit Item";
    self.textField.text = self.itemToEdit.text;
    self.doneBarButton.enabled = YES;
  }
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self.delegate ItemDetailViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    
    if(self.itemToEdit == nil){
        ChecklistItem *item=[[ChecklistItem alloc]init];
        item.text = self.textField.text;
        item.checked= NO;
        [self.delegate ItemDetailViewController:self didFinishAddingItem:item];
    } else{
        self.itemToEdit.text = self.textField.text;
        [self.delegate ItemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];

  self.doneBarButton.enabled = ([newText length] > 0);
	
  return YES;
}

@end
