//
//  DataModel.m
//  Checklists
//
//  Created by xzjs on 14-4-2.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import "DataModel.h"
#import "DataModelTree.h"
#import "Checklist.h"

@implementation DataModel

-(void)sortChecklists{
    
    [self.lists sortUsingSelector:@selector(compare:)];
    
}

-(void)registerDefaults{
    
    NSDictionary *dictionary = @{@"ChecklistIndex" :@-1,@"FirstTime":@YES,@"ChecklistItemId":@0};
    
    [[NSUserDefaults standardUserDefaults]registerDefaults:dictionary];
}

-(void)handleFirstTime{
    
    BOOL firstTime = [[NSUserDefaults standardUserDefaults]boolForKey:@"FirstTime"];
    
    if(firstTime){
        
        Checklist *checklist = [[Checklist alloc]init];
        
        checklist.name = @"List";
        
        [self.lists addObject:checklist];
        
        [self setIndexOfSelectedChecklist:0];
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"FirstTime"];
        
        
    }
}


#pragma mark init初始化

-(id)init{
    
    if((self =[super init])){
        
        [self loadChecklists];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

#pragma mark 获取沙盒地址

-(NSString*)documentsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    return documentsDirectory;
}

-(NSString*)dataFilePath{
    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklists{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:_lists forKey:@"Checklists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

-(void)loadChecklists{
    NSString *path = [self dataFilePath];
    if([[NSFileManager defaultManager]fileExistsAtPath:path]){
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        
        self.lists = [unarchiver decodeObjectForKey:@"Checklists"];
        
        [unarchiver finishDecoding];
    }else{
        self.lists = [[NSMutableArray alloc]initWithCapacity:20];
    }
}


#pragma mark NSUserDefaults

-(NSInteger)indexOfSelectedChecklist{
    
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"ChecklistIndex"];
}

-(void)setIndexOfSelectedChecklist:(NSInteger)index{
    
    [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"ChecklistIndex"];
    
}

+(NSInteger)nextChecklistItemId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger itemId = [userDefaults integerForKey:@"ChecklistItemId"];
    
    [userDefaults setInteger:itemId+1 forKey:@"ChecklistItemId"];
    [userDefaults synchronize];
    return itemId;
}

+(NSMutableArray *)loadChecklistOnInternet{
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://oucfeed.duapp.com/category"]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    
    NSMutableArray * mtemp=[self getListArray:weatherDic];
    
    return mtemp;
}

+(NSMutableArray *)getListArray:(NSDictionary *)nsdic{
    NSArray * kellAll=nsdic.allKeys;
    NSMutableArray * maChild=[[NSMutableArray alloc]init];
    for (NSString *jsonkey in kellAll) {
        NSDictionary * nsd=[nsdic objectForKey:jsonkey];
        NSMutableArray * ma=[[NSMutableArray alloc]init];
        if([nsd count]!=0){
            ma=[self getListArray:nsd];
        }
        DataModelTree *phone1 = [DataModelTree dataObjectWithName:jsonkey children:ma];
        [maChild addObject:phone1];
    }
    return maChild;
}

@end
