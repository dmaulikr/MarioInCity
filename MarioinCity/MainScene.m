//
//  MainScene.m
//  MarioinCity
//
//  Created by Xmob - Longdt on 5/21/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import "MainScene.h"
#import "Sprite.h"
#import "City.h"
#import "Cloud.h"
#import "Block.h"
#import "SuperMario.h"
#define city_background_width 1498

@implementation MainScene
{
    SuperMario *mario;
    City * city1, *city2;
    CGSize citySize;
    NSTimer * timer;
    Cloud *cloud1, *cloud2, *cloud3;
    NSMutableArray *blocks;
    
    CGFloat marioRunSpeed;
    BOOL alreadyAddBlocks;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    self.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - statusNavigationBarHeight);
    blocks = [[NSMutableArray alloc] initWithCapacity:12];
    [self addCity];
    [self addClouds];
    [self addSuperMario];
    marioRunSpeed = 20.0;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self selector:@selector(gameloop)
                                           userInfo:nil repeats:true];
}

-(void) addSuperMario{
    mario = [[SuperMario alloc] initWithName:@"mario"
                                     inScene:self];
    mario.y0 = self.size.height - mario.view.bounds.size.height * 0.5 -10;
    mario.view.center = CGPointMake(self.size.width * 0.5, mario.y0);
    [self addSprite:mario];
    
}

-(void) addCity{
    citySize = CGSizeMake(city_background_width, 400);
    UIImage* cityBackground = [UIImage imageNamed:@"city"];
    city1 = [[City alloc] initWithName:@"city1"
                               ownView:[[UIImageView alloc]initWithImage:cityBackground]
                               inScene:self];
    city1.view.frame = CGRectMake(0, self.size.height - citySize.height, citySize.width, citySize.height);
    
    city2 = [[City alloc] initWithName:@"city2"
                               ownView:[[UIImageView alloc]initWithImage:cityBackground]
                               inScene:self];
    city2.view.frame = CGRectMake(citySize.width, self.size.height - citySize.height, citySize.width, citySize.height);
    city1.alreadyHaveBlock = false;
    city2.alreadyHaveBlock = false;
    [self.view addSubview:city1.view];
    [self.view addSubview:city2.view];
}

- (void) addBlocksToCity: (City*) city {
    //Only add blocks when city background is off screen
    if (!city.alreadyHaveBlock && !CGRectIntersectsRect(self.view.bounds, city.view.frame)) {
        CGFloat averageStep = 250;
        CGFloat previousBlockXCoordinate = 0.0;
        int index = 0;
        while (previousBlockXCoordinate < city_background_width - 300) {
            Block *block = [[Block alloc] initWithName:[NSString stringWithFormat:@"block%d", index]
                                               inScene:self];
            index++;
            CGFloat x = previousBlockXCoordinate + averageStep + arc4random_uniform(50);
            
            block.view.center = CGPointMake(x, city1.view.bounds.size.height - block.view.bounds.size.height * 0.5 - 5);
            [city.view addSubview:block.view];
            [blocks addObject:block.view];
            previousBlockXCoordinate = x;
        }
        city.alreadyHaveBlock = true;
    }
}

- (void) addClouds {
    cloud1 = [[Cloud alloc] initWithName:@"cloud1"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud1.png"]]
                                 inScene:self];
    cloud1.speed = - 10.0;
    
    cloud2 = [[Cloud alloc] initWithName:@"cloud2"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud2.png"]]
                                 inScene:self];
    cloud2.speed = - 5.0;
    
    cloud3 = [[Cloud alloc] initWithName:@"cloud3"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud3.png"]]
                                 inScene:self];
    cloud3.speed = - 8.0;
    
    cloud1.view.frame = CGRectMake(20, 15, 100, 100);
    cloud2.view.frame = CGRectMake(150, 3, 80, 80);
    cloud3.view.frame = CGRectMake(260, 7, 90, 90);
    
    [self addSprite:cloud1];
    [self addSprite:cloud2];
    [self addSprite:cloud3];
    
}



-(void)gameloop{
    [self moveCityBackAtSpeed:marioRunSpeed];
    
    for (Sprite* sprite in self.sprites.allValues) {
        [sprite animate];
    }
    [self checkCollisionBetweenMarioAndBlocks];
}

-(void) moveCityBackAtSpeed:(CGFloat) speed{
    city1.view.center = CGPointMake(city1.view.center.x - speed, city1.view.center.y);
    city2.view.center = CGPointMake(city2.view.center.x - speed, city1.view.center.y);
    if (city1.view.frame.origin.x + citySize.width < 0.0){
        city1.view.frame = CGRectMake(city2.view.frame.origin.x + citySize.width,
                                      city1.view.frame.origin.y,
                                      citySize.width,
                                      citySize.height);
    }
    if (city2.view.frame.origin.x + citySize.width < 0.0) {
        city2.view.frame = CGRectMake(city1.view.frame.origin.x + citySize.width,
                                      city2.view.frame.origin.y,
                                      citySize.width,
                                      citySize.height);
    }
    [self addBlocksToCity:city1];
    [self addBlocksToCity:city2];
}

- (BOOL) checkCollisionBetweenMarioAndBlocks {
    if (!mario.alive) return false;
    for (int i = 0; i < blocks.count; i++) {
        UIView* block  = (UIView*)blocks[i];
        CGRect blockRect = [block.superview convertRect: block.frame
                                                 toView: self.view];
        
        if (CGRectIntersectsRect(blockRect, CGRectInset(mario.view.frame, 10, 0))){
            NSLog(@"blockRrect %d: %f", i+1, blockRect.origin.x);
            [mario getKilled];
            marioRunSpeed = 0.0;
            [self gameOver];
            return true;
        }
        
    }
    
    return false;
}

- (void) gameOver {
    UIImageView* dialog = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gameover.png"]];
    
    dialog.center = CGPointMake(self.size.width * 0.5, -dialog.bounds.size.height * 0.5);
    [self.view addSubview:dialog];
    
    [UIView animateWithDuration:2 animations:^{
        dialog.center = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [timer invalidate];
    timer = nil;
}

@end
