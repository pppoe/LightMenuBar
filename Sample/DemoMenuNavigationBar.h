//
//  DemoMenuNavigationBar.h
//  LightMenuBar
//
//  Created by Haoxiang on 6/16/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightMenuBarDelegate.h"

@class LightMenuBar;

@interface DemoMenuNavigationBar : UIViewController <LightMenuBarDelegate> {
    IBOutlet LightMenuBar *_menuBar;
    IBOutlet UIViewController *_containerViewController;
}

@end
