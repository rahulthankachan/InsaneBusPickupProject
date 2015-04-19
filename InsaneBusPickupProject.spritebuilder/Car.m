

#import "Car.h"


@implementation Car

#define _100_PERCENT 100

@synthesize sprite,currentHealth,maxHealth,speed,drainAmount;

-(id) initWithSpriteAndLayer:(NSString *) img
{
    self = [super init]; 
    
    self.sprite = [CCSprite spriteWithImageNamed:img];
    //self.layer = l;
    self.maxHealth = 100; 
    self.currentHealth = self.maxHealth; // start with max health 
    self.drainAmount = 0;
    
    // attach the health bar 
    //healthBar = [[HealthBar alloc] initWithProgressTimerSprite:@"green_health_bar.png"];
    CCSprite *sprite = [[CCSprite alloc] initWithImageNamed:@"green_health_bar.png"];
    healthBar = [[HealthBar alloc] initWithProgressTimerSprite:sprite];
    
    healthBar.progressTimer.position = ccp(self.sprite.contentSize.width/2,-5);
    [self.sprite addChild:healthBar.progressTimer z:1];
    
    return self; 
}

-(void) drainFuel
{
    self.currentHealth -= drainAmount; 
    
    if(self.currentHealth < 25) 
    {
        [healthBar.progressTimer setSprite:[CCSprite spriteWithImageNamed:@"red_health_bar.png"]];
    }
    else 
    {
        [healthBar.progressTimer setSprite:[CCSprite spriteWithImageNamed:@"green_health_bar.png"]];
    }
    
    [healthBar.progressTimer setPercentage:_100_PERCENT * (self.currentHealth/self.maxHealth)];
}

-(void) hit
{

    self.currentHealth -= 25; 
    
    
    if(self.currentHealth <= 25) 
    {
        [healthBar.progressTimer setSprite:[CCSprite spriteWithImageNamed:@"red_health_bar.png"]];
        
        [self enableSmoke];
        
    }
    
    [healthBar.progressTimer setPercentage:_100_PERCENT * (self.currentHealth/self.maxHealth)];
}

-(void) destroy 
{
    CCParticleFire *fire = [[CCParticleFire alloc] init];
    [fire setAutoRemoveOnFinish:YES];
    [fire setTotalParticles:70];
    fire.position = self.sprite.position; 
    //[self.layer addChild:fire z:1];
    
    }

-(void) enableSmoke 
{
    CCParticleSmoke *smoke = [[CCParticleSmoke alloc] init];
    [smoke setAutoRemoveOnFinish:YES]; 
    [smoke setScaleX:0.8];
    [smoke setStartSize:10];
    [smoke setEndSize:10];
    [smoke setGravity:ccp(0,-90)];
    [smoke setTotalParticles:50];
    smoke.position = ccp(self.sprite.contentSize.width/2,0);
    [self.sprite addChild:smoke];
}

-(void) applyEnergizeEffect 
{
    CCParticleExplosion *meteor = [[CCParticleExplosion alloc] init];
    [meteor setAutoRemoveOnFinish:YES];
    [meteor setTotalParticles:200];
    
    [meteor setStartSize:2];
    [meteor setEndSize:2];
    
    [meteor setDuration:3];
    meteor.position = self.sprite.position;
    
    //[self.layer addChild:meteor];
    
}

-(void) energize 
{
    if(self.currentHealth < _100_PERCENT) 
    {
        [self applyEnergizeEffect];
        
        self.currentHealth += 25; 
        
        if(self.currentHealth > 25) 
        {
            [healthBar.progressTimer setSprite:[CCSprite spriteWithImageNamed:@"green_health_bar.png"]];
        }
        
        [healthBar.progressTimer setPercentage:_100_PERCENT * (self.currentHealth/self.maxHealth)];
    }
}




@end
