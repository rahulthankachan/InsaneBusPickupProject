#import "gameplay.h"
#import <CCActionInterval.h>
#import "GamePlayScene.h"
@import Foundation;

#import "CCScheduler.h"

#import "Header.h"
#import "CrazyCarsTaxis.h"
#import "HealthBar.h"

@implementation gameplay{
    

#define foo4random() (arc4random() % ((unsigned)RAND_MAX + 1))
    CCNode *_road1;
    CCNode *_road2;
    CrazyCarsTaxis *_car1;
    NSArray *_roads;
    CGPoint velocity;
    NSMutableArray *_cars;    CCTime mytime;
    NSMutableArray *_cars2; //horizontally moving cars
    NSMutableArray *_coins;
    float timesliceformovewment;
    CCSprite *bus;
    float timeSinceObstacle;
    int count;
    int nfortime;
    int xcoord;
    int num;
    int totalTime;
    int numberOfCollisions;
    long s1,s2,s3;
    CGFloat widthBoundary;//
    CGFloat heightBoundary;
    CGFloat roadVelocity;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *distLabel;
    CCLabelTTF *countdownLabel;
    CGSize window;
    CCButton *retry;
 
    
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
    CCParticleExplosion *starsExplosion;
    BOOL levelCompleted;
    GameLevel *currentLevelInfo;
    CCSprite *college;
    CCSprite *parking;
    CCNode *sensor;


    CCNode *_joypad;
    
    volatile BOOL car2created;
    
    
    
    CCPhysicsNode *physicsNode;
    
    
    BOOL _createdFlag;
    

    HealthBar *progressTimer;
    CCParticleSmoke *smoke;
    ALBuffer* soundBufferHit;
    
    NSInteger level;
    NSInteger totalBumps;
}
- (void)retry {
    CCScene *gameplayscene = [CCBReader loadAsScene:@"gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayscene];
}

-(id)init {
    if (self = [super init]) {
        score = 0;
        distance = 0;
        totalTime = 0;
        _createdFlag = false;
        car2created = false;
        soundBufferHit = [[OALSimpleAudio sharedInstance] preloadEffect:@"hit.wav"];

        //modify the background music
        [[OALSimpleAudio sharedInstance] setBgVolume:0.8];

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
        
    }
#pragma mark init: Current Level Config
    
    /* Configures the current Level*/
    
    currentLevelInfo= [GameLevel sendLevelObjectForLevel:4];
    _maxStudentNum = currentLevelInfo.maxDistance;
    level=currentLevelInfo.levelNumber;
    totalBumps=5;

    
    /* Configures the current Level*/

    
    
    return self;
}
- (void)backbutton4 {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
}

- (void)didLoadFromCCB {
    
    
    //initialize the sound effect

    
    
    CGSize windowSize= [[CCDirector sharedDirector] viewSize];
    
    //this line is for test
    //[[GamePlayScene alloc] updateScore:32];

    
    //progressTimer = [[HealthBar alloc] initWithProgressTimerSprite:[[CCSprite alloc] initWithImageNamed:@"green_health_bar.png"]];
    //progressTimer = [HealthBar progressWithSprite:[[CCSprite alloc] initWithImageNamed:@"green_health_bar.png"]];
    progressTimer = [CCProgressNode progressWithSprite:[[CCSprite alloc] initWithImageNamed:@"heart-red.png"]];
    //self.progressTimer.type = kCCProgressTimerTypeHorizontalBarLR;
    [progressTimer setScale:0.15];
    progressTimer.percentage = 100;
    progressTimer.position = ccp(50, windowSize.height - 50);
    [self addChild:progressTimer z:1];
    
    //   float delay = 1.0; // Number of seconds between each call of myTimedMethod:
    //   CCTimer *myTimer = [[CCTimer alloc] initWithTarget:self selector:@selector(myTimedMethod:) interval:delay]];
    
    //  CCTimer *myTimer = [[CCTimer alloc] ]
    
    //Done by Yao Frank Fan
    //this part is to create a thread to do a countdown before the student appears


    
    
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(createStudent:) object:nil];
    
    [myThread start];  // Actually create the thread
    
    
    
    //done by Frank
    _roads= @[_road1,_road2];
    _cars= [[NSMutableArray alloc]init];
    _cars2 = [[NSMutableArray alloc] init];
    
    // label= [[CCLabelTTF alloc]initWithString:@"Hello there !!" fontName:@"Hello" fontSize:15];
    // label2= [[CCLabelTTF alloc]initWithString:@"Hello there !!" fontName:@"Hello" fontSize:15];
    bus = [[CCSprite alloc] initWithImageNamed:@"bus.png"];
    //bus= [[CCNodeColor alloc]initWithColor:[CCColor colorWithUIColor:[UIColor cyanColor]] width:30 height:50];
    scoreLabel =[[CCLabelTTF alloc]initWithString:@"Score: 0" fontName:@"Hello" fontSize:15];
    distLabel =[[CCLabelTTF alloc]initWithString:@"Dist: 0" fontName:@"Hello" fontSize:15];
    scoreLabel.position= ccp(windowSize.width-50,windowSize.height-10);
    distLabel.position= ccp(windowSize.width-50,windowSize.height-35);
    bus.position=ccp(windowSize.width/2, 90);

    
    countdownLabel = [[CCLabelTTF alloc] initWithString:@"" fontName:@"" fontSize:30];
    //countdownLabel.position = ccp(windowSize.width - 100, windowSize.height - 50);
    [self addChild:countdownLabel];

    
    physicsNode.collisionDelegate=self;
    //physicsNode.debugDraw=YES;
    bus.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0,0, bus.contentSize.width, bus.contentSize.height) cornerRadius:0];
    bus.physicsBody.type = CCPhysicsBodyTypeStatic;
    bus.physicsBody.mass=1;
    bus.zOrder=2;
    bus.physicsBody.collisionType=@"insaneBus";
    bus.physicsBody.collisionGroup=@"cheat";
    //bus.physicsBody.allowsRotation=NO;
    [physicsNode addChild:bus];
    
    
    //bus.position=ccp(0, 0);
    window = windowSize;
    [self addChild:scoreLabel];
    [self addChild:distLabel];
    
    _students = [[NSMutableArray alloc] init];
    
    //initialize the first student
    _curTime = 0;
    _lastTime = 0;
    _timeSpan = 2.0;
    initStudentXLeft = window.width/8;
    initStudentXRight = window.width/8*7;
    initStudentY = window.height/8*9;
    _student0 = [[CCSprite alloc] initWithImageNamed:@"student_small.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-1.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-2.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-3.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-4.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-5.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-6.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-7.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-8.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-9.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-10.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-11.png"];
    _student0 = [[CCSprite alloc] initWithImageNamed:@"character-12.png"];
    _student0.scale=.2;
    BOOL posLeft = CCRANDOM_0_1()<=0.5?YES:NO;
    if (posLeft == YES) {
        _student0.position = ccp(initStudentXLeft, initStudentY);
    } else {
        _student0.position = ccp(initStudentXRight, initStudentY);
    }
    [_students addObject:_student0];
    

    //add the first student as a child of MainScene
    //[self addChild:_student0];
    _student0.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,_student0.contentSize.width, _student0.contentSize.height) cornerRadius:0];;
    _student0.physicsBody.collisionType= @"student";
    _student0.physicsBody.type=CCPhysicsBodyTypeStatic;
    [physicsNode addChild:_student0];
    
    
    motionManager= [[CMMotionManager alloc]init];
    motionManager.deviceMotionUpdateInterval=1.0/60.0;
    [motionManager startDeviceMotionUpdates];
    
    widthBoundary = _road1.contentSize.width;
    heightBoundary = _road1.contentSize.height;
    roadVelocity = 5;
    
}




