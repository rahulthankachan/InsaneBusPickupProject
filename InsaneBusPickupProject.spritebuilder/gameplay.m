#import "gameplay.h"
#import <CCActionInterval.h>
#import "GamePlayScene.h"
@import Foundation;

#import "CCScheduler.h"

#import "Header.h"
#import "CrazyCarsTaxis.h"
#import "HealthBar.h"
#import "ObjectOnRoad.h"
#import "CapacityOfBus.h"

@implementation gameplay{
    
    
#define foo4random() (arc4random() % ((unsigned)RAND_MAX + 1))
    NSString *buttonHitSoundEffect;
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
    //   long s1,s2,s3;
    CGFloat widthBoundary;//
    CGFloat heightBoundary;
    CGFloat roadVelocity;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *distLabel;
    
    CCLabelTTF *scorelabel1;
    CGSize window;
    CCButton *retry;
    CCButton *menubutton;
    
    
    //variables for students
    CCTime _curTime;
    CCTime _lastTime;
    CCTime _timeSpan;
    NSMutableArray *_students;
    CCSprite *_student0;

    CGFloat initStudentXLeft;
    CGFloat initStudentXRight;
    CGFloat initStudentY;
    CCParticleExplosion *starsExplosion;
    BOOL levelCompleted;
    GameLevel *currentLevelInfo;
    CCSprite *college;
    CCSprite *parking;
    CCNode *sensor;
    NSMutableArray *patternCars;
    
    
    CCNode *_joypad;
    
    volatile BOOL car2created;
    
    
    
    CCPhysicsNode *_physicsNode;
    
    
    BOOL _createdFlag;
    
    
    HealthBar *progressTimer;
    CCParticleSmoke *smoke;
    ALBuffer* soundBufferHit;
    BOOL trafficComing;
    BOOL patternComing;
    ObjectOnRoad *pizza;
    ObjectOnRoad *gas;
    ObjectOnRoad *roadBarrier;
    ObjectOnRoad *timber;
    ObjectOnRoad *horizontalBus;
    ObjectOnRoad *grenade;
    ObjectOnRoad *powerUp;
    
    
    NSInteger capacityOfBus;
    NSInteger offsetVelocityOfCars;
    CGFloat baseRoadVelocity;
    CGFloat capRoadVelocity;

    NSInteger totalBumps;
    
    
    NSInteger level;
    NSInteger leftBound;
    NSInteger rightBound;
    NSInteger _maxDistance;
    NSInteger _maxStudentNum;
    
    
    
    CCLabelTTF *countdownLabelLeft;
    CCLabelTTF *countdownLabelRigh;
    CCLabelTTF *countdownLabel;
    
}
- (void)retry {
    CCScene *gameplayscene = [CCBReader loadAsScene:@"gameplay"];
     [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
    [[CCDirector sharedDirector] replaceScene:gameplayscene];
}

- (void)menubutton {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[OALSimpleAudio sharedInstance] playEffect:buttonHitSoundEffect loop:NO];
    [[CCDirector sharedDirector] replaceScene:mainscene];
}

-(id)init {
    if (self = [super init]) {
        score = 0;
        distance = 0;
        totalTime = 0;
        _createdFlag = false;
        car2created = false;
        soundBufferHit = [[OALSimpleAudio sharedInstance] preloadEffect:@"hit.wav"];
        trafficComing = true;
        patternComing = false;
        //modify the background music
        [[OALSimpleAudio sharedInstance] setBgVolume:0.8];
        
    }
    

#pragma mark init: Current Level Config
    
    /* Configures the current Level*//* Configures the current Level*//* Configures the current Level*//* Configures the current Level*/
    /* Configures the current Level*//* Configures the current Level*//* Configures the current Level*//* Configures the current Level*/
    /* Configures the current Level*//* Configures the current Level*//* Configures the current Level*//* Configures the current Level*/

    level = [[[NSUserDefaults standardUserDefaults] objectForKey:@"levelSelected"] intValue];
    currentLevelInfo= [GameLevel sendLevelObjectForLevel:level];
    _maxDistance= currentLevelInfo.maxDistance;
    _maxStudentNum= currentLevelInfo.maxStudents;
    level=currentLevelInfo.levelNumber;
    
    
    //  level = 1;
    
    
    
    totalBumps=5;
    
    /* Configures the current Level*//* Configures the current Level*//* Configures the current Level*//* Configures the current Level*/
    /* Configures the current Level*//* Configures the current Level*//* Configures the current Level*//* Configures the current Level*/
    
    
    
    return self;
}



