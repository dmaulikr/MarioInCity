//
//  FireBall.h
//  MarioinCity
//
//  Created by Xmob - Longdt on 5/26/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import "Sprite.h"

@interface FireBall : Sprite
@property (nonatomic, assign) BOOL isFlying;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, weak) Sprite* fromSprite;

-(void) startFly: (CGFloat) speed;
@end
