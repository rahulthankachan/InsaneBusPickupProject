#import "gameplay.h"
#import <CCActionInterval.h>
#import "GamePlayScene.h"

@import Foundation;

#import "CCScheduler.h"

#import "Header.h"


@implementation gameplay{
    
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
    NSMutableArray *_cars2; //horizontally moving cars
    float timesliceformovewment;
    CCNodeColor *bus;
    float timeSinceObstacle;
    int count;
    int xcoord;
    int num;
    int totalTime;
    CGFloat widthBoundary;//
    CGFloat heightBoundary;
    CGFloat roadVelocity;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *distLabel;
    //CCLabelTTF *countdownLabel;
    CGSize window;
    
    //variables for students
    CCTime _curTime;
    CCTime _lastTime;
    CCTime _timeSpan;
    NSMutableArray *_students;
    CCSprite *_student0;
    int _maxStudentNum; //maximum number of _students
    CGFloat initStudentXLeft;
    CGFloat initStudentXRight;
    CGFloat initStudentY;
    
    CCNode *_joypad;
    
    volatile BOOL car2created;
    
    BOOL _createdFlag;
}

-(id)init {
    if (self = [super init]) {
        score = 0;
        distance = 0;
        totalTime = 0;
        _createdFlag = false;
        car2created = false;
    }
    
    //starting of the joystick by Frank
    
    if(self != nil)
    {
        // set this so we can register with touch dispatcher
        
        //isTouchEnabled = YES;
        self.userInteractionEnabled = YES;
        //joypad = [[CCSprite spriteWithImageNamed:@"Joystick"]];
        _joypad.position = ccp(70, 70);
        _joypad.opacity = 0;
        //[self addChild:_joypad z:1];
        /*
         // load our joystick background
         joypad = [[CCSprite spriteWithImageNamed:<#(NSString *)#>]]
         joypad = [[CCSprite spriteWithFile:@"joypad.png"] retain];
         joypad.position = ccp(70,70);
         joypad.opacity = 0;
         [self addChild:joypad z:1];
         
         // load joypad button
         joybtn = [[CCSprite spriteWithFile:@"joybtn.png"] retain];
         joybtn.position = ccp(70,70);
         joybtn.opacity = 0;
         [self addChild:joybtn z:2];
         */
        
    }
    
    
    //end of the joystick
    
    
    return self;
}

