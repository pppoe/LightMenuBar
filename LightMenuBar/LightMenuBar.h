//
//  LightMenuBar.h
//  LightMenuBar
//
//  Created by Haoxiang on 6/9/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LightMenuBarDelegate;

@interface LightMenuBar : UIView {
    id<LightMenuBarDelegate> _delegate;
    NSUInteger _selectedItemIndex;
}

@property (nonatomic, assign) id<LightMenuBarDelegate> delegate;

@end
