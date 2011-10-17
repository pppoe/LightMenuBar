//
//  LightMenuBar.h
//  LightMenuBar
//
//  Created by Haoxiang on 6/9/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LightMenuBarStyleItem,  /**< After tapping on an item, the item is highlighted */
    LightMenuBarStyleButton /**< When tapping on an item, the item is highlighted, after tapping, the item state changed to normal */
} LightMenuBarStyle;

@class LightMenuBarView;
@protocol LightMenuBarDelegate;

@interface LightMenuBar : UIView {
    LightMenuBarView *_menuBarView;
    UIScrollView *_scrollView;
    LightMenuBarStyle _style;
}

@property (nonatomic, assign) NSUInteger selectedItemIndex;
@property (nonatomic, assign) id<LightMenuBarDelegate> delegate;
@property (nonatomic, readonly) LightMenuBarView *menuBarView;
@property (nonatomic, readonly) LightMenuBarStyle barStyle;

@property (nonatomic, assign) BOOL bounces; // defaults to NO


- (id)initWithFrame:(CGRect)frame andStyle:(LightMenuBarStyle)barStyle;

- (void)setSelectedItemIndex:(NSUInteger)itemIndex animated:(BOOL)animated notifyDelegate:(BOOL)notifyDelegate;

- (void)handleAutoScrolling:(BOOL)animated;

@end
