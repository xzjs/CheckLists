//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by xzjs on 14-3-11.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "ChecklistsViewController.h"
#import "ChecklistsItem.h"

@interface ChecklistsViewController ()

@end

@implementation ChecklistsViewController{
    NSMutableArray *_items;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _items=[[NSMutableArray alloc]initWithCapacity:20];
    ChecklistsItem *items;
    
    items=[[ChecklistsItem alloc]init];
    items.text=@"苍井空";
    items.checked=NO;
    [_items addObject:items];
    items=[[ChecklistsItem alloc]init];
    items.text=@"苍井空";
    items.checked=NO;
    [_items addObject:items];
    items=[[ChecklistsItem alloc]init];
    items.text=@"苍井空";
    items.checked=NO;
    [_items addObject:items];
    items=[[ChecklistsItem alloc]init];
    items.text=@"苍井空";
    items.checked=NO;
    [_items addObject:items];
    items=[[ChecklistsItem alloc]init];
    items.text=@"苍井空";
    items.checked=NO;
    [_items addObject:items];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];
}

-(void)configureCheckmarkForCell:(UITableViewCell *)cell withCHecklistItem:(ChecklistsItem *)item{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    if (item.checked) {
        label.text=@"√";
    }else{
        label.text=@"";
    }
}

-(void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistsItem *)item{
    UILabel *label=(UILabel *)[cell viewWithTag:1000];
    label.text=item.text;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ChecklistItem" ];
    
    ChecklistsItem *item=_items[indexPath.row];
    
    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withCHecklistItem:item];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    ChecklistsItem *item=_items[indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withCHecklistItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)addItem:(id)sender {
    NSInteger newRowIndex=[_items count];
    ChecklistsItem *item=[[ChecklistsItem alloc]init];
    item.text=@"我是新来的菜鸟，求照顾求虐";
    item.checked=NO;
    [_items addObject:item];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths=@[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)tableview:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_items removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths=@[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)itemDetailViewControllerDidCancel:(itemDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewController:(itemDetailViewController *)controller didFinishAddingItem:(ChecklistsItem *)item{
    NSInteger newRowIndex = [_items count];
    [_items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    
    NSArray *indexpaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"AddItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        
        itemDetailViewController *controller = (itemDetailViewController *)navigationController;
        
        controller.delegate = self;
    }else if ([segue.identifier isEqualToString:@"EditItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        itemDetailViewController *controller = (itemDetailViewController *)navigationController.topViewController;
        controller.delegate=self;
        NSIndexPath * indexPath=[self.tableView indexPathForCell:sender];
        controller.itemToEdit = _items[indexPath.row];
    }
}

-(void)itemDetailViewController:(itemDetailViewController *)controller didFinishEditingItem:(ChecklistsItem *)item{
    NSInteger index=[_items indexOfObject:item];
    
    NSIndexPath *indexpPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexpPath];
    
    [self configureTextForCell:cell withChecklistItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
