//
//  LightMenuBar.m
//  LightMenuBar
//
//  Created by Haoxiang on 6/9/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "LightMenuBar.h"
#import "LightMenuBarView.h"
#import "LightMenuBarDelegate.h"

@implementation LightMenuBar
@synthesize menuBarView = _menuBarView;
@synthesize barStyle = _style;
@dynamic delegate;
@dynamic selectedItemIndex;
@dynamic bounces;

#pragma mark property
- (NSUInteger)selectedItemIndex {
    return _menuBarView.selectedItemIndex;
}

- (void)setSelectedItemIndex:(NSUInteger)selectedItemIndex {
    [self setSelectedItemIndex:selectedItemIndex animated:YES notifyDelegate:YES];
}

- (void)setSelectedItemIndex:(NSUInteger)itemIndex animated:(BOOL)animated notifyDelegate:(BOOL)notifyDelegate{
    _menuBarView.selectedItemIndex = itemIndex;
    
    [self handleAutoScrolling:animated];
    
    if (_menuBarView.delegate && notifyDelegate)
        [_menuBarView.delegate itemSelectedAtIndex:itemIndex inMenuBar:self];
}

- (void)handleAutoScrolling:(BOOL)animated {
    [_menuBarView setNeedsDisplay];
    
    CGFloat desiredX = [_menuBarView getCenterOfItemAtIndex:_menuBarView.selectedItemIndex] - (_scrollView.bounds.size.width / 2);
    
    if (desiredX < 0)
        desiredX = 0;
    
    if (desiredX > _menuBarView.barLength - _scrollView.bounds.size.width)
        desiredX = _menuBarView.barLength - _scrollView.bounds.size.width;
    
    
    if (!(_scrollView.bounds.size.width > _menuBarView.barLength)) {
        [_scrollView setContentOffset:CGPointMake(desiredX, 0) animated:animated];
    }
}

- (BOOL)bounces {
    return _scrollView.bounces;
}

- (void)setBounces:(BOOL)bounces {
    _scrollView.bounces = bounces;
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

- (void)layoutSubviews {
    CGFloat barLength = [self.menuBarView barLength];
    _menuBarView.frame = CGRectMake(_menuBarView.frame.origin.x, _menuBarView.frame.origin.y, 
                                    barLength, _menuBarView.frame.size.height);
    _scrollView.contentSize = CGSizeMake(barLength, _scrollView.frame.size.height);
    
    if (_scrollView.bounds.size.width > barLength) {
        CGFloat inset = (_scrollView.bounds.size.width - barLength) / 2;
        _scrollView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
    }
    else {
        _scrollView.contentInset = UIEdgeInsetsZero;
    }
    
    [_menuBarView setNeedsDisplay];
    
}

@end