#pragma mark update function

- (void)update:(CCTime)delta
{
    
    if (roadVelocity) {
        
    // size of the window
    CGSize windowSize = [[CCDirector sharedDirector] viewSize];


    
    // done by Varsha
    
    // distance = distance + 0.01;
    nfortime++;
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
        //score=score+1;
        totalTime = 0;
    }
    [scoreLabel setString:[NSString stringWithFormat:@"Score: %d", score]];
    
    
    
    //this is for endless road. done by frank
    
    for (CCNode *road in _roads) {
        road.position = ccp(road.position.x, road.position.y - (roadVelocity));
        if (road.position.y <= (-1 * road.contentSize.height * 3)&&roadVelocity) {
            road.position = ccp(road.position.x, road.position.y + 3 *2 * road.contentSize.height - 50);
        }
    }
    
    
    
    
    
    
    
    if (distance<currentLevelInfo.maxDistance) {
        
        
        
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
                    
                    //CCSprite *newStudent = [[CCSprite alloc] initWithImageNamed:@"student_small.png"];
                    //         BOOL posLeft = CCRANDOM_0_1()<=0.5?YES:NO;
                    //       if (posLeft == YES) {
                    //         newStudent.position = ccp(initStudentXLeft, initStudentY);
                    //   } else {
                    //       newStudent.position = ccp(initStudentXRight, initStudentY);
                }
                /*
                 newStudent.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newStudent.contentSize.width, newStudent.contentSize.height) cornerRadius:0];;
                 newStudent.physicsBody.collisionType= @"student";
                 newStudent.physicsBody.type=CCPhysicsBodyTypeStatic;
                 [physicsNode addChild:newStudent];
                 
                 [_students addObject:newStudent];
                 
                 */
            }
        }
        

        
        
        
        timeSinceObstacle += delta;
        
        
        int minimum=50;
        int div=201;
        

    
    if (timeSinceObstacle >1.25f)
    {
         CrazyCarsTaxis * newCar;
        
        // Add a new obstacle
        if (level == 1) {
            //generate a random number
            int number = arc4random_uniform(75);

            if (number < 50) {
                newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
                newCar.scale=0.3;
                num=foo4random();
                xcoord=minimum+(num%div);
                newCar.position=ccp(xcoord,620);
                newCar.type=1;
                
                count++;
            } else {
                if (car2created == false) {
                    
                    car2created = true;
                    //NSLog(@"car image 2");
                    newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage2.png"];
                    newCar.type=2;
                    
                    newCar.scale = 0.3;
                    num = foo4random();
                    xcoord = minimum + (num % div);
                    newCar.position = ccp(xcoord, 620);
                    //newCar.position = ccp(windowSize.width - 100, windowSize.height - 10);
                    // [self addChild:newCar];
                    //  [_cars2 addObject:newCar];
                    
                    count++;
                } else {
                    //NSLog(@"car2 cannot be created.");
                }
                
                
            }
        }
        
        else if (level == 2) {
            //generate a random number
            int number = arc4random_uniform(100);

            if (number < 50) {
                newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
                //CCSprite * newStudent= [[CCSprite alloc]initWithImageNamed:@"student copy.png"];
                //  coin= [[CCSprite alloc]initWithImageNamed:@"coin.png"];
                newCar.scale=0.3;
                num=foo4random();
                xcoord=minimum+(num%div);
                newCar.position=ccp(xcoord,620);
                newCar.type=1;
                
                // [self addChild:newCar];
                //  [_cars addObject:newCar];
                
                count++;
            } else if (number >= 50 && number < 75) {
                //NSLog(@"car image 2");
                newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage2.png"];
                newCar.type=2;
                
                newCar.scale = 0.3;
                num = foo4random();
                xcoord = minimum + (num % div);
                newCar.position = ccp(xcoord, 620);
                //newCar.position = ccp(windowSize.width - 100, windowSize.height - 10);
                // [self addChild:newCar];
                //  [_cars2 addObject:newCar];
                
                count++;
                
                
            } else {
                newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage3.png"];
                newCar.type=3;
                
                newCar.scale = 0.3;
                num = foo4random();
                xcoord = minimum + (num % div);
                newCar.position = ccp(xcoord, 620);

                count++;
                
                
            }
        } else if (level == 3) {
            //generate a random number
            int number = arc4random_uniform(100);
            
            if (number < 25) {
                newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];
                //CCSprite * newStudent= [[CCSprite alloc]initWithImageNamed:@"student copy.png"];
                //  coin= [[CCSprite alloc]initWithImageNamed:@"coin.png"];
                newCar.scale=0.3;
                num=foo4random();
                xcoord=minimum+(num%div);
                newCar.position=ccp(xcoord,620);
                newCar.type=1;
                
                // [self addChild:newCar];
                //  [_cars addObject:newCar];
                
                count++;
            } else if (number >= 25 && number < 50) {
                //NSLog(@"car image 2");
                newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage2.png"];
                newCar.type=2;
                
                newCar.scale = 0.3;
                num = foo4random();
                xcoord = minimum + (num % div);
                newCar.position = ccp(xcoord, 620);
                //newCar.position = ccp(windowSize.width - 100, windowSize.height - 10);
                // [self addChild:newCar];
                //  [_cars2 addObject:newCar];
                
                count++;
                
                
            } else if (number >= 50 && number < 75) {
                newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage3.png"];
                newCar.type=3;
                
                newCar.scale = 0.3;
                num = foo4random();
                xcoord = minimum + (num % div);
                newCar.position = ccp(xcoord, 620);
                
                count++;
                
                
            } else {
                newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage6.png"];
                newCar.type=4;
                
                newCar.scale = 0.3;
                num = foo4random();
                xcoord = minimum + (num % div);
                newCar.position = ccp(xcoord, 620);
                
                count++;
            }
        } else if (level == 4) {
            //generate a random number
            int number = arc4random_uniform(100);
            
            if (number < 25) {
                newCar= [[CrazyCarsTaxis alloc]initWithImageNamed:@"carimage.png"];

                newCar.scale=0.3;
                num=foo4random();
                xcoord=minimum+(num%div);
                newCar.position=ccp(xcoord,620);
                newCar.type=1;
                
                // [self addChild:newCar];
                //  [_cars addObject:newCar];
                
                count++;
            } else if (number >= 25 && number < 50) {
                //NSLog(@"car image 2");
                newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage2.png"];
                newCar.type=2;
                
                newCar.scale = 0.3;
                num = foo4random();
                xcoord = minimum + (num % div);
                newCar.position = ccp(xcoord, 620);
                //newCar.position = ccp(windowSize.width - 100, windowSize.height - 10);
                // [self addChild:newCar];
                //  [_cars2 addObject:newCar];
                
                count++;
                
                
            } else if (number >= 50 && number < 75) {
                newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage3.png"];
                newCar.type=3;
                
                newCar.scale = 0.3;
                num = foo4random();
                xcoord = minimum + (num % div);
                newCar.position = ccp(xcoord, 620);
                
                count++;
                
                
            } else {
                newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage6.png"];
                newCar.type=4;
                
                NSLog(@"In level 4, car 4 has been added.");

                newCar.scale = 0.3;
                num = foo4random();
                xcoord = minimum + (num % div);
                newCar.position = ccp(xcoord, 0);
                
                count++;
            }
        }
       
        
        /*
        if (car2created) {
            [progressTimer setPercentage:80];

        } else {
            [progressTimer setPercentage:100];

        }
         */
        
        
        
        if(newCar){
        newCar.scale=0.3;
        num=foo4random();
        xcoord=minimum+(num%div);
        //newCar.position=ccp(xcoord,620);
        //newStudent.position=ccp(xcoord,500);
       // [self addChild:newCar];
        newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
        newCar.physicsBody.density=0.1;
      //  coin.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,coin.contentSize.width, coin.contentSize.height) cornerRadius:0];
     //   coin.physicsBody.density=0.1;

        newCar.physicsBody.collisionType=@"level";
       // newCar.physicsBody.collisionGroup=@"cheat";
      
            
            
        [physicsNode addChild:newCar];
        [_cars addObject:newCar];
            

            count++;
        
        }
        // Then reset the timer.