#pragma mark didLoadfromCCB
- (void)didLoadFromCCB {
    
    
    /*Will give the bounds of the physics node

     Will give the bounds of the physics node
     */
    leftBound= _physicsNode.position.x;
    rightBound=_physicsNode.contentSize.width;
    
    countdownLabelLeft = [[CCLabelTTF alloc] initWithString:@"" fontName:@"" fontSize:30];
    countdownLabel = [[CCLabelTTF alloc] initWithString:@"" fontName:@"" fontSize:30];
    [self addChild:countdownLabel];
    
    
    //initialize the sound effect
   
    buttonHitSoundEffect = @"boom-kick.wav";
    
    
    CGSize windowSize= [[CCDirector sharedDirector] viewSize];
    


    progressTimer = [CCProgressNode progressWithSprite:[[CCSprite alloc] initWithImageNamed:@"heart-red.png"]];
    [progressTimer setScale:0.15];
    progressTimer.percentage = 100;
    progressTimer.position = ccp(50, windowSize.height - 50);
    progressTimer.zOrder=10;
    [self addChild:progressTimer z:1];
    
    
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
    scoreLabel =[[CCLabelTTF alloc]initWithString:@"Students: 0" fontName:@"Hello" fontSize:15];
    distLabel =[[CCLabelTTF alloc]initWithString:@"Distance: 0" fontName:@"Hello" fontSize:15];
    scoreLabel.position= ccp(windowSize.width-50,windowSize.height-10);
    distLabel.position= ccp(windowSize.width-50,windowSize.height-35);
    bus.position=ccp(windowSize.width/2, 90);
    

    
    
    _physicsNode.collisionDelegate=self;
    _physicsNode.debugDraw=YES;
    bus.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0,0, bus.contentSize.width-5, bus.contentSize.height) cornerRadius:0];
    bus.physicsBody.type = CCPhysicsBodyTypeStatic;
    bus.physicsBody.mass=1;
    bus.zOrder=2;
    bus.physicsBody.collisionType=@"insaneBus";
    bus.physicsBody.collisionGroup=@"cheat";
    //bus.physicsBody.allowsRotation=NO;
    [_physicsNode addChild:bus];
    
    
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
    //    [self addChild:_student0];
    //    _student0.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,_student0.contentSize.width, _student0.contentSize.height) cornerRadius:0];;
    //    _student0.physicsBody.collisionType= @"student";
    //    _student0.physicsBody.type=CCPhysicsBodyTypeStatic;
    //    [_physicsNode addChild:_student0];
    
    
    motionManager= [[CMMotionManager alloc]init];
    motionManager.deviceMotionUpdateInterval=1.0/60.0;
    [motionManager startDeviceMotionUpdates];
    
    widthBoundary = _road1.contentSize.width;
    heightBoundary = _road1.contentSize.height;
    roadVelocity = 5;
    baseRoadVelocity = roadVelocity;
    //set the max velocity of road to 10
    capRoadVelocity = roadVelocity + 5;
    offsetVelocityOfCars = roadVelocity;
    
    
    //set the capacity of the bus
    CapacityOfBus *capacity = [CapacityOfBus alloc];
    //if the capacity of the bus is nil, it will be initialized
    [capacity initializeCapacityOfBus];
    capacityOfBus = [capacity getCapacityOfBus];
}




