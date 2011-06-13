//
//  LightMenuBarAppDelegate.h
//  LightMenuBar
//
//  Created by Haoxiang on 6/9/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LightMenuBarDelegate.h"

@interface LightMenuBarAppDelegate : NSObject <UIApplicationDelegate, LightMenuBarDelegate> {
    UIWindow *window;
    IBOutlet UILabel *dispLabel;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