- (void)didLoadFromCCB {
    CGSize windowSize= [[CCDirector sharedDirector] viewSize];
    
    //this line is for test
    //[[GamePlayScene alloc] updateScore:32];
    
    //   float delay = 1.0; // Number of seconds between each call of myTimedMethod:
    //   CCTimer *myTimer = [[CCTimer alloc] initWithTarget:self selector:@selector(myTimedMethod:) interval:delay]];
    
    //  CCTimer *myTimer = [[CCTimer alloc] ]
    
    //countdown before students appear
 //   countdownLabel = [[CCLabelTTF alloc] initWithString:@"" fontName:@"Hello" fontSize:30];
   // countdownLabel.position = ccp(windowSize.width - 100, windowSize.height - 50);
    //[self addChild:countdownLabel];
    
    
    //done by Frank
    _roads= @[_road1,_road2];
    _cars= [[NSMutableArray alloc]init];
    _cars2 = [[NSMutableArray alloc] init];
    
    // label= [[CCLabelTTF alloc]initWithString:@"Hello there !!" fontName:@"Hello" fontSize:15];
    // label2= [[CCLabelTTF alloc]initWithString:@"Hello there !!" fontName:@"Hello" fontSize:15];
    bus= [[CCNodeColor alloc]initWithColor:[CCColor colorWithUIColor:[UIColor cyanColor]] width:30 height:50];
    scoreLabel =[[CCLabelTTF alloc]initWithString:@"Score: 0" fontName:@"Hello" fontSize:15];
    distLabel =[[CCLabelTTF alloc]initWithString:@"Dist: 0" fontName:@"Hello" fontSize:15];
    
    //  label.position= ccp(windowSize.width/2, windowSize.height/2);
    //  label2.position= ccp(windowSize.width/2, windowSize.height/2-50);
    // label.position= ccp(windowSize.width/2, windowSize.height/2);
    //  label2.position= ccp(windowSize.width/2, windowSize.height/2-50);
    scoreLabel.position= ccp(windowSize.width-50,windowSize.height-10);
    distLabel.position= ccp(windowSize.width-50,windowSize.height-35);
    bus.position=ccp(windowSize.width/2, 0);
    
    //bus.position=ccp(0, 0);
    window = windowSize;
    [self addChild:scoreLabel];
    [self addChild:distLabel];
    //    [self addChild:label];
    //   [self addChild:label2];
    
    _students = [[NSMutableArray alloc] init];
    
    //initialize the first student
    _curTime = 0;
    _lastTime = 0;
    _maxStudentNum = 3;
    _timeSpan = 2.0;
    initStudentXLeft = window.width/8;
    initStudentXRight = window.width/8*7;
    initStudentY = window.height/8*9;
    _student0 = [[CCSprite alloc] initWithImageNamed:@"student_small.png"];
    BOOL posLeft = CCRANDOM_0_1()<=0.5?YES:NO;
    if (posLeft == YES) {
        _student0.position = ccp(initStudentXLeft, initStudentY);
    } else {
        _student0.position = ccp(initStudentXRight, initStudentY);
    }
    [_students addObject:_student0];
    
    //    [self addChild:label];
    //    [self addChild:label2];
    [self addChild:bus];
    //add the first student as a child of MainScene
    [self addChild:_student0];
    
    
    
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
    // size of the window
    CGSize windowSize = [[CCDirector sharedDirector] viewSize];

    
    // done by Varsha
    
    // distance = distance + 0.01;
    totalTime++;
    count++;
    if(count == 120)
    {
        //  score = score + 300;
        // totalTime = 0;
        distance = distance + 1;
        [distLabel setString:[NSString stringWithFormat:@"Dist: %d",distance]];
        count = 0;
    }
    if(totalTime == 240)
    {
        //  score = score +300;
        score=score+1;
        totalTime = 0;
    }
    [scoreLabel setString:[NSString stringWithFormat:@"Score: %d", score]];
    
    
    
    
    
    //this is for endless road. done by frank
    
    for (CCNode *road in _roads) {
        road.position = ccp(road.position.x, road.position.y - (roadVelocity));
        if (road.position.y <= (-1 * road.contentSize.height * 3)) {
            road.position = ccp(road.position.x, road.position.y + 3 *2 * road.contentSize.height - 50);
        }
    }


    
    //adding new students
    _curTime += delta;
    if (_curTime - _lastTime>_timeSpan) {
        _lastTime = _curTime;
        if([_students count]<_maxStudentNum&&CCRANDOM_0_1()<0.3333) {
            
            //Done by Yao Frank Fan
            //this part is to create a thread to do a countdown before the student appears
            if (true) {
                NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(createStudent:) object:nil];
                //NSLog(@"nihaoa");
                
                [myThread start];  // Actually create the thread
            }
            


        }
    }
    
    //updating position of each student
    for(int i = [_students count]-1;i>=0;i--) {
        ((CCSprite *)_students[i]).position = ccp(((CCSprite *)_students[i]).position.x, ((CCSprite *)_students[i]).position.y-roadVelocity);
        if(((CCSprite *)_students[i]).position.y<-13) {
            //remove this object
            [self removeChild:(CCSprite *)_students[i] cleanup:YES];
            [_students removeObject:(CCSprite *)_students[i]];
        }
    }
    
    
    
    timeSinceObstacle += delta; // delta is approximately 1/60th of a second
    
    // Check to see if two seconds have passed
    
    int minimum=50;
    int div=201;
    
    if (timeSinceObstacle >2.0f)
    {
        //generate a random number
        int number = arc4random_uniform(75);
        
        // Add a new obstacle
        
        if (number < 50) {
            CCSprite * newCar= [[CCSprite alloc]initWithImageNamed:@"carimage.png"];
            //CCSprite * newStudent= [[CCSprite alloc]initWithImageNamed:@"student copy.png"];
        
            newCar.scale=0.3;
            num=foo4random();
            xcoord=minimum+(num%div);
            newCar.position=ccp(xcoord,620);

            [self addChild:newCar];
            [_cars addObject:newCar];
            
            count++;
        } else {
            if (car2created == false) {
                car2created = true;
                NSLog(@"car image 2");
                CCSprite *newCar = [[CCSprite alloc] initWithImageNamed:@"carimage2.png"];
                
                newCar.scale = 0.3;
                num = foo4random();
                xcoord = minimum + (num % div);
                newCar.position = ccp(xcoord, 620);
                //newCar.position = ccp(windowSize.width - 100, windowSize.height - 10);
                [self addChild:newCar];
                [_cars2 addObject:newCar];
                
                count++;
            } else {
                //NSLog(@"car2 cannot be created.");
            }
            
            
        }
        
        // Then reset the timer.
        timeSinceObstacle = 0.0f;
    }
    
    
    // Find the things to remove
    NSMutableArray *toDelete = [NSMutableArray array];
    
    
    for (CCNode *car1 in _cars) {
        
        car1.position = ccp(car1.position.x, car1.position.y - (1.5));
        
        if (car1.position.y<-200) {
            
            [toDelete addObject:car1];
        }
        
        
    }
    
    [_cars removeObjectsInArray:toDelete];
    
    NSMutableArray *toDelete2 = [NSMutableArray array];
    //NSLog(@"%lu", (unsigned long)[_cars2 count]);
    for (CCNode *car2 in _cars2) {
        car2.position = ccp(car2.position.x, car2.position.y - (1.5));
        if (car2.position.y - bus.position.y <= 250) {
            if (car2.position.x != bus.position.x) {
                if (car2.position.x - bus.position.x > 0) {
                    car2.position = ccp(car2.position.x - 0.5, car2.position.y);
                } else {
                    car2.position = ccp(car2.position.x + 0.5, car2.position.y);
                }
            }
            

        }
        if (car2.position.y < -200) {
            [toDelete2 addObject:car2];
            car2created = false;
        }
    }
    [_cars2 removeObjectsInArray:toDelete2];
    
    
    
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



