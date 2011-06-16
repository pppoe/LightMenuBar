//
//  LightMenuBarAppDelegate.h
//  LightMenuBar
//
//  Created by Haoxiang on 6/9/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LightMenuBarAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)demoMenuBarTapped:(id)sender;
- (IBAction)demoMenuNavigationBarTapped:(id)sender;

@end

