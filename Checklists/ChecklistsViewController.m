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
    if (item.checked) {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
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

-(void)addItenViewControllerDidCancel:(AddItemViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addItemVIewController:(AddItemViewController *)controller didFinishAddingItem:(ChecklistsItem *)item{
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
        
        AddItemViewController *controller = (AddItemViewController *)navigationController;
        
        controller.delegate = self;
    }
}
@end