#pragma mark update function

- (void)update:(CCTime)delta
{
    [self checkIfBusIsDead];
    
    if (roadVelocity) {
        
        // size of the window
        CGSize windowSize = [[CCDirector sharedDirector] viewSize];
        
        
        
        // done by Varsha
        
        // distance = distance + 0.01;
        nfortime++;
        totalTime++;
        count++;
        
        
        
        if(count >= 120)
        {
            //  score = score + 300;
            // totalTime = 0;
            distance = distance + 1;
            [distLabel setString:[NSString stringWithFormat:@"Distance: %d",distance]];
            count = 0;
        }
        if(totalTime == 240)
        {
            //  score = score +300;
            //score=score+1;
            totalTime = 0;
        }
        [scoreLabel setString:[NSString stringWithFormat:@"Students: %ld/%ld", score, capacityOfBus]];
        
        
        
        //this is for endless road. done by frank
        
        for (CCNode *road in _roads) {
            road.position = ccp(road.position.x, road.position.y - (roadVelocity));
            if (road.position.y <= (-1 * road.contentSize.height * 3)&&roadVelocity) {
                road.position = ccp(road.position.x, road.position.y + 3 *2 * road.contentSize.height - 50);
            }
        }
        
        
        if (distance > 5 && distance < 13) {
            trafficComing = false;
            if (distance > 6 && distance < 13) {
                patternComing = true;
            }
            
        }
        if (distance > 13) {
            trafficComing = true;
            patternComing = false;
        }
        
        
        
        
        if (distance<currentLevelInfo.maxDistance && trafficComing) {
            
            
            
            //adding new students
            _curTime += delta;
            if (_curTime - _lastTime>_timeSpan) {
                _lastTime = _curTime;
                if([_students count]<_maxStudentNum&&CCRANDOM_0_1()<0.3333) {
                    //Done by Yao Frank Fan
                    //this part is to create a thread to do a countdown before the student appears
                
                    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(createStudent:) object:nil];
                    //NSLog(@"nihaoa");
                    
                    [myThread start];  // Actually create the thread
                    
  
     

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
                        
                        
                        
                    } else {
                        newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage3.png"];
                        newCar.type=3;
                        
                        newCar.scale = 0.3;
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        newCar.position = ccp(xcoord, 620);
                        
                        
                        
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
                        
                        
                        
                    } else if (number >= 50 && number < 75) {
                        newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage3.png"];
                        newCar.type=3;
                        
                        newCar.scale = 0.3;
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        newCar.position = ccp(xcoord, 620);
                        
                        
                        
                    } else {
                        newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage6.png"];
                        newCar.type=4;
                        
                        newCar.scale = 0.3;
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        newCar.position = ccp(xcoord, 620);
                        
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
                        
                        
                        
                    } else if (number >= 50 && number < 75) {
                        newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage3.png"];
                        newCar.type=3;
                        
                        newCar.scale = 0.3;
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        newCar.position = ccp(xcoord, 620);
                        
                        
                        
                    } else {
                        newCar = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage6.png"];
                        newCar.type=4;
                        
                        NSLog(@"In level 4, car 4 has been added.");
                        
                        newCar.scale = 0.3;
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        newCar.position = ccp(xcoord, 0);
                        
                    }
                }

                if (distance >= 1 & distance < 2) {
                    if (!pizza) {
                        pizza = [[ObjectOnRoad alloc] initWithType:6 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        pizza.position = ccp(xcoord, window.height + pizza.contentSize.height);
                        
                        [_physicsNode addChild:pizza];
                        
                    }
                }
                
                if (pizza) {
                    pizza.position = ccp(pizza.position.x, pizza.position.y - roadVelocity);
                }

                if (distance >= 3 & distance < 4) {
                    if (!gas) {
                        gas = [[ObjectOnRoad alloc] initWithType:7 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        gas.position = ccp(xcoord, window.height + gas.contentSize.height);
                        [_physicsNode addChild:gas];

                    }
                }
                if (gas) {
                    gas.position = ccp(gas.position.x, gas.position.y - roadVelocity);
                }
                
                if (distance >= 5 & distance < 6) {
                    if (!roadBarrier) {
                        roadBarrier = [[ObjectOnRoad alloc] initWithType:3 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        roadBarrier.position = ccp(xcoord, window.height + roadBarrier.contentSize.height);
                        [_physicsNode addChild:roadBarrier];
                        
                    }
                }
                if (roadBarrier) {
                    roadBarrier.position = ccp(roadBarrier.position.x, roadBarrier.position.y - roadVelocity);
                }
                
                if (distance >= 5 & distance < 6) {
                    if (!timber) {
                        timber = [[ObjectOnRoad alloc] initWithType:8 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        timber.position = ccp(xcoord, window.height + timber.contentSize.height);
                        [_physicsNode addChild:timber];
                        
                    }
                }
                if (timber) {
                    timber.position = ccp(timber.position.x, timber.position.y - roadVelocity);
                }
                
                if (distance >= 5 & distance < 6) {
                    if (!horizontalBus) {
                        horizontalBus = [[ObjectOnRoad alloc] initWithType:2 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        horizontalBus.position = ccp(xcoord, window.height + horizontalBus.contentSize.height);
                        [_physicsNode addChild:horizontalBus];
                        
                    }
                }
                if (horizontalBus) {
                    horizontalBus.position = ccp(horizontalBus.position.x, horizontalBus.position.y - roadVelocity);
                }
                
                if (distance >= 5 & distance < 6) {
                    if (!grenade) {
                        grenade = [[ObjectOnRoad alloc] initWithType:9 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        grenade.position = ccp(xcoord, window.height + grenade.contentSize.height);
                        [_physicsNode addChild:grenade];
                        
                    }
                }
                if (grenade) {
                    grenade.position = ccp(grenade.position.x, grenade.position.y - roadVelocity);
                }
                
                if (distance >= 5 & distance < 6) {
                    if (!powerUp) {
                        powerUp = [[ObjectOnRoad alloc] initWithType:10 withCollisionType:@"objectOnRoad" andCollisionGroup:@"notColliding"];
                        num = foo4random();
                        xcoord = minimum + (num % div);
                        powerUp.position = ccp(xcoord, window.height + powerUp.contentSize.height);
                        [_physicsNode addChild:powerUp];
                        
                    }
                }
                if (powerUp) {
                    powerUp.position = ccp(powerUp.position.x, powerUp.position.y - roadVelocity);
                }
                
                if (distance % 5 == 4) {
                    CrazyCarsTaxis *car1 = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage3.png"];
                    CrazyCarsTaxis *car2 = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage3.png"];
                    CrazyCarsTaxis *car3 = [[CrazyCarsTaxis alloc] initWithImageNamed:@"carimage3.png"];
                    car1.type = 3;
                    car2.type = 3;
                    car3.type = 3;
                    car1.scale = 0.3;
                    car2.scale = 0.3;
                    
                    car3.scale = 0.3;
                    num = foo4random();
                    xcoord = minimum + (num % div);
                    car1.position = ccp(xcoord, window.height + car1.contentSize.height);
                    car2.position = ccp(xcoord + 40, window.height + car1.contentSize.height);
                    car3.position = ccp(xcoord + 40*2, window.height + car1.contentSize.height);
                    
                    if (car1) {
                        car1.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,car1.contentSize.width, car1.contentSize.height) cornerRadius:0];
                        car1.physicsBody.density=0.1;
                        car1.physicsBody.collisionGroup = @"notColliding";
                        car1.physicsBody.collisionType=@"level";
                        [_physicsNode addChild:car1];
                        [_cars addObject:car1];
                        
                    }
                    if (car2) {
                        car2.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,car2.contentSize.width, car2.contentSize.height) cornerRadius:0];
                        car2.physicsBody.density=0.1;
                        car2.physicsBody.collisionGroup = @"notColliding";
                        car2.physicsBody.collisionType=@"level";
                        [_physicsNode addChild:car2];
                        [_cars addObject:car2];
                        
                    }
                    if (car3) {
                        car3.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,car3.contentSize.width, car3.contentSize.height) cornerRadius:0];
                        car3.physicsBody.density=0.1;
                        car3.physicsBody.collisionGroup = @"notColliding";
                        car3.physicsBody.collisionType=@"level";
                        [_physicsNode addChild:car3];
                        [_cars addObject:car3];
                        
                    }
                    
                }
                
                
                
                if(newCar){
                    newCar.scale=0.3;
                    num=foo4random();
                    xcoord=minimum+(num%div);
                    //newCar.position=ccp(xcoord,620);
                    //newStudent.position=ccp(xcoord,500);
                    // [self addChild:newCar];
                    newCar.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,newCar.contentSize.width, newCar.contentSize.height) cornerRadius:0];
                    newCar.physicsBody.density=0.1;
                    
                    newCar.physicsBody.collisionGroup = @"notColliding";
                    
                    //  coin.physicsBody= [CCPhysicsBody bodyWithRect:CGRectMake(0, 0,coin.contentSize.width, coin.contentSize.height) cornerRadius:0];
                    //   coin.physicsBody.density=0.1;
                    
                    newCar.physicsBody.collisionType=@"level";
                    // newCar.physicsBody.collisionGroup=@"cheat";
                    
                    
                    
                    [_physicsNode addChild:newCar];
                    [_cars addObject:newCar];
                    
                    
                    
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
        
        
        
        
        
        
        
#pragma adding pattern
        
        
        /////adding pattern
        
        
        if (!(distance < currentLevelInfo.maxDistance && trafficComing)){
            if (patternComing) {
                if(!patternCars){
                    patternCars=[[NSMutableArray alloc]initWithArray:[GameLevel sendPatternForLevel:level]];
                    
                    for (CrazyCarsTaxis *temp in patternCars) {
                        [_physicsNode addChild:temp];
                        [_cars addObject:temp];
                        
                    }
                }
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
                    [_physicsNode addChild:parking];
                    [_physicsNode addChild:sensor];
                    
                    
                }
            }
            /*
             NSLog(@"tHIS IS THE HIDDEN VELOVITY physics node %f",_physicsNode.physicsBody.velocity.y) ;
             NSLog(@"tHIS IS THE HIDDEN VELOVITY parking %f",parking.physicsBody.velocity.y) ;
             NSLog(@"tHIS IS THE HIDDEN VELOVITY %f",[parking parent].physicsBody.velocity.y) ;
             */
            
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
            //                [_physicsNode addChild:college];
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
                        car1.position = ccp(car1.position.x, car1.position.y - .5 + roadVelocity - offsetVelocityOfCars);
                        
                        
                        
                        if (car1.position.y < -car1.contentSize.height) {
                            
                            [toDelete addObject:car1];
                        }
                        break;
                        break;
                        
                    case 2:
                        
                        car1.position = ccp(car1.position.x, car1.position.y - 0.5  + roadVelocity - offsetVelocityOfCars);
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
                            car1.position = ccp(car1.position.x, car1.position.y - 3  + roadVelocity - offsetVelocityOfCars);
                            
                            
                            
                            if (car1.position.y < -car1.contentSize.height) {
                                
                                [toDelete addObject:car1];
                            }
                            
                            break;
                            
                        case 4:
                            
                            car1.position = ccp(car1.position.x, car1.position.y + 2.5  - roadVelocity + offsetVelocityOfCars);
                            
                            if (car1.position.y > windowSize.height || car1.position.y < -500) {
                                // if (car1.position.y < -car1.contentSize.height) {
                                
                                [toDelete addObject:car1];
                            }
                            
                            break;
                            
                        default:
                            break;
                        }
                }
                
                
                
                
                
                
            }
            
        }
        
        
        
        [_cars removeObjectsInArray:toDelete];
        for ( CCNode *temp in toDelete) {
            [temp removeFromParent];
            
        }
        [toDelete removeAllObjects];
        
        //  NSLog(@"The number of elements are %i", [[_physicsNode children]count]);
        
        
        /////CALLS THE GYRO FUNCTION
        [self gyroConfiguration];
        
        
        if (ccpAdd(bus.position, velocity).x>leftBound &&ccpAdd(bus.position, velocity).x<rightBound) {
            bus.position= ccpAdd(bus.position, velocity);
            
        }
        
        
        if (smoke) {
            smoke.position = ccp(bus.position.x, bus.position.y + bus.contentSize.height / 2 - 10);
        }
        
       // [self busWillNotGoBeyondScreen];
        
        
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
    //NSLog(@"The x coordinate is %f",touchLocation.x);
    //NSLog(@"The y coordinate before is %f",touchLocation.y);
    
    NSLog(@"Coordinate (%f, %f)", touchLocation.x, touchLocation.y);
    
    if (touchLocation.x < window.width / 2) {
        if (roadVelocity > baseRoadVelocity) {
            roadVelocity -= 0.1;
            offsetVelocityOfCars -= 0.05;
        }
        
    } else {
        if (roadVelocity < capRoadVelocity) {
            roadVelocity += 0.1;
            offsetVelocityOfCars += 0.05;
        }
        
        
    }
    
    if (touchLocation.x>180) {
        [bus.physicsBody applyImpulse:ccp(0, 400)];
    }
    else{
        [bus.physicsBody applyImpulse:ccp(0, -400)];
        
    }
    //NSLog(@"The y coordinate is %f",touchLocation.y);
    
    
    // create a 'hero' sprite
    //CCSprite *hero = [CCSprite spriteWithImageNamed:@"hero.png"];
    //[self addChild:hero];
    // place the sprite at the touch location
    //hero.position = touchLocation;
}




