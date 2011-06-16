//
//  LightMenuBar.m
//  LightMenuBar
//
//  Created by Haoxiang on 6/9/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "LightMenuBar.h"
#import "LightMenuBarView.h"

#import <QuartzCore/QuartzCore.h>

@implementation LightMenuBar
@synthesize containerViewController = _containerViewController;
@synthesize menuBarView = _menuBarView;
@synthesize barStyle = _style;
@dynamic delegate;
@dynamic selectedItemIndex;

#pragma mark property
- (NSUInteger)selectedItemIndex {
    return _menuBarView.selectedItemIndex;
}

- (void)setSelectedItemIndex:(NSUInteger)itemIndex {
    _menuBarView.selectedItemIndex = itemIndex;
}

- (id<LightMenuBarDelegate>)delegate {
    return _menuBarView.delegate;
}

- (void)setDelegate:(id <LightMenuBarDelegate>)theDelegate {
    _menuBarView.delegate = theDelegate;
}

- (void)setup {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _menuBarView = [[LightMenuBarView alloc] initWithFrame:self.bounds];
    _menuBarView.menuBar = self;
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.contentSize = self.frame.size;
    
    [self addSubview:_scrollView];
    [_scrollView addSubview:_menuBarView];    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame andStyle:LightMenuBarStyleItem];
}

- (id)initWithFrame:(CGRect)frame andStyle:(LightMenuBarStyle)barStyle {
    if (self = [super initWithFrame:frame])
    {
        _style = barStyle;
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [_navController release];
    [_viewControllers release];
    [_backActions release];
    [super dealloc];
}

- (void)layoutSubviews {
    CGFloat barLength = [self.menuBarView barLength];
    _menuBarView.frame = CGRectMake(_menuBarView.frame.origin.x, _menuBarView.frame.origin.y, 
                                    barLength, _menuBarView.frame.size.height);
    _scrollView.contentSize = CGSizeMake(barLength, _scrollView.frame.size.height);
    [_menuBarView setNeedsDisplay];
    
}

- (void)setupNavigationStack {
    if (!_navController)
    {
        
        _navController = [[UINavigationController alloc] init];
        if (self.containerViewController)
        {
            _navController.view.frame = self.containerViewController.view.frame;
        }
        _navController.view.backgroundColor = [UIColor clearColor];
        
        _viewControllers = [[NSMutableArray alloc] initWithCapacity:0];
        _backActions = [[NSMutableArray alloc] initWithCapacity:0];
    }
}

//< Navigation Actions
- (void)pushViewController:(UIViewController *)viewController {
    [self setupNavigationStack];
    
    CGRect containerFrame = self.containerViewController.view.bounds;
    CGRect beginFrame = CGRectMake(containerFrame.origin.x + containerFrame.size.width, containerFrame.origin.y, 
                                   containerFrame.size.width, containerFrame.size.height);
    
    viewController.view.alpha = 0.0f;
    viewController.view.frame = beginFrame;
    [UIView beginAnimations:@"push" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone
                           forView:self.containerViewController.view
                             cache:YES];
    [UIView setAnimationDuration:0.3f];
    viewController.view.frame = self.containerViewController.view.bounds;
    viewController.view.alpha = 1.0f;
    [UIView commitAnimations];
    
    [self.containerViewController.view addSubview:viewController.view];
    
    [_viewControllers addObject:viewController];
    [_backActions addObject:[NSNumber numberWithInt:LightMenuBarBackActionPop]];
}

- (void)fadeInModalViewController:(UIViewController *)viewController {
    [self setupNavigationStack];
    
    viewController.view.alpha = 0.0f;
    viewController.view.frame = self.containerViewController.view.bounds;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone
                           forView:viewController.view
                             cache:YES];
    [UIView setAnimationDuration:0.3f];
    viewController.view.alpha = 1.0f;
    [UIView commitAnimations];
    
    UIViewController *topViewController = self.containerViewController;
    if ([_viewControllers count] > 0)
    {
        topViewController = [_viewControllers lastObject];
    }
    [topViewController.view addSubview:viewController.view];
    
    [_viewControllers addObject:viewController];
    [_backActions addObject:[NSNumber numberWithInt:LightMenuBarBackActionFade]];
}

