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

- (void)setScores: (long)score andLevel:(int)level{
    
    listPath = [[self docsDir]stringByAppendingPathComponent:@"GameData.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:listPath]) {
        [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"GameData" ofType:@"plist"] toPath:listPath error:nil];
    }
    plistData = [NSMutableDictionary dictionaryWithContentsOfFile:listPath];
    if(level == 1)
    {
        
        long s1 = [[plistData objectForKey:@"score1"] integerValue];
        long s2 = [[plistData objectForKey:@"score2"] integerValue];
        long s3 = [[plistData objectForKey:@"score3"] integerValue];
        score = 100;
        if(score>s1 && score>s2 && score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score1"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s1] forKey:@"score2"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s2] forKey:@"score3"];
            [plistData writeToFile:listPath atomically:YES];
            
        }
        else if(score>s2 && score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score2"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s2] forKey:@"score3"];
            
        }
        else if(score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score3"];
            
        }
        [plistData writeToFile:listPath atomically:YES];
        
        
    }
    
    else if(level == 2)
    {
        
        long s1 = [[plistData objectForKey:@"score4"] integerValue];
        long s2 = [[plistData objectForKey:@"score5"] integerValue];
        long s3 = [[plistData objectForKey:@"score6"] integerValue];
        if(score>s1 && score>s2 && score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score4"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s1] forKey:@"score5"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s2] forKey:@"score6"];
            
            
        }
        else if(score>s2 && score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score5"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s2] forKey:@"score6"];
            
        }
        else if(score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score6"];
            
        }
        [plistData writeToFile:listPath atomically:YES];
        
    }
    
    else if(level == 3)
    {
        
        long s1 = [[plistData objectForKey:@"score7"] integerValue];
        long s2 = [[plistData objectForKey:@"score8"] integerValue];
        long s3 = [[plistData objectForKey:@"score9"] integerValue];
        if(score>s1 && score>s2 && score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score7"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s1] forKey:@"score8"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s2] forKey:@"score9"];
            
        }
        else if(score>s2 && score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score8"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s2] forKey:@"score9"];
            
        }
        else if(score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score9"];
            
        }
        [plistData writeToFile:listPath atomically:YES];
        
    }
    
    else if(level == 4)
    {
        
        
        long s1 = [[plistData objectForKey:@"score10"] integerValue];
        long s2 = [[plistData objectForKey:@"score11"] integerValue];
        long s3 = [[plistData objectForKey:@"score12"] integerValue];
        if(score>s1 && score>s2 && score>s3)
        {
            
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score10"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s1] forKey:@"score11"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s2] forKey:@"score12"];
            
            
        }
        else if(score>s2 && score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score11"];
            [plistData setValue:[NSString stringWithFormat:@"%li",s2] forKey:@"score12"];
            
        }
        else if(score>s3)
        {
            
            [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score12"];
            
        }
        [plistData writeToFile:listPath atomically:YES];
        
        
    }
    
}


@end