#pragma mark createStudent

- (void)createStudent:(CCTime) delta {
    
    _createdFlag = true;
    CGSize windowSize = [[CCDirector sharedDirector] viewSize];
    BOOL posLeft = CCRANDOM_0_1()<=0.5?YES:NO;
    
    if (posLeft == NO) {
        countdownLabel.position = ccp(windowSize.width - 100, windowSize.height - 120);
      
        
    } else {
        countdownLabel.position = ccp(100, windowSize.height - 50);
   
    }
    

    for (int i = 3; i != 0; --i) {
        //NSLog(@"You have %d seconds left.", i);
        [countdownLabel setString:[NSString stringWithFormat:@"%d", i]];
        [NSThread sleepForTimeInterval:1.0f];
    }
    
    if (posLeft == NO) {
        [countdownLabel setString:@"Keep\nRight!"];
        
    } else {
        [countdownLabel setString:@"Keep\nLeft!"];
        
    }
    
    
    
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
    newStudent.physicsBody.collisionGroup = @"notColliding";
    
    newStudent.physicsBody.type=CCPhysicsBodyTypeStatic;
    [_physicsNode addChild:newStudent];
    
    [_students addObject:newStudent];
    //NSLog(@"student added.");
    
    
    
    [NSThread sleepForTimeInterval:1.0f];
    [countdownLabel setString:@""];
    _createdFlag = false;
}




