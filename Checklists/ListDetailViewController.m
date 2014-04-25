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
#import "Reachability.h"

@interface ListDetailViewController ()

@property (strong, nonatomic) DataModelTree *data;
@property(strong,nonatomic) NSMutableArray *prevData;
@property(strong,nonatomic)NSMutableString * sJosn;
@property(assign,nonatomic)BOOL isSelected;

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
    NSString *hostName=@"http://oucfeed.duapp.com/category";
    Reachability * rea=[Reachability reachabilityWithHostName:hostName];
    NetworkStatus nws=[rea currentReachabilityStatus];
    /*if (nws==NotReachable) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"网络不可用" message:@"当前网络不可用，无法加载列表" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil ,nil];
        [alert show];
        id someThing;
        [self cancel:someThing];
        return ;
    }*/
    if ((self.prevData==nil)||([self.prevData count]==0)) {
        self.prevData=[[NSMutableArray alloc]init];
        self.data=[[DataModelTree alloc]init];
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

- (IBAction)done:(id)sender{
    while ([self.prevData count]!=0) {
        id dontKnow;
        [self cancel:dontKnow];
    }
    DataModelTree *dmtNew=[[DataModelTree alloc]init];
    dmtNew=self.data;
    dmtNew.checked=1;
    self.sJosn=[[NSMutableString alloc]init];
    [self getJsonString:dmtNew];
    NSRange range=NSMakeRange([self.sJosn length]-1, 1);
    [self.sJosn deleteCharactersInRange:range];
    range=NSMakeRange(0, 3);
    [self.sJosn deleteCharactersInRange:range];
    
    NSMutableDictionary *nmDic=[self postMessageAndGetNsMutableDictionary:@"http://oucfeed.duapp.com/profile" type:@"POST" body:self.sJosn];
    NSString *ns=[nmDic objectForKey:@"id"];
    
    DataModel *dm=[[DataModel alloc]init];
    [dm saveIDNumber:ns];
    Checklist *c=[[Checklist alloc]init];
    [self.delegate listDetailViewController:self didFinishEditingChecklist:c];
}

//向服务器发送请求从网络获取数据并返回获取到得字典
-(NSMutableDictionary *)postMessageAndGetNsMutableDictionary:(NSString*)u type:(NSString*)t body:(NSString*)b{
    NSURL *url=[NSURL URLWithString:u];
    
    NSMutableURLRequest *mRequest=[[NSMutableURLRequest alloc]init];
    [mRequest setURL:url];
    [mRequest setTimeoutInterval:10];
    [mRequest setHTTPMethod:t];
    //[mRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [mRequest setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    [mRequest setHTTPBody:[b dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *response;
    NSError *error;
    NSData *data=[NSURLConnection sendSynchronousRequest:mRequest returningResponse:&response error:&error];
    //NSString *content=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *idDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return idDic;
}


//通过递归判断选择了哪些拼接出json字符串
-(void)getJsonString:(DataModelTree *)dmt{
    if(dmt.checked>0||dmt.checked==-1){
        NSString * nss;
        if([dmt.name isEqual:@"全部分类"]){
            nss=@"";
        }else{
            nss=dmt.name;
        }
        [self.sJosn appendString:[NSString stringWithFormat:@"\"%@\":{",nss]];
        if([dmt.children count]!=0&&dmt.checked!=-1){
            for (DataModelTree *object in dmt.children) {
                [self getJsonString:object];
            }
        }
        if([self.sJosn hasSuffix:@","]){
            NSRange range=NSMakeRange([self.sJosn length]-1, 1);
            [self.sJosn deleteCharactersInRange:range];
        }
        [self.sJosn appendString:@"},"];
    }
    
}

- (IBAction)cancel:(id)sender{
    if([self.prevData count]==0){
        [self.delegate listDetailViewControllerDidCancel:self];
    }else{
        
        int i=0;
        for (DataModelTree *object in self.data.children) {
            if(object.checked>0||object.checked==-1){
                i++;
            }
        }
        self.data.checked=i;
        self.data=self.prevData.lastObject;
        
        self.title=self.data.name;
        [self.prevData removeObject:self.prevData.lastObject];
        [self.tableView reloadData];
    }
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
    if (item.checked==-1) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else{
        if ([item.children count]!=0) {
            cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
        }else{
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        
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
    DataModelTree *item=self.data.children[indexPath.row];
    if(item.checked>0){
        item.checked=-1;
    }else{
        item.checked=0-3-item.checked;
    }
    ((DataModelTree *)self.data.children[indexPath.row]).checked=item.checked;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    DataModelTree *item = self.data.children[indexPath.row];
    if ([item.children count]!=0) {
        [self.prevData addObject:self.data];
        self.data=item;
        self.title=self.data.name;
        [tableView reloadData];
    }
}

@end
