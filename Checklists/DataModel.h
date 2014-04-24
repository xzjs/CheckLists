//
//  DataModel.h
//  Checklists
//
//  Created by xzjs on 14-4-2.
//  Copyright (c) 2014年 xzjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(nonatomic,strong)NSMutableArray *lists;

-(void)saveChecklists;
-(NSInteger)indexOfSelectedChecklist;
-(void)setIndexOfSelectedChecklist:(NSInteger)index;
-(void)sortChecklists;
+(NSInteger)nextChecklistItemId;
+(NSArray*)loadChecklistOnInternet;
+(NSMutableArray *)getListArray:(NSDictionary *)nsdic;
-(void)saveIDNumber:(NSString*)nss;
-(NSString*)loadIDNumber;
-(NSMutableDictionary*)getNewsOnInternet:(NSString*)nssIDNumber;
-(void)saveNews:(NSMutableArray*) nsma;
-(NSMutableArray*)loadNews;

@end
