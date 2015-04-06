//
//  GamePlayScene.m
//  InsaneBusPickupProject
//
//  Created by Yao Fan on 3/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlayScene.h"


@implementation GamePlayScene

{
    
    float timeSinceObstacle;
}

- (void) updateScore: (int) currentScore {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Info.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]; //5
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    //here add elements to data file and write data to file
    int value = 5;
    
    [data setObject:[NSNumber numberWithInt:value] forKey:@"value"];
    
    [data writeToFile: path atomically:YES];
    //[data release]
}

- (void)initialize
{

    
}


-(void)update:(CCTime)delta
{

    
    
    
    
}

// put new methods here

#pragma mark Cocos2d Method


@end
