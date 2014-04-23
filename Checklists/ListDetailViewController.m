//
//  ListDetailViewController.m
//  Checklists
//
//  Created by xzjs on 14-3-31.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"
#import "DataModel.h"
#import "DataModelTree.h"

@interface ListDetailViewController ()

@property (strong, nonatomic) DataModelTree *data;
@property(strong,nonatomic) NSMutableArray *prevData;

@end

@implementation ListDetailViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self = [super initWithCoder:aDecoder])){
        
        //_iconName = @"Folder";
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    if ((self.prevData==nil)||([self.prevData count]==0)) {
        self.data.name=@"全部分类";
        self.data.children = [DataModel loadChecklistOnInternet];
    }
    self.title=self.data.name;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    if(self.checklistToEdit == nil){
        Checklist *checklist = [[Checklist alloc]init];
            //checklist.iconName = _iconName;
        
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    }else{
        //self.checklistToEdit.iconName = _iconName;
        [self.delegate listDetailViewController:self didFinishEditingChecklist:self.checklistToEdit];
    }
}

- (IBAction)cancel:(id)sender {
    if([self.prevData count]==0){
        [self.delegate listDetailViewControllerDidCancel:self];
    }else{
        [self.prevData removeObject:self.prevData.lastObject];
    }
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return indexPath;
    }else{
        return nil;
    }
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
  self.doneBarButton.enabled = ([newText length] > 0);
  return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if([segue.identifier isEqualToString:@"PickIcon"]){
        
        IconPickerViewController *controller = segue.destinationViewController;
        
        controller.delegate = self;
    }
}

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName{
    
    
    //_iconName = iconName;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassListCell"];
    
    //  ChecklistItem *item = _items[indexPath.row];
    DataModelTree *item = self.data.children[indexPath.row];
    
    
    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
	
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data.children count];
}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(DataModelTree *)item
{
    if (item.checked) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(DataModelTree *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:500];
    //label.text = item.text;
    label.text = item.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //  ChecklistItem *item = _items[indexPath.row];
    DataModelTree *item = self.data.children[indexPath.row];
    
    [self.prevData addObject:self.data];
    self.data=item;
    
    //  [self saveChecklistItems];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}

@end
