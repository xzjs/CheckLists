//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by xzjs on 14-3-11.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "ChecklistsViewController.h"

@interface ChecklistsViewController ()

@end

@implementation ChecklistsViewController{
    NSString *_row0text;
    NSString *_row1text;
    NSString *_row2text;
    NSString *_row3text;
    NSString *_row4text;
    BOOL _row0checked;
    BOOL _row1checked;
    BOOL _row2checked;
    BOOL _row3checked;
    BOOL _row4checked;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _row0text=@"苍井空";
    _row1text=@"苍井空";
    _row2text=@"苍井空";
    _row3text=@"苍井空";
    _row4text=@"苍井空";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ChecklistItem" ];
    UILabel *label=(UILabel *)[cell viewWithTag:1000];
    NSString *str;
    
    switch (indexPath.row%5) {
        case 0:
            str=_row0text;
            break;
        case 1:
            str=_row1text;
            break;
        case 2:
            str=_row2text;
            break;
        case 3:
            str=_row3text;
            break;
        case 4:
            str=_row4text;
            break;
        default:
            str=@" ";
            break;
    }
    label.text=str;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    BOOL isChecked=NO;
    switch (indexPath.row) {
        case 0:
            isChecked=_row0checked;
            _row0checked=!_row0checked;
            break;
        case 1:
            isChecked=_row1checked;
            _row1checked=!_row1checked;
            break;
        case 2:
            isChecked=_row2checked;
            _row2checked=!_row2checked;
            break;
        case 3:
            isChecked=_row3checked;
            _row3checked=!_row3checked;
            break;
        case 4:
            isChecked=_row4checked;
            _row4checked=!_row4checked;
            break;
        default:
            break;
    }
    
    if (isChecked) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
