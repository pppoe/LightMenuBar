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

typedef enum {
    LightMenuBarBackActionPop = 0,
    LightMenuBarBackActionDismiss,
    LightMenuBarBackActionFade
} LightMenuBarBackAction;


@class LightMenuBarView;
@protocol LightMenuBarDelegate;

@interface LightMenuBar : UIView {
    LightMenuBarView *_menuBarView;
    UIScrollView *_scrollView;
    LightMenuBarStyle _style;

    /**< Navigation Between ViewControllers */
    UIViewController *_containerViewController;
    
    //< Each Time you use one of the navigation actions to show a viewController, there is a new back action prepared.
    UINavigationController *_navController;
    NSMutableArray *_viewControllers;
    NSMutableArray *_backActions; 
}

@property (nonatomic, assign) NSUInteger selectedItemIndex;
@property (nonatomic, assign) id<LightMenuBarDelegate> delegate;
@property (nonatomic, readonly) LightMenuBarView *menuBarView;
@property (nonatomic, assign) LightMenuBarStyle barStyle;
@property (nonatomic, assign) UIViewController *containerViewController;

- (id)initWithFrame:(CGRect)frame andStyle:(LightMenuBarStyle)barStyle;

//< Navigation Actions
- (void)pushViewController:(UIViewController *)viewController;
- (void)fadeInModalViewController:(UIViewController *)viewController;
- (void)presentModalViewController:(UIViewController *)viewController;
- (void)replaceModalViewController:(UIViewController *)viewController;

- (void)backViewController;
- (void)backViewControllerWithAction:(LightMenuBarBackAction)backAction;

- (void)setupNavigationStack;

@end
