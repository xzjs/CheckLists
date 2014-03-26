//
//  AddItemViewController.m
//  Checklists
//
//  Created by xzjs on 14-3-14.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "AddItemViewController.h"
#import "ChecklistsItem.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    ChecklistsItem *item=[[ChecklistsItem alloc]init];
    item.text=self.textField.text;
    item.checked=NO;
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newText=[textField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.doneBarButton.enabled=([newText length]>0);
    
    return YES;
}
@end
