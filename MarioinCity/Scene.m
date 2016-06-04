//
//  Scene.m
//  MarioinCity
//
//  Created by Xmob - Longdt on 5/19/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import "Scene.h"

@implementation Scene
-(void)loadView{
    [super loadView];
    self.sprites = [NSMutableDictionary new];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) addSprite:(Sprite *)sprite{
    [self.sprites setObject:sprite
                     forKey:sprite.name];
    [self.view addSubview:sprite.view];
}

-(void) removeSprite:(Sprite *)sprite{
    [self.sprites removeObjectForKey:sprite.name];
    [sprite.view removeFromSuperview];
}

-(void) removeSpriteByName:(NSString *)spriteName{
    UIView* removeView = self.sprites[spriteName];
    [removeView removeFromSuperview];
    [self.sprites removeObjectForKey:spriteName];
}

@end
