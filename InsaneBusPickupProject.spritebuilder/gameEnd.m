//
//  gameEnd.m
//  InsaneBusPickupProject
//
//  Created by Yao Fan on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "gameEnd.h"

@implementation gameEnd{
    

}


- (void)retryLevel {
    CCScene *aboutscene = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:aboutscene];
}


@end
