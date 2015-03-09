#import "MainScene.h"
#import <CCActionInterval.h>

@implementation MainScene{

//Comment added by Rahul Thankachan
//Please add ur comment below and Push
//comment by stephen
    // added by Yao "Frank" Fan
    //hi swapnil here
    //added comment in xcode by stephen
    //comment added by varsha
    #define foo4random() (arc4random() % ((unsigned)RAND_MAX + 1))
    CCNode *_road1;
    CCNode *_road2;
    CCNode *_car1;
    NSArray *_roads;
    CGPoint velocity;
NSMutableArray *_cars;    CCTime mytime;
    float timesliceformovewment;
    CCNodeColor *bus;
       float timeSinceObstacle;
    int count;
    int xcoord;
    int num;
    CGFloat widthBoundary;//
    CGFloat heightBoundary;
    CGFloat roadVelocity;
    
    CGSize window;
}

- (void)didLoadFromCCB {
    
    //done by Frank
    _roads= @[_road1,_road2];
    _cars= [[NSMutableArray alloc]init];
  
   // label= [[CCLabelTTF alloc]initWithString:@"Hello there !!" fontName:@"Hello" fontSize:15];
   // label2= [[CCLabelTTF alloc]initWithString:@"Hello there !!" fontName:@"Hello" fontSize:15];
    bus= [[CCNodeColor alloc]initWithColor:[CCColor colorWithUIColor:[UIColor cyanColor]] width:30 height:50];
    
    
    CGSize windowSize= [[CCDirector sharedDirector] viewSize];
  //  label.position= ccp(windowSize.width/2, windowSize.height/2);
  //  label2.position= ccp(windowSize.width/2, windowSize.height/2-50);
    bus.position=ccp(windowSize.width/2, 0);
    
    //bus.position=ccp(0, 0);
    window = windowSize;
    
//    [self addChild:label];
//    [self addChild:label2];
    [self addChild:bus];
    
    
    
    motionManager= [[CMMotionManager alloc]init];
    motionManager.deviceMotionUpdateInterval=1.0/60.0;
    [motionManager startDeviceMotionUpdates];
    
    widthBoundary = _road1.contentSize.width;
    heightBoundary = _road1.contentSize.height;
    roadVelocity = 2;
    

  /*
    
    if ([motionManager isGyroAvailable]) {
        if (![motionManager isGyroActive]) {
            [motionManager setGyroUpdateInterval:.1];
            [motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
                
                [label2 setString: [NSString stringWithFormat:@"%.02f", gyroData.rotationRate.x]];
                
   
                NSLog(@"The gyro data is %f",gyroData.rotationRate.y);
                
                if (gyroData.rotationRate.y>2 ) {
                    
                    velocity= CGPointMake(50.0f, 0.0f);
                }
                else if (gyroData.rotationRate.y<-2 ){
                    velocity= CGPointMake(-50.0f, 0.0f);
                }
                else
                {
                    velocity= CGPointMake(0.0f, 0.0f);
                
                }
             bus.position= ccpAdd(bus.position, velocity);
   
                            }];

    widthBoundary = _road1.contentSize.width;
    heightBoundary = _road1.contentSize.height;
    roadVelocity = 2;
            
        }
        else{
            
            UIAlertView *myAlert= [[UIAlertView alloc]initWithTitle:@"Alert!!" message:@"Gyro is missing" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Cancel", nil];
            [myAlert show];
            
        }
    }
    
    
    
  //  timer= [NSTimer scheduledTimerWithTimeInterval:(1.0/60.0) target:self selector:@selector(read) userInfo:nil repeats:YES];
      */
    
    
    
    
    

}


/*
-(void)read{

}
 */

             
#pragma mark update function
             
- (void)update:(CCTime)delta
{
    //this is for endless road. done by frank
    
    for (CCNode *road in _roads) {
        road.position = ccp(road.position.x, road.position.y - (roadVelocity));
        if (road.position.y <= (-1 * road.contentSize.height * 3)) {
            road.position = ccp(road.position.x, road.position.y + 3 *2 * road.contentSize.height - 50);
        }
    }
    
    timeSinceObstacle += delta; // delta is approximately 1/60th of a second
    
    // Check to see if two seconds have passed
    
    int minimum=50;
    int div=201;
    
    if (timeSinceObstacle >2.0f)
    {
        // Add a new obstacle
        
        
        CCSprite * newCar= [[CCSprite alloc]initWithImageNamed:@"carimage.png"];
        //CCSprite * newStudent= [[CCSprite alloc]initWithImageNamed:@"student copy.png"];

        newCar.scale=0.3;
        num=foo4random();
        xcoord=minimum+(num%div);
        newCar.position=ccp(xcoord,620);
        //newStudent.position=ccp(xcoord,500);
        [self addChild:newCar];
        [_cars addObject:newCar];
        //[self addChild:newStudent];
        //[_students addObject:newStudent];
        count++;
        // Then reset the timer.
        timeSinceObstacle = 0.0f;
    }
    
    
    // Find the things to remove
    NSMutableArray *toDelete = [NSMutableArray array];
    
    
    for (CCNode *car1 in _cars) {
        
        car1.position = ccp(car1.position.x, car1.position.y - (3));
        
        if (car1.position.y<-200) {
            
            [toDelete addObject:car1];
        }
        

    }
    
    [_cars removeObjectsInArray:toDelete];
    

    
    
    CMDeviceMotion *currentDeviceMotion= motionManager.deviceMotion;
    CMAttitude *currentAttitude= currentDeviceMotion.attitude;
   // [label setString: [NSString stringWithFormat:@"%.02f", currentAttitude.roll]];
  //                     label.rotation= CC_RADIANS_TO_DEGREES(currentAttitude.roll);
    
    
    if (currentAttitude.roll>0.045 ) {
        
        velocity= CGPointMake(3.0f, 0.0f);
    }
    else if (currentAttitude.roll<-0.045 ){
        velocity= CGPointMake(-3.0f, 0.0f);
    }
    else
    {
        velocity= CGPointMake(0.0f, 0.0f);
        
    }
    

    
    bus.position= ccpAdd(bus.position, velocity);

    
    
    // done by Frank. make sure the bus will not go beyond the screen.
    if (bus.position.x < 0) {
        bus.position = ccp(0, bus.position.y);
    }
    if (bus.position.x > window.width - bus.contentSize.width) {
        bus.position = ccp(window.width - bus.contentSize.width, bus.position.y);
    }
 
    if (bus.position.y < 0) {
        bus.position = ccp(bus.position.x, 0);
    }
    if (bus.position.y > window.height - bus.contentSize.height) {
        bus.position = ccp(bus.position.x, window.height - bus.contentSize.height);
    }
   
    
}

    
    
    
   /*
    CGSize windowSize= [[CCDirector sharedDirector] viewSize];
    
    
    
    timesliceformovewment+=delta;
    

        
    
    
    
    
    if (label2.position.x< windowSize.width || label2.position.x>10) {
        
    
    if (label.rotation<0) {
       velocity= CGPointMake(-5.0f, 0.0f);
    }
    else{
        velocity= CGPointMake(5.0f, 0.0f);
    }
   
   // label2.position= ccpAdd(label2.position, velocity);
    }
        timesliceformovewment=0;
    
    */
        
    
    




    

    
    
    

  

@end
