//
//  retrieveScores.h
//  InsaneBusPickupProject
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetrieveScores : NSObject {
    
    NSString *listPath;
    NSMutableDictionary *plistData;
    NSMutableArray *x;
}
- (NSMutableArray *)returnScoreBasedOnLevel: (NSInteger) level;

@end
