//
//  Scene.h
//  MarioinCity
//
//  Created by Xmob - Longdt on 5/19/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sprite.h"

@class Sprite; //Forward class declaration
@interface Scene : UIViewController
@property (nonatomic, strong) NSMutableDictionary *sprites;
@property (nonatomic, assign) CGSize size; //assign dung trong cac bien co kieu primitive datatype hoac struct 

-(void) addSprite: (Sprite*) sprite;
- (void) removeSprite: (Sprite*) sprite;
- (void) removeSpriteByName: (NSString*) spriteName;
@end
