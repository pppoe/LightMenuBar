//
//  LightMenuBarDelegate.h
//  LightMenuBar
//
//  Created by Haoxiang on 6/9/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LightMenuBarAnimationNone,
    LightMenuBarAnimationSlide,
    LightMenuBarAnimationBounce,
    LightMenuBarAnimationUnderline
} LightMenuBarAnimation;

@class LightMenuBar;

@protocol LightMenuBarDelegate

@required

- (NSUInteger)itemCountInMenuBar:(LightMenuBar *)menuBar;
- (CGFloat)itemWidthAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar;
- (NSString *)itemTitleAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar;
- (void)itemSelectedAtIndex:(NSUInteger)index inMenuBar:(LightMenuBar *)menuBar;

@optional

/****************************************************************************/
//< For Background Area
/****************************************************************************/

/**< Top and Bottom Padding, by Default 5.0f */
- (CGFloat)verticalPaddingInMenuBar:(LightMenuBar *)menuBar;

/**< Left and Right Padding, by Default 5.0f */
- (CGFloat)horizontalPaddingInMenuBar:(LightMenuBar *)menuBar;

/**< Corner Radius of the background Area, by Default 5.0f */
- (CGFloat)cornerRadiusOfBackgroundInMenuBar:(LightMenuBar *)menuBar;

/**< Color of Background, by Default RGB Code 0x121212 */
- (UIColor *)colorOfBackgroundInMenuBar:(LightMenuBar *)menuBar;

/****************************************************************************/
//< For Button 
/****************************************************************************/

/**< Corner Radius of the Button highlight Area, by Default 5.0f */
- (CGFloat)cornerRadiusOfButtonInMenuBar:(LightMenuBar *)menuBar;

/**< Color of Button in Highlight State, by Default RGB Code 0x212121 */
- (UIColor *)colorOfButtonHighlightInMenuBar:(LightMenuBar *)menuBar;

/**< Color of Button Title in Normal State, by Default RGB Code 0x212121 */
- (UIColor *)colorOfTitleNormalInMenuBar:(LightMenuBar *)menuBar;

/**< Color of Button Title in Highlight State, by Default RGB Code 0x121212 */
- (UIColor *)colorOfTitleHighlightInMenuBar:(LightMenuBar *)menuBar;

/**< Font for Button Title, by Default [UIFont systemFontOfSize:14.0f] */
- (UIFont *)fontOfTitleInMenuBar:(LightMenuBar *)menuBar;

/****************************************************************************/
//< For Seperator 
/****************************************************************************/

/**< Color of Seperator, by Default White */
- (UIColor *)seperatorColorInMenuBar:(LightMenuBar *)menuBar;

/**< Width of Seperator, by Default 1.0f */
- (CGFloat)seperatorWidthInMenuBar:(LightMenuBar *)menuBar;

/**< Height Rate of Seperator, by Default 0.7f */
- (CGFloat)seperatorHeightRateInMenuBar:(LightMenuBar *)menuBar;


/****************************************************************************/
//< Animation Type
/****************************************************************************/

/**< Animation Type when an item Button is tapped, by Default LightMenuBarAnimationSlide */
- (LightMenuBarAnimation)animationForMenuBar:(LightMenuBar *)menuBar;

@end