-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair insaneBus:(CCNode*)insaneBus objectOnRoad:(ObjectOnRoad*)objectOnRoad {
    if (objectOnRoad) {
        if (objectOnRoad.type == 1) {
            
        } else if (objectOnRoad.type == 2) {
            progressTimer.percentage -= 50;
            [[OALSimpleAudio sharedInstance] playEffect:objectOnRoad.soundEffect loop:NO];

        } else if (objectOnRoad.type == 3) {
            progressTimer.percentage -= 30;
            [[OALSimpleAudio sharedInstance] playEffect:objectOnRoad.soundEffect loop:NO];

        } else if (objectOnRoad.type == 4) {
            
        } else if (objectOnRoad.type == 5) {
            
        } else if (objectOnRoad.type == 6) {
            
            if (progressTimer.percentage <= 70) {
                progressTimer.percentage += 30;
                
            } else {
                progressTimer.percentage = 100;
            }
            [[OALSimpleAudio sharedInstance] playEffect:objectOnRoad.soundEffect loop:NO];
            
        } else if (objectOnRoad.type == 7) {
            if (progressTimer.percentage <= 50) {
                progressTimer.percentage += 50;
                
            } else {
                progressTimer.percentage = 100;
            }
            [[OALSimpleAudio sharedInstance] playEffect:objectOnRoad.soundEffect loop:NO];
        } else if (objectOnRoad.type == 8) {
            progressTimer.percentage -= 20;
            [[OALSimpleAudio sharedInstance] playEffect:objectOnRoad.soundEffect loop:NO];
        } else if (objectOnRoad.type == 9) {
            [[OALSimpleAudio sharedInstance] playEffect:objectOnRoad.soundEffect loop:NO];
            for (CrazyCarsTaxis *car in _cars) {
                if (car.position.y < window.height && car.position.y > 0) {
                    [car removeFromParent];
                }
            }

        } else if (objectOnRoad.type == 10) {
            NSInteger increasing = 5;
            capacityOfBus += increasing;
            CapacityOfBus *capacity = [CapacityOfBus alloc];
            [capacity increaseCapacityOfBusBy:increasing];
            
            if (progressTimer.percentage <= 70) {
                progressTimer.percentage += 30;
            } else {
                progressTimer.percentage = 100;
            }
            [[OALSimpleAudio sharedInstance] playEffect:objectOnRoad.soundEffect loop:NO];

        }
        [objectOnRoad removeFromParent];
        return true;
    } else {
        return false;
    }
}



