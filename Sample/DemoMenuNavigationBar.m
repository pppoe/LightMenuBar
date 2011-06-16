//
//  DemoMenuNavigationBar.m
//  LightMenuBar
//
//  Created by Haoxiang on 6/16/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "DemoMenuNavigationBar.h"
#import "LightMenuBar.h"

enum {
    MenuBarItemBack,
    MenuBarItemPushRed,
    MenuBarItemPushGreen,
    MenuBarItemNewModalYellow,
    MenuBarItemNewModalOrange,
    MenuBarItemReplaceModalBlue,
    MenuBarItemCount
};

@implementation DemoMenuNavigationBar

- (id)init {
    self = [super initWithNibName:@"DemoMenuNavigationBar" bundle:[NSBundle mainBundle]];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menuBar.delegate = self;
    _menuBar.barStyle = LightMenuBarStyleButton;
    _menuBar.containerViewController = _containerViewController;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark LightMenuBarDelegate
- (NSUInteger)itemCountInMenuBar:(LightMenuBar *)menuBar {
    return MenuBarItemCount;
}

- (NSString *)itemTitleAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar {
    NSString *itemTitle = nil;
    switch (index) {
        case MenuBarItemBack:
            itemTitle = @"Back";
            break;
        case MenuBarItemPushRed:
            itemTitle = @"Red";
            break;
        case MenuBarItemPushGreen:
            itemTitle = @"Green";
            break;
        case MenuBarItemNewModalYellow:
            itemTitle = @"Yellow";
            break;
        case MenuBarItemNewModalOrange:
            itemTitle = @"Orange";
            break;
        case MenuBarItemReplaceModalBlue:            
            itemTitle = @"Blue";
            break;
        default:
            break;
    }
    return itemTitle;
}

- (void)itemSelectedAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar {
    switch (index) {
        case MenuBarItemBack:
            [menuBar backViewController];
            break;
        case MenuBarItemPushRed:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor redColor];
            [menuBar pushViewController:vc];
            [vc release];
        }
            break;
        case MenuBarItemPushGreen:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor greenColor];
            [menuBar pushViewController:vc];
            [vc release];
        }
            break;
        case MenuBarItemNewModalYellow:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor yellowColor];
            [menuBar presentModalViewController:vc];
            [vc release];
        }
            break;
        case MenuBarItemNewModalOrange:
        {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor orangeColor];
            [menuBar presentModalViewController:vc];
            [vc release];
        }
            break;
        case MenuBarItemReplaceModalBlue:            
        {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor blueColor];
            [menuBar replaceModalViewController:vc];
            [vc release];
        }
            break;
        default:
            break;
    }
}

//< Optional
//- (CGFloat)itemWidthAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar {
//    return 60.0f;
//}

#if USE_CUSTOM_DISPLAY 

/****************************************************************************/
//< For Background Area
/****************************************************************************/

/**< Top and Bottom Padding, by Default 5.0f */
- (CGFloat)verticalPaddingInMenuBar:(LightMenuBar *)menuBar {
    return 0.0f;
}

/**< Left and Right Padding, by Default 5.0f */
- (CGFloat)horizontalPaddingInMenuBar:(LightMenuBar *)menuBar {
    return 0.0f;
}

/**< Corner Radius of the background Area, by Default 5.0f */
- (CGFloat)cornerRadiusOfBackgroundInMenuBar:(LightMenuBar *)menuBar {
    return 0.0f;
}

- (UIColor *)colorOfBackgroundInMenuBar:(LightMenuBar *)menuBar {
    return [UIColor blackColor];
}

/****************************************************************************/
//< For Button 
/****************************************************************************/

/**< Corner Radius of the Button highlight Area, by Default 5.0f */
- (CGFloat)cornerRadiusOfButtonInMenuBar:(LightMenuBar *)menuBar {
    return 1.0f;
}

- (UIColor *)colorOfButtonHighlightInMenuBar:(LightMenuBar *)menuBar {
    return [UIColor whiteColor];
    
}

- (UIColor *)colorOfTitleNormalInMenuBar:(LightMenuBar *)menuBar {
    return [UIColor whiteColor];
}

- (UIColor *)colorOfTitleHighlightInMenuBar:(LightMenuBar *)menuBar {
    return [UIColor blackColor];
}

- (UIFont *)fontOfTitleInMenuBar:(LightMenuBar *)menuBar {
    return [UIFont systemFontOfSize:15.0f];
}

/****************************************************************************/
//< For Seperator 
/****************************************************************************/

/**< Width of Seperator, by Default 1.0f */
- (CGFloat)seperatorWidthInMenuBar:(LightMenuBar *)menuBar {
    return 0.0f;
}

/**< Height Rate of Seperator, by Default 0.7f */
- (CGFloat)seperatorHeightRateInMenuBar:(LightMenuBar *)menuBar {
    return 0.0f;
}

#endif

@end
