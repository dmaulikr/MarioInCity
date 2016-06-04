//
//  SuperMario.m
//  MarioinCity
//
//  Created by Xmob - Longdt on 5/26/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SuperMario.h"
#import "FireBall.h"

@implementation SuperMario
{
    BOOL isRunning, isJumping;
    CGFloat jumpVelocity, fallAcceleration;
    int fireBallCount;
    AVAudioPlayer* audioPlayer;
}

- (instancetype) initWithName: (NSString*) name
                      inScene: (Scene*) scene{
    
    self = [super initWithName: name
                       inScene: scene];
    
    UIImageView *marioView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 102)];
    marioView.userInteractionEnabled = true; //tuong tac nguoi dung
    marioView.multipleTouchEnabled = true; //tuong tac da cham
    marioView.animationImages = @[[UIImage imageNamed:@"1.png"],
                                  [UIImage imageNamed:@"2.png"],
                                  [UIImage imageNamed:@"3.png"],
                                  [UIImage imageNamed:@"4.png"],
                                  [UIImage imageNamed:@"5.png"],
                                  [UIImage imageNamed:@"6.png"],
                                  [UIImage imageNamed:@"7.png"],
                                  [UIImage imageNamed:@"8.png"],];
    marioView.animationDuration = 1.0;
    [marioView startAnimating];
    self.view = marioView;
    fireBallCount = 0;
    [self applyGestureRecognizer];
    self.alive = true;
    return self;
}

- (void) applyGestureRecognizer{
    [self.scene.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(startJump)]];
    
    UISwipeGestureRecognizer* swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(startfire)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.scene.view addGestureRecognizer:swipeRight];
}

- (void) startJump{
    if (!isJumping){
        isJumping = true;
        jumpVelocity = -40.0;
        fallAcceleration = 10.0;
    }
    
    }

- (void) startfire{
    fireBallCount ++;
    FireBall* fireBall = [[FireBall alloc] initWithName:[NSString stringWithFormat:@"fireball%d", fireBallCount]
                                                inScene:self.scene];
    fireBall.view.center = CGPointMake(self.view.center.x + 5, self.view.center.y);
    fireBall.fromSprite = self;
    [self.scene addSprite:fireBall];
    [fireBall startFly:20];
}

-(void) jump{
    if (!isJumping){
        return;
    }
    CGFloat y = self.view.center.y;
    y += jumpVelocity;
    jumpVelocity += fallAcceleration;
    if (y > self.y0){
        y = self.y0;
        isJumping = false;
    }
    self.view.center = CGPointMake(self.view.center.x, y);
}

-(void) animate{
    if (!self.alive){
        return;
    }
    [self jump];
}

- (void) getKilled {
    UIImageView* view = (UIImageView*) self.view;
    [view stopAnimating];
    view.image = [UIImage imageNamed:@"marioKilled.png"];
    self.alive = false;
    [self playSong:@"08-you-re-dead"];
}

- (void) playSong: (NSString*) song {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:song
                                                         ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                         error:&error];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}

@end
