//
//  SuperMario.h
//  MarioinCity
//
//  Created by Xmob - Longdt on 5/26/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import "Sprite.h"

@interface SuperMario : Sprite
@property (nonatomic, assign) BOOL alive;
@property (nonatomic,assign) CGFloat y0; //initial y coordinate
- (void) getKilled;
@end
