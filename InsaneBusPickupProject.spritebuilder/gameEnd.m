//
//  gameEnd.m
//  InsaneBusPickupProject
//
//  Created by Yao Fan on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "gameEnd.h"

@implementation gameEnd{
    CCButton *retryLevel;
    CCButton *menu1;

}


- (void)retryLevel {
    CCScene *aboutscene = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:aboutscene];
}

- (void)menu1 {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
}


@end
