//
//  Sprite.m
//  MarioinCity
//
//  Created by Xmob - Longdt on 5/19/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite
- (instancetype) initWithName: (NSString*) name
                      ownView: (UIView*) view
                      inScene: (Scene*) scene{
    if (self = [super init]){
        self.name = name;
        self.view = view;
        self.scene = scene;
    }
    return self;
}


- (instancetype) initWithName: (NSString*) name
                      inScene: (Scene*) scene{
    if (self = [super init]){
        self.name = name;
        self.scene = scene;
    }
    return self;
}



- (void) animate{
    
}
@end
