//
//  AllListsViewController.m
//  Checklists
//
//  Created by xzjs on 14-3-31.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "AllListsViewController.h"
#import "Checklist.h"
#import "ChecklistViewController.h"
#import "DataModel.h"
#import "ChecklistItem.h"
#import "Reachability.h"

@interface AllListsViewController ()

@property(strong,nonatomic)NSMutableDictionary *newsMDic;
@property(strong,nonatomic)NSArray *nsakey;
@property(strong,nonatomic)NSMutableArray *nsmaObject;

@end

@implementation AllListsViewController

#pragma mark 表视图数据源代理方法

- (void)viewDidLoad
{
    [super viewDidLoad];

    /*NSString *hostName=@"http://oucfeed.duapp.com/category";
    Reachability * rea=[Reachability reachabilityWithHostName:hostName];
    NetworkStatus nws=[rea currentReachabilityStatus];
    if (nws==NotReachable) {
        DataModel *dm=[[DataModel alloc]init];
        self.nsmaObject=[dm loadNews];
    }else{*/
    NSArray * nsaCopy=self.nsmaObject.copy;
        [self loadNews];
    
        DataModel *dm=[[DataModel alloc]init];
        [dm saveNews:self.nsmaObject];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSTimer *timer =  [NSTimer scheduledTimerWithTimeInterval:86400 target:self selector:@selector(loadNews) userInfo:nil repeats:YES];
        if ([self.nsmaObject isEqualToArray:nsaCopy]==NO) {
            UILocalNotification * uiln=[[UILocalNotification alloc]init];
            uiln.fireDate=[NSDate new];
            uiln.timeZone=[NSTimeZone defaultTimeZone];
            uiln.alertBody=@"您有新的新闻未阅读";
            uiln.soundName=UILocalNotificationDefaultSoundName;
            [[UIApplication sharedApplication]scheduleLocalNotification:uiln];
        }
    });
    //}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark view

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
    
    NSInteger index = [self.dataModel indexOfSelectedChecklist];
    
    if(index >=0 && index <[self.dataModel.lists count]){
        
        Checklist *checklist = self.dataModel.lists[index];
        
        [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
    }
}

#pragma mark - UINavigationController delegate

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if(viewController ==self){
        
        [self.dataModel setIndexOfSelectedChecklist:-1];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.clas==0) {
        return [self.newsMDic count];
    }else{
        return [self.nsmaObject count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
  }
    NSDictionary *nsdObject=[self.nsmaObject objectAtIndex:indexPath.row];
    cell.textLabel.text = nsdObject[@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:[NSString stringWithFormat:nsdObject[@"datetime"]]];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *nsdObject=[self.nsmaObject objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier:@"ShowChecklist" sender:nsdObject];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clas==1) {
        [self.nsmaObject removeObjectAtIndex:indexPath.row];
        DataModel *dm=[[DataModel alloc]init];
        [dm saveCollectNews:self.nsmaObject];
        NSArray *indexPaths = @[indexPath];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"ShowChecklist"]) {
    ChecklistViewController *controller = segue.destinationViewController;
    controller.nsd = sender;
  } else if ([segue.identifier isEqualToString:@"AddChecklist"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    controller.checklistToEdit = nil;
  }
}

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist
{
  [self.tableView reloadData];

  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist
{
    //[self.dataModel sortChecklists];
    [self loadNews];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
  UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];

  ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
  controller.delegate = self;

  Checklist *checklist = self.dataModel.lists[indexPath.row];
  controller.checklistToEdit = checklist;

  [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)loadNews{
    UIActivityIndicatorView* activityIndicatorView = [ [ UIActivityIndicatorView  alloc ]initWithFrame:CGRectMake(150.0,200.0,30.0,30.0)];
    activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleGray;
    activityIndicatorView.hidesWhenStopped = NO	;
    [self.view addSubview:activityIndicatorView ];
    [activityIndicatorView startAnimating];
    //[self.aiv startAnimating];
    self.newsMDic=[[NSMutableDictionary alloc]init];
    DataModel *dm=[[DataModel alloc]init];
    self.nsmaObject=[[NSMutableArray alloc]init];
    if(self.clas==0){
        self.newsMDic=[dm getNewsOnInternet:dm.loadIDNumber];
    
        for (NSDictionary *nsd in self.newsMDic) {
            [self.nsmaObject addObject:nsd];
        }
    }else{
        self.nsmaObject=[dm loadCollectNews];
    }
    //[self.aiv stopAnimating];
    [activityIndicatorView stopAnimating];
    [self.tableView reloadData];
}
- (IBAction)zuixin:(id)sender {
    UISegmentedControl *seg=(UISegmentedControl*)sender;
    self.clas = seg.selectedSegmentIndex;
    [self loadNews];
    [self.tableView reloadData];
    
}
@end