- (void)presentModalViewController:(UIViewController *)viewController {
    [self setupNavigationStack];
        
    CGRect containerFrame = self.containerViewController.view.bounds;
    CGRect beginFrame = CGRectMake(containerFrame.origin.x, containerFrame.origin.y + containerFrame.size.height, 
                                   containerFrame.size.width, 0);
    
    viewController.view.alpha = 0.0f;
    viewController.view.frame = beginFrame;
    [UIView beginAnimations:@"present" context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone
                           forView:viewController.view
                             cache:YES];
    [UIView setAnimationDuration:0.3f];
    viewController.view.frame = self.containerViewController.view.bounds;
    viewController.view.alpha = 1.0f;
    [UIView commitAnimations];
    
    UIViewController *topViewController = self.containerViewController;
    if ([_viewControllers count] > 0)
    {
        topViewController = [_viewControllers lastObject];
    }
    [topViewController.view addSubview:viewController.view];
    
    [_viewControllers addObject:viewController];
    [_backActions addObject:[NSNumber numberWithInt:LightMenuBarBackActionDismiss]];
}

- (void)replaceModalViewController:(UIViewController *)viewController {
    [self setupNavigationStack];

    [self backViewControllerWithAction:LightMenuBarBackActionFade];
    [self fadeInModalViewController:viewController];    
}

- (void)backViewControllerWithAction:(LightMenuBarBackAction)backAction {

    if ([_viewControllers count] == 0)
    {
        return;
    }
    
    UIViewController *viewController = [_viewControllers lastObject];
    
    switch (backAction) {
        case LightMenuBarBackActionPop:
        {
            CGRect containerFrame = self.containerViewController.view.bounds;
            CGRect endFrame = CGRectMake(containerFrame.origin.x + containerFrame.size.width, containerFrame.origin.y, 
                                         containerFrame.size.width, containerFrame.size.height);
            
            viewController.view.alpha = 1.0f;
            [UIView beginAnimations:@"pop" context:nil];
            [UIView setAnimationTransition:UIViewAnimationTransitionNone
                                   forView:viewController.view
                                     cache:YES];
            [UIView setAnimationDuration:0.3f];
            [UIView setAnimationDelegate:viewController.view];
            [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
            
            viewController.view.frame = endFrame;
            viewController.view.alpha = 0.0f;
            
            [UIView commitAnimations];                
        }
            break;
        case LightMenuBarBackActionDismiss:
        {
            CGRect containerFrame = self.containerViewController.view.bounds;
            CGRect endFrame = CGRectMake(containerFrame.origin.x, containerFrame.origin.y + containerFrame.size.height, 
                                         containerFrame.size.width, 0);
            
            viewController.view.alpha = 1.0f;
            [UIView beginAnimations:@"dismiss" context:nil];
            [UIView setAnimationTransition:UIViewAnimationTransitionNone
                                   forView:viewController.view
                                     cache:YES];
            [UIView setAnimationDelegate:viewController.view];
            [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
            [UIView setAnimationDuration:0.3f];
            
            viewController.view.frame = endFrame;
            viewController.view.alpha = 0.0f;
            
            [UIView commitAnimations];                                
        }
            break;
        case LightMenuBarBackActionFade:
        {
            viewController.view.alpha = 1.0f;
            [UIView beginAnimations:@"fade" context:nil];
            [UIView setAnimationTransition:UIViewAnimationTransitionNone
                                   forView:viewController.view
                                     cache:YES];
            [UIView setAnimationDelegate:viewController.view];
            [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
            [UIView setAnimationDuration:0.3f];
            
            viewController.view.alpha = 0.0f;
            
            [UIView commitAnimations];                                
        }                
            break;
        default:
            break;
    }
    
    [_viewControllers removeLastObject];
    [_backActions removeLastObject];    
}

- (void)backViewController {
    if ([_viewControllers count] > 0)
    {
        int topAction = [[_backActions lastObject] intValue];
        [self backViewControllerWithAction:(LightMenuBarBackAction)topAction];
    }
}

@end