-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair insaneBus:(CCNode*)insaneBus student:(CCNode*)student {
    
    CapacityOfBus *capacity = [CapacityOfBus alloc];
    if (score < [capacity getCapacityOfBus]) {
        NSLog(@"Collision Student");
        [self applyEnergizeEffect:student];
        
        [student removeFromParent];
        score = score + 1;
        [[OALSimpleAudio sharedInstance] playEffect:@"cha-ching.wav" loop:NO];
        return TRUE;
        
    } else {
        return FALSE;
    }
    
}


#pragma mark End of level
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair insaneBus:(CCNode*)insaneBus Parking:(CCNode*)Parking {
    
    NSLog(@"Yay! The level is completed");
    roadVelocity=0;
    parking.physicsBody.velocity= CGPointMake(0, 0);
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dataForScoreScreen = [[NSMutableDictionary alloc]init];
    [dataForScoreScreen setObject:[NSString stringWithFormat:@"%i",distance] forKey:@"distance"];
    [dataForScoreScreen setObject:[NSString stringWithFormat:@"%li",score] forKey:@"students"];
    
    
#pragma mark Change this to actual trophy list
    ////////Change this to actual trophy list later/////
    
    
    NSString *nameOfTheTrophy=@"trophy1";
    NSMutableArray *trophylist= [[NSMutableArray alloc]init];
    [trophylist addObject:nameOfTheTrophy];
    
    for (int i=0; i<[trophylist count]; i++) {
        
        [dataForScoreScreen setObject:trophylist[i] forKey:[NSString stringWithFormat:@"trophy%i",i]];
        
    }
    
    [dataForScoreScreen setObject:[NSString stringWithFormat:@"%i",[trophylist count]] forKey:@"numberOfTrophies"];
    
    [defaults setObject:dataForScoreScreen forKey:@"dataForScoreScreen"];
    
    
    CCScene *gameplayscene = [CCBReader loadAsScene:@"EndlevelCCB"];
    [[CCDirector sharedDirector] replaceScene:gameplayscene];
    
    
    
    //oh man, collision...
    // CCScene *mainscene = [CCBReader loadAsScene:@"GameFinScene"];
    // [[CCDirector sharedDirector] replaceScene:mainscene];
    
    return TRUE;
}