//        //moving the cars left and right, without their positions being fixed.. don by varsha
//        BOOL genPos = CCRANDOM_0_1()>=0.5?YES:NO;
//        if(nfortime > 150)
//        {
//            if(genPos == YES)
//            {
//                id theAction = [CCActionMoveTo actionWithDuration:4 position:ccp(200,200)];
//                [newCar runAction:theAction];
//            }
//            else
//            {
//                id theAction = [CCActionMoveTo actionWithDuration:4 position:ccp(-75,200)];
//                [newCar runAction:theAction];
//            }
//        }
        timeSinceObstacle = 0.0f;
    }
        
    }

    
    
    
    
    
    
    
    /////////////////* Show the final Scne*/////////////////////////
    if(distance>currentLevelInfo.maxDistance)
    {
       
        if(distance>currentLevelInfo.maxDistance+5){
        if(!parking)
        {
            parking= [[CCSprite alloc]initWithImageNamed:@"Parking.png"];
            parking.scale=0.2;
//            parking.physicsBody.velocity= CGPointMake(0, 0);
//            parking.physicsBody=[CCPhysicsBody bodyWithRect:CGRectMake(0, 0,600, 20) cornerRadius:0];
            
            
            parking.parent.zOrder=5;
        
            
            sensor=[[CCNode alloc]init];
            sensor.physicsBody=[CCPhysicsBody bodyWithRect:CGRectMake(0, 0,600, 20) cornerRadius:0];
            //sensor.physicsBody.sensor=TRUE;
            sensor.physicsBody.collisionType=@"Parking";
            
            
            
            int xcoord= 320/2;
            parking.position=ccp(xcoord,550);
            sensor.position=ccp(0,720);
            [physicsNode addChild:parking];
            [physicsNode addChild:sensor];
            
        
        }
        }
        
        NSLog(@"tHIS IS THE HIDDEN VELOVITY physics node %f",physicsNode.physicsBody.velocity.y) ;
        NSLog(@"tHIS IS THE HIDDEN VELOVITY parking %f",parking.physicsBody.velocity.y) ;
        NSLog(@"tHIS IS THE HIDDEN VELOVITY %f",[parking parent].physicsBody.velocity.y) ;
        
        
        if (parking) {
            parking.position = ccp(parking.position.x, parking.position.y - roadVelocity);
        }
        if (sensor) {
            sensor.position = ccp(sensor.position.x, sensor.position.y - roadVelocity);
        }

    
    
    }
    if(distance==currentLevelInfo.maxDistance+6)
    {
        parking.physicsBody.velocity= CGPointMake(0, 0);
        
//        if(distance>currentLevelInfo.maxDistance+5){
//            if(!college)
//            {
//                college= [[CCSprite alloc]initWithImageNamed:@"Parking.png"];
//                college.scale=0.2;
//                
//                int xcoord= 320/2-college.boundingBox.size.width/2;
//                college.position=ccp(xcoord,620);
//                [physicsNode addChild:college];
//                
//            }
//        }
//        
//        
//        if (college) {
//            college.position = ccp(college.position.x, college.position.y - roadVelocity);
//        }
//        
    
    
    }
    
    /////////////////* Show the final Scne*/////////////////////////
    
    
    NSMutableArray *toDelete = [NSMutableArray array];
    
    
    //updating position of each student
    for(int i = [_students count]-1;i>=0;i--) {
        ((CCSprite *)_students[i]).position = ccp(((CCSprite *)_students[i]).position.x, ((CCSprite *)_students[i]).position.y-roadVelocity);
        if(((CCSprite *)_students[i]).position.y<-13) {
            //remove this object
            //     [self removeChild:(CCSprite *)_students[i] cleanup:YES];
            //     [_students removeObject:(CCSprite *)_students[i]];
            
            [toDelete addObject: _students[i]];
        }
    }
 
    
    
    // Find the things to remove

    if (roadVelocity) {
        
    
    for (CrazyCarsTaxis *car1 in _cars) {
            switch (car1.type) {
                    
                case 1:
                    car1.position = ccp(car1.position.x, car1.position.y - .5);
                    
                    
                    
                    if (car1.position.y < -car1.contentSize.height) {
                        
                        [toDelete addObject:car1];
                    }
                    break;
                break;
                
            case 2:
                
                car1.position = ccp(car1.position.x, car1.position.y - 0.5);
                if (car1.position.y - bus.position.y <= 250) {
                    if (car1.position.x != bus.position.x) {
                        if (car1.position.x - bus.position.x - 15 > 0) {
                            car1.position = ccp(car1.position.x - 1, car1.position.y);
                        } else {
                            car1.position = ccp(car1.position.x + 1, car1.position.y);
                        }
                        
                        
                    }
                    if (car1.position.y < -car1.contentSize.height) {
                        [toDelete addObject:car1];
                        car2created = false;
                    }
                    
                    break;
                    
                case 3:
                    car1.position = ccp(car1.position.x, car1.position.y - 3);
                    
                    
                    
                    if (car1.position.y < -car1.contentSize.height) {
                        
                        [toDelete addObject:car1];
                    }
                    
                    break;
                    
                case 4:
                    
                    car1.position = ccp(car1.position.x, car1.position.y + 2.5);
                    
                    if (car1.position.y > windowSize.height || car1.position.y < -500) {
                   // if (car1.position.y < -car1.contentSize.height) {
                        
                        [toDelete addObject:car1];
                    }
                    
                    break;

                default:
                    break;
            }
        }
        
//        else if (level == 2) {
//            switch (car1.type) {
//
//                case 1:
//                    
//                    car1.position = ccp(car1.position.x, car1.position.y - .5);
//                    
//                    
//                    
//                    if (car1.position.y < -car1.contentSize.height) {
//                        
//                        [toDelete addObject:car1];
//                    }
//                    break;
//                    
//                case 2:
//                    
//                    car1.position = ccp(car1.position.x, car1.position.y - .5);
//                    if (car1.position.y - bus.position.y <= 250) {
//                        if (car1.position.x != bus.position.x) {
//                            if (car1.position.x - bus.position.x - 15 > 0) {
//                                car1.position = ccp(car1.position.x - 1, car1.position.y);
//                            } else {
//                                car1.position = ccp(car1.position.x + 1, car1.position.y);
//                            }
//                        }
//                        
//                        
//                    }
//                    if (car1.position.y < -car1.contentSize.height) {
//                        [toDelete addObject:car1];
//                        car2created = false;
//                    }
//                    
//                    break;
//                case 3:
//                    car1.position = ccp(car1.position.x, car1.position.y - 3);
//                    
//                    
//                    
//                    if (car1.position.y < -car1.contentSize.height) {
//                        
//                        [toDelete addObject:car1];
//                    }
//                    
//                    break;
//                    
//                default:
//                    break;
//            }
//        } else if (level == 3) {
//            switch (car1.type) {
//                    
//                case 1:
//                    
//                    car1.position = ccp(car1.position.x, car1.position.y - .5);
//                    
//                    
//                    
//                    if (car1.position.y < -car1.contentSize.height) {
//                        
//                        [toDelete addObject:car1];
//                    }
//                    break;
//                    
//                case 2:
//                    
//                    car1.position = ccp(car1.position.x, car1.position.y - .5);
//                    if (car1.position.y - bus.position.y <= 250) {
//                        if (car1.position.x != bus.position.x) {
//                            if (car1.position.x - bus.position.x - 15 > 0) {
//                                car1.position = ccp(car1.position.x - 1, car1.position.y);
//                            } else {
//                                car1.position = ccp(car1.position.x + 1, car1.position.y);
//                            }
//                        }
//                        
//                        
//                    }
//                    if (car1.position.y < -car1.contentSize.height) {
//                        [toDelete addObject:car1];
//                        car2created = false;
//                    }
//                    
//                    break;
//                    
//                case 3:
//                    car1.position = ccp(car1.position.x, car1.position.y - 3);
//                    
//                    
//                    
//                    if (car1.position.y < -car1.contentSize.height) {
//                        
//                        [toDelete addObject:car1];
//                    }
//                    
//                    break;
//                    
//                default:
//                    break;
//            }
//        } else if (level == 4) {
//            switch (car1.type) {
//                    
//                case 1:
//                    
//                    car1.position = ccp(car1.position.x, car1.position.y - .5);
//                    
//                    
//                    
//                    if (car1.position.y < -car1.contentSize.height) {
//                        
//                        [toDelete addObject:car1];
//                    }
//                    break;
//                    
//                case 2:
//                    
//                    car1.position = ccp(car1.position.x, car1.position.y - .5);
//                    if (car1.position.y - bus.position.y <= 250) {
//                        if (car1.position.x != bus.position.x) {
//                            if (car1.position.x - bus.position.x - 15 > 0) {
//                                car1.position = ccp(car1.position.x - 1, car1.position.y);
//                            } else {
//                                car1.position = ccp(car1.position.x + 1, car1.position.y);
//                            }
//                        }
//                        
//                        
//                    }
//                    if (car1.position.y < -car1.contentSize.height) {
//                        [toDelete addObject:car1];
//                        car2created = false;
//                    }
//                    
//                    break;
//                    
//                case 3:
//                    car1.position = ccp(car1.position.x, car1.position.y - 3);
//                    
//                    
//                    
//                    if (car1.position.y < -car1.contentSize.height) {
//                        
//                        [toDelete addObject:car1];
//                    }
//                    
//                    break;
//                    
//                case 4:
//                    
//                    car1.position = ccp(car1.position.x, car1.position.y - 0.5);
//                    
//                    
//                    if (car1.position.y < -car1.contentSize.height) {
//                        
//                        [toDelete addObject:car1];
//                    }
//                    
//                    break;
//                default:
//                    break;
//            }
//        }
//        
        

        
        
    }
    
    }


    
    [_cars removeObjectsInArray:toDelete];
    for ( CCNode *temp in toDelete) {
        [temp removeFromParent];

    }
    [toDelete removeAllObjects];
    
  //  NSLog(@"The number of elements are %i", [[physicsNode children]count]);
    

    CMDeviceMotion *currentDeviceMotion= motionManager.deviceMotion;
    CMAttitude *currentAttitude= currentDeviceMotion.attitude;
    // [label setString: [NSString stringWithFormat:@"%.02f", currentAttitude.roll]];
    //                     label.rotation= CC_RADIANS_TO_DEGREES(currentAttitude.roll);
        NSLog(@" tHE ROLL IS %f",currentAttitude.roll);
        
        
   ///////////////////////////////////////This is used to control the gyro////////////////////////
        if (currentAttitude.roll>0.015 ) {
            
            velocity= CGPointMake(0.3f, 0.0f);
        }
        else if (currentAttitude.roll<-0.015 ){
            velocity= CGPointMake(-0.3f, 0.0f);
        }
        else
        {
            velocity= CGPointMake(0.0f, 0.0f);
            
        }
        
        
        
        if (currentAttitude.roll>0.025 ) {
            
            velocity= CGPointMake(1.0f, 0.0f);
        }
        else if (currentAttitude.roll<-0.025 ){
            velocity= CGPointMake(-1.0f, 0.0f);
        }

        
        if (currentAttitude.roll>0.035 ) {
            
            velocity= CGPointMake(2.0f, 0.0f);
        }
        else if (currentAttitude.roll<-0.025 ){
            velocity= CGPointMake(-2.0f, 0.0f);
        }

        
        if (currentAttitude.roll>0.045 ) {
            
            velocity= CGPointMake(3.5f, 0.0f);
        }
        else if (currentAttitude.roll<-0.045 ){
            velocity= CGPointMake(-3.5f, 0.0f);
        }
        
        if (currentAttitude.roll>0.055 ) {
            
            velocity= CGPointMake(4.0f, 0.0f);
        }
        else if (currentAttitude.roll<-0.055 ){
            velocity= CGPointMake(-4.0f, 0.0f);
        }
        
        
    
    if (currentAttitude.roll>0.065 ) {
        
        velocity= CGPointMake(5.0f, 0.0f);
    }
    else if (currentAttitude.roll<-0.065 ){
        velocity= CGPointMake(-5.0f, 0.0f);
    }
        
        if (currentAttitude.roll>0.070 ) {
            
            velocity= CGPointMake(5.3f, 0.0f);
        }
        else if (currentAttitude.roll<-0.070 ){
            velocity= CGPointMake(-5.3f, 0.0f);
        }

        if (currentAttitude.roll>0.20 ) {
            
            velocity= CGPointMake(6.0f, 0.0f);
        }
        else if (currentAttitude.roll<-0.20 ){
            velocity= CGPointMake(-6.0f, 0.0f);
        }

        
        ///////////////////////////////////////This is used to control the gyro////////////////////////


    
    
    bus.position= ccpAdd(bus.position, velocity);
    
    if (smoke) {
        smoke.position = ccp(bus.position.x, bus.position.y + bus.contentSize.height / 2 - 10);
    }
    
    // done by Frank. make sure the bus will not go beyond the screen.
    if (bus.position.x < 0 + bus.contentSize.width / 2) {
        bus.position = ccp(0 + bus.contentSize.width / 2, bus.position.y);
    }
    if (bus.position.x > window.width - bus.contentSize.width / 2) {
        bus.position = ccp(window.width - bus.contentSize.width / 2, bus.position.y);
    }
    
    if (bus.position.y < 0) {
        bus.position = ccp(bus.position.x, 0);
    }
    if (bus.position.y > window.height - bus.contentSize.height) {
        bus.position = ccp(bus.position.x, window.height - bus.contentSize.height);
    }
    
    }//// end of if velocity
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



 - (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
 {
 // we want to know the location of our touch in this scene

    CGPoint touchLocation = [touch locationInNode:self];
     NSLog(@"The x coordinate is %f",touchLocation.x);
      NSLog(@"The y coordinate before is %f",touchLocation.y);
     

     if (touchLocation.x>180) {
         [bus.physicsBody applyImpulse:ccp(0, 400)];
     }
     else{
         [bus.physicsBody applyImpulse:ccp(0, -400)];
     
     }
     NSLog(@"The y coordinate is %f",touchLocation.y);
     
     
 // create a 'hero' sprite
 //CCSprite *hero = [CCSprite spriteWithImageNamed:@"hero.png"];
 //[self addChild:hero];
 // place the sprite at the touch location
 //hero.position = touchLocation;
 }





//A thread to create a student, and before that to make a countdown
//Not perfect yet, but it works
- (void)createStudent:(CCTime) delta {
    _createdFlag = true;
    
    CGSize windowSize = [[CCDirector sharedDirector] viewSize];
    
    BOOL posLeft = CCRANDOM_0_1()<=0.5?YES:NO;
    
    if (posLeft == NO) {
        countdownLabel.position = ccp(windowSize.width - 100, windowSize.height - 50);

    } else {
        countdownLabel.position = ccp(100, windowSize.height - 50);

    }
    
    //CCLabelTTF *countdownLabel;
    for (int i = 3; i != 0; --i) {
        //NSLog(@"You have %d seconds left.", i);
        [countdownLabel setString:[NSString stringWithFormat:@"%d", i]];

        [NSThread sleepForTimeInterval:1.0f];
    }
    [countdownLabel setString:@"Incomming"];
    
    int number= arc4random_uniform(11)+1;
    CCSprite *newStudent = [[CCSprite alloc] initWithImageNamed:[NSString stringWithFormat:@"character-%i.png",number]];
    newStudent.scale=.2;
    
    if (posLeft == YES) {

        newStudent.position = ccp(initStudentXLeft, initStudentY);
    } else {

        newStudent.position = ccp(initStudentXRight, initStudentY);
    }
    
    newStudent.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newStudent.contentSize.width, newStudent.contentSize.height) cornerRadius:0];;
    newStudent.physicsBody.collisionType= @"student";
    newStudent.physicsBody.type=CCPhysicsBodyTypeStatic;
    [physicsNode addChild:newStudent];
    
    [_students addObject:newStudent];
    //NSLog(@"student added.");

    
    
    [NSThread sleepForTimeInterval:1.0f];
    [countdownLabel setString:@""];
    _createdFlag = false;
}








