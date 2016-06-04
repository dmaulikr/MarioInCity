//
//  Block.m
//  MarioinCity
//
//  Created by Xmob - Longdt on 5/21/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import "Block.h"

@implementation Block
- (instancetype) initWithName:(NSString *)name inScene:(Scene *)scene {
    self = [super initWithName:name
                       ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block.png"]]
                       inScene:scene];
    return self;
}
@end