/*
 - (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
 {
 CCLOG(@"Received a touch");
 }
 
 */
/*
 - (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
 {
 // we want to know the location of our touch in this scene
 // CGPoint touchLocation = [touch locationInNode:self];
 CGPoint touchLocation = [touch locationInNode];
 [touch]
 // create a 'hero' sprite
 CCSprite *hero = [CCSprite spriteWithImageNamed:@"hero.png"];
 [self addChild:hero];
 // place the sprite at the touch location
 hero.position = touchLocation;
 }
 */

//A thread to create a student, and before that to make a countdown
//Not perfect yet, but it works
- (void)createStudent:(CCTime) delta {
    _createdFlag = true;
    
    CGSize windowSize = [[CCDirector sharedDirector] viewSize];
    
    CCLabelTTF *countdownLabel;

    countdownLabel = [[CCLabelTTF alloc] initWithString:@"" fontName:@"Hello" fontSize:30];
    countdownLabel.position = ccp(windowSize.width - 100, windowSize.height - 50);
    [self addChild:countdownLabel];
    
    for (int i = 3; i != 0; --i) {
        //NSLog(@"You have %d seconds left.", i);
        [countdownLabel setString:[NSString stringWithFormat:@"%d", i]];

        [NSThread sleepForTimeInterval:1.0f];
    }
    [countdownLabel setString:@"Incomming"];
    
    CCSprite *newStudent = [[CCSprite alloc] initWithImageNamed:@"student_small.png"];
    BOOL posLeft = CCRANDOM_0_1()<=0.5?YES:NO;
    if (posLeft == YES) {
        newStudent.position = ccp(initStudentXLeft, initStudentY);
    } else {
        newStudent.position = ccp(initStudentXRight, initStudentY);
    }
    [self addChild:newStudent];
    [_students addObject:newStudent];
    NSLog(@"student added.");

    
    
    [NSThread sleepForTimeInterval:1.0f];
    [countdownLabel setString:@""];

    _createdFlag = false;
}



@end
