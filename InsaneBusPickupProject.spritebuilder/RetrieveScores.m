//
//  retrieveScores.m
//  InsaneBusPickupProject
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "RetrieveScores.h"
@import Foundation;

@implementation RetrieveScores {
    
}
- (NSString *)docsDir {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
}





- (NSMutableArray *)returnScoreBasedOnLevel: (NSInteger) level{
    //long x[3];
    x= [[NSMutableArray alloc]init];
    
    listPath = [[self docsDir]stringByAppendingPathComponent:@"GameData.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:listPath]) {
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"GameData" ofType:@"plist"] toPath:listPath error:nil];
    }
    plistData = [NSMutableDictionary dictionaryWithContentsOfFile:listPath];
    
    if(level == 1)
    {
        
        [x addObject:[plistData objectForKey:@"score1"]];
        [x addObject:[plistData objectForKey:@"score2"]];
        [x addObject:[plistData objectForKey:@"score3"]];
        
    }
    else if(level == 2)
    {
        
        [x addObject:[plistData objectForKey:@"score4"]];
        [x addObject:[plistData objectForKey:@"score5"]];
        [x addObject:[plistData objectForKey:@"score6"]];
        
    }
    else if(level == 3)
    {
        
        [x addObject:[plistData objectForKey:@"score7"]];
        [x addObject:[plistData objectForKey:@"score8"]];
        [x addObject:[plistData objectForKey:@"score9"]];
        
    }
    else if(level == 4)
    {
        
        [x addObject:[plistData objectForKey:@"score10"]];
        [x addObject:[plistData objectForKey:@"score11"]];
        [x addObject:[plistData objectForKey:@"score12"]];
        
    }
    return x;
    
}

@end

