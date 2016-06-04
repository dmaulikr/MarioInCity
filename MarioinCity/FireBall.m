//
//  FireBall.m
//  MarioinCity
//
//  Created by Xmob - Longdt on 5/26/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import "FireBall.h"

@implementation FireBall
- (instancetype) initWithName:(NSString *)name inScene:(Scene *)scene{
    self = [super initWithName:name
                       ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fireball.png"]]
                       inScene:scene];
    return self;
}

-(void) startFly:(CGFloat)speed{
    if (!self.isFlying){
        self.isFlying = true;
        self.speed = speed;
    }
}

-(void) fly{
    if (!self.isFlying){
        return;
    }
    CGFloat x = self.view.center.x + self.speed;
    if (x > self.scene.size.width + self.view.bounds.size.width*0.5){
        [self.scene removeSprite:self];
        return;
    }
    self.view.center = CGPointMake(x, self.view.center.y);
}

-(void) animate{
    [self fly];
}
@end
