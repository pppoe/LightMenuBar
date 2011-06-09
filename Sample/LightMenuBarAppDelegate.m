//
//  LightMenuBarAppDelegate.m
//  LightMenuBar
//
//  Created by Haoxiang on 6/9/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "LightMenuBarAppDelegate.h"
#import "LightMenuBar.h"

@implementation LightMenuBarAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    LightMenuBar *menuBar = [[LightMenuBar alloc] initWithFrame:CGRectMake(0, 20, 320, 40)];
    menuBar.delegate = self;
    [self.window addSubview:menuBar];
    [self.window makeKeyAndVisible];
    [menuBar release];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}

#pragma mark LightMenuBarDelegate
- (NSUInteger)itemCountInMenuBar:(LightMenuBar *)menuBar {
    return 6;
}

- (CGFloat)itemWidthAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar {
    return 50.0f;
}

- (NSString *)itemTitleAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar {
    return @"Name";
}

- (void)itemSelectedAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar {
}

///****************************************************************************/
////< For Background Area
///****************************************************************************/
//
///**< Top and Bottom Padding, by Default 5.0f */
//- (CGFloat)verticalPaddingInMenuBar:(LightMenuBar *)menuBar {
//}
//
///**< Left and Right Padding, by Default 5.0f */
//- (CGFloat)horizontalPaddingInMenuBar:(LightMenuBar *)menuBar {
//}
//
///**< Corner Radius of the background Area, by Default 5.0f */
//- (CGFloat)cornerRadiusOfBackgroundInMenuBar:(LightMenuBar *)menuBar {
//}
//
///**< Color of Background, by Default RGB Code 0x121212 */
//- (UIColor *)colorOfBackgroundInMenuBar:(LightMenuBar *)menuBar {
//}
//
///****************************************************************************/
////< For Button 
///****************************************************************************/
//
///**< Corner Radius of the Button highlight Area, by Default 5.0f */
//- (CGFloat)cornerRadiusOfButtonInMenuBar:(LightMenuBar *)menuBar {
//}
//
///**< Color of Button in Highlight State, by Default RGB Code 0x212121 */
//- (UIColor *)colorOfButtonHighlightInMenuBar:(LightMenuBar *)menuBar {
//}
//
///**< Color of Button Title in Normal State, by Default RGB Code 0x212121 */
//- (UIColor *)colorOfTitleNormalInMenuBar:(LightMenuBar *)menuBar {
//}
//
///**< Color of Button Title in Highlight State, by Default RGB Code 0x121212 */
//- (UIColor *)colorOfTitleHighlightInMenuBar:(LightMenuBar *)menuBar {
//}
//
///**< Font for Button Title, by Default [UIFont systemFontOfSize:14.0f] */
//- (UIFont *)fontOfTitleInMenuBar:(LightMenuBar *)menuBar {
//}
//
///****************************************************************************/
////< For Seperator 
///****************************************************************************/
//
///**< Color of Seperator, by Default White */
//- (UIColor *)seperatorColorInMenuBar:(LightMenuBar *)menuBar {
//}
//
///**< Width of Seperator, by Default 1.0f */
//- (CGFloat)seperatorWidthInMenuBar:(LightMenuBar *)menuBar {
//}
//
///**< Height Rate of Seperator, by Default 0.7f */
//- (CGFloat)seperatorHeightRateInMenuBar:(LightMenuBar *)menuBar {
//}
//
//
///****************************************************************************/
////< Animation Type
///****************************************************************************/
//
///**< Animation Type when an item Button is tapped, by Default LightMenuBarAnimationSlide */
//- (LightMenuBarAnimation)animationForMenuBar:(LightMenuBar *)menuBar {
//}

@end