-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair insaneBus:(CCNode*)insaneBus student:(CCNode*)student {
    
    NSLog(@"Collision Student");
    [self applyEnergizeEffect:student];

    [student removeFromParent];
    score=score+1;
    
    [[OALSimpleAudio sharedInstance] playEffect:@"cha-ching.wav" loop:NO];
    
    return TRUE;
}


-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair insaneBus:(CCNode*)insaneBus Parking:(CCNode*)Parking {
    
    NSLog(@"Yay! The level is completed");
    roadVelocity=0;
    parking.physicsBody.velocity= CGPointMake(0, 0);
    
    CCScene *gameplayscene = [CCBReader loadAsScene:@"EndOfLevel"];
    [[CCDirector sharedDirector] replaceScene:gameplayscene];
    //oh man, collision...
   // CCScene *mainscene = [CCBReader loadAsScene:@"GameFinScene"];
   // [[CCDirector sharedDirector] replaceScene:mainscene];

    return TRUE;
}

-(void) ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair insaneBus:(CCNode *)insaneBus level:(CCSprite *)level {
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"CarCollision"];
    explosion.autoRemoveOnFinish = TRUE;
    explosion.position = level.position;
    [level.parent addChild:explosion];
    level.position = ccp(1000, 1000);
    //temporarily
    progressTimer.percentage -= 10;
    if (progressTimer.percentage <= 100) {
        /*
        if (smoke) {
            [smoke removeFromParent];
        }
         */
        [self enableSmoke];
    }
    
    [[OALSimpleAudio sharedInstance] playBuffer:soundBufferHit volume:1.0f pitch:1.0f pan:0.0f loop:NO];
    if (progressTimer.percentage<=0) {
        [insaneBus removeFromParent];
        [self gameEnds];
    }

}


