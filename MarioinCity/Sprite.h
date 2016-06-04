//
//  Sprite.h
//  MarioinCity
//
//  Created by Xmob - Longdt on 5/19/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Scene.h"
@class Scene;
@interface Sprite : NSObject
@property (nonatomic,strong) UIView *view;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, weak) Scene *scene;

- (instancetype) initWithName: (NSString*) name
                      ownView: (UIView*) view
                      inScene: (Scene*) scene;

- (instancetype) initWithName: (NSString*) name
                      inScene:(Scene *) scene;

- (void) animate;
@end
