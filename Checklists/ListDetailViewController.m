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

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController{
    
    NSString *_iconName;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self = [super initWithCoder:aDecoder])){
        
        _iconName = @"Folder";
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    
    self.nsa=[DataModel loadChecklistOnInternet];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    if(self.checklistToEdit == nil){
        Checklist *checklist = [[Checklist alloc]init];
            checklist.iconName = _iconName;
        
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    }else{
        self.checklistToEdit.iconName = _iconName;
        [self.delegate listDetailViewController:self didFinishEditingChecklist:self.checklistToEdit];
    }
}

- (IBAction)cancel:(id)sender {
    [self.delegate listDetailViewControllerDidCancel:self];
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
    
    
    _iconName = iconName;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //Checklist *checklist = self.dataModel.lists[indexPath.row];
    //cell.textLabel.text = checklist.name;
    cell.textLabel.text = self.nsa[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.nsa count];
}


@end