/****
 call like this
 
 CCScene *myScene = [[CCDirector sharedDirector] runningScene];
 CCNode *node = [myScene.children objectAtIndex:0];
 UIImage *img = [AppController screenshotWithStartNode:node];
 
 **/
+(UIImage*) screenshotWithStartNode:(CCNode*)stNode
{
    [CCDirector sharedDirector].nextDeltaTimeZero = YES;
    
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    CCRenderTexture* renTxture = [CCRenderTexture renderTextureWithWidth:winSize.width height:winSize.height];
    [renTxture begin];
    [stNode visit];
    [renTxture end];
    
    return [renTxture getUIImage];
}

- (void)gameEnds {
    CCScene *gameplayscene = [CCBReader loadAsScene:@"gameEnd"];
    [[CCDirector sharedDirector] replaceScene:gameplayscene];
}

-(void) enableSmoke
{
    smoke = [[CCParticleSmoke alloc] init];
    [smoke setAutoRemoveOnFinish:YES];
    [smoke setScaleX:0.8];
    [smoke setStartSize:10];
    [smoke setEndSize:10];
    [smoke setGravity:ccp(0,-90)];
    [smoke setTotalParticles:50];
    [smoke setDuration:3];
    //smoke.position = ccp(200, 200);
    //smoke.position = ccp(bus.position.x, bus.position.y);
    [self addChild:smoke];
}

-(void) applyEnergizeEffect:(CCNode*) student
{
    CCParticleExplosion *meteor = [[CCParticleExplosion alloc] init];
    [meteor setAutoRemoveOnFinish:YES];
    [meteor setTotalParticles:200];
    
    [meteor setStartSize:2];
    [meteor setEndSize:2];
    
    [meteor setDuration:3];
    meteor.position = ccp(student.position.x, student.position.y);
    //meteor.position = ccp(window.width/2, window.height/2);
    
    [self addChild:meteor];
    
}

@end
