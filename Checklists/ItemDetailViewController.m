//
//  itemDetailViewController.m
//  Checklists
//
//  Created by xzjs on 14-3-14.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistsItem.h"

@interface itemDetailViewController ()

@end

@implementation itemDetailViewController

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
    
    if(self.itemToEdit!=nil){
        self.title=@"EditItem";
        self.textField.text=self.itemToEdit.text;
        self.doneBarButton.enabled=YES;
    }

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
    
    if(self.itemToEdit==nil){
        ChecklistsItem *item=[[ChecklistsItem alloc]init];
        item.text=self.textField.text;
        item.checked= NO;
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    }else{
        self.itemToEdit.text=self.textField.text;
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
    
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