- (NSString *)docsDir {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
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
        //  int l = 1;
         
         NSString *listPath;
         NSMutableDictionary *plistData;
         // long x[3];
         listPath = [[self docsDir]stringByAppendingPathComponent:@"GameData.plist"];
         if(![[NSFileManager defaultManager]fileExistsAtPath:listPath]) {
         [[NSFileManager defaultManager]copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"GameData" ofType:@"plist"] toPath:listPath error:nil];
         }
         plistData = [NSMutableDictionary dictionaryWithContentsOfFile:listPath];
       /*  if(l == 1)
         {
         score = 40;
         
         long s1 = [[plistData objectForKey:@"score1"] integerValue];
         long s2 = [[plistData objectForKey:@"score2"] integerValue];
         long s3 = [[plistData objectForKey:@"score3"] integerValue];
         NSLog(@"s1:%ld,s2:%ld,s3:%ld",s1,s2,s3);
         if(score>s1 && score>s2 && score>s3)
         {
         
         [plistData setValue:[NSString stringWithFormat:@"%li",score] forKey:@"score1"];
         [plistData setValue:[NSString stringWithFormat:@"%li",s1] forKey:@"score2"];
         [plistData setValue:[NSString stringWithFormat:@"%li",s2] forKey:@"score3"];
         [plistData writeToFile:listPath atomically:YES];
         long hh= [[plistData objectForKey:@"score1"] integerValue];
         
         //  NSLog(@"h1:%ld",h1);
         [scorelabel1 setString:[NSString stringWithFormat:@"HighScore1: %ld", hh]];
         
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
         
         else if(l == 2)
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
         
         else if(l == 3)
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
         
         else if(l == 4)
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
       
         
         } */
           long s1 = [[plistData objectForKey:@"score1"] integerValue];
         long s2 = [[plistData objectForKey:@"score2"] integerValue];
         long s3 = [[plistData objectForKey:@"score3"] integerValue];
        
        long s4 = [[plistData objectForKey:@"score4"] integerValue];
        long s5 = [[plistData objectForKey:@"score5"] integerValue];
        long s6 = [[plistData objectForKey:@"score6"] integerValue];
        long s7 = [[plistData objectForKey:@"score7"] integerValue];
        long s8 = [[plistData objectForKey:@"score8"] integerValue];
        long s9 = [[plistData objectForKey:@"score9"] integerValue];
        long s10 = [[plistData objectForKey:@"score10"] integerValue];
        long s11 = [[plistData objectForKey:@"score11"] integerValue];
        long s12 = [[plistData objectForKey:@"score12"] integerValue];
         NSLog(@"s1:%ld,s2:%ld,s3:%ld,s4:%ld,s5:%ld,s6:%ld,s7:%ld,s8:%ld,s9:%ld,s10:%ld,s11:%ld,s12:%ld",s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12);
        
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

#pragma mark Gyro Configuration

-(void)gyroConfiguration{
    
    CMDeviceMotion *currentDeviceMotion= motionManager.deviceMotion;
    CMAttitude *currentAttitude= currentDeviceMotion.attitude;
    // [label setString: [NSString stringWithFormat:@"%.02f", currentAttitude.roll]];
    //                     label.rotation= CC_RADIANS_TO_DEGREES(currentAttitude.roll);
    //    NSLog(@" tHE ROLL IS %f",currentAttitude.roll);
    
    
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
    
    
}

- (BOOL)checkIfBusIsDead {
    if (progressTimer.percentage <= 0) {
        [bus removeFromParent];
        [self gameEnds];
        return true;
    } else {
        return false;
    }
}

- (void)backbutton4 {
    CCScene *mainscene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainscene];
}


@end
