//
//  LightMenuBar.m
//  LightMenuBar
//
//  Created by Haoxiang on 6/9/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "LightMenuBar.h"
#import "LightMenuBarDelegate.h"

@implementation LightMenuBar
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

/**< hex Code in RGB */
- (UIColor *)colorFromCode:(int)hexCode inAlpha:(float)alpha {
    float red   = ((hexCode >> 16) & 0x000000FF)/255.0f
    float green = ((hexCode >> 8) & 0x000000FF)/255.0f
    float blue  = ((hexCode) & 0x000000FF)/255.0f
    return [UIColor colorWithRed:red
                           green:green
                            blue:blue
                           alpha:alpha];
}

- (void)addRoundCornerRect:(CGRect)rect withCornerRadius:(CGFloat)cornerRadius inContext:(CGContextRef)context {
    
    float maxX = CGRectGetMaxX(rect);
    float midX = CGRectGetMidX(rect);
    float minX = CGRectGetMinX(rect);

    float maxY = CGRectGetMaxY(rect);
    float midY = CGRectGetMidY(rect);
    float minY = CGRectGetMinY(rect);
    
}

- (UIColor *)colorFromCode:(int)hexCode {
    return [self colorFromCode:hexCode inAlpha:1.0f];
}

- (void)drawRect:(CGRect)rect {

    /****************************************************************************/
    //< Parameters
    /****************************************************************************/

    NSUInteger itemCount = [self.delegate itemCountInMenuBar:self];
    
    CGFloat vPadding = 5.0f;
    CGFloat hPadding = 5.0f;
    CGFloat backgroundRad = 5.0f;
    CGFloat buttonRad = 5.0f;
    CGFloat sepWidth = 1.0f;
    CGFloat sepHeightRate = 0.7f;
    
    UIColor *backgoundColor = [self colorFromCode:0x121212];
    UIColor *buttonHighlightColor = [self colorFromCode:0x212121];
    UIColor *titleHighlightColor = [self colorFromCode:0x121212];
    UIColor *titleNormalColor = [self colorFromCode:0x212121];
    UIColor *sepColor = [UIColor whiteColor];
    
    UIFont *titleFont = [UIFont systemFontOfSize:14.0f];
    
    LightMenuBarAnimation animation = LightMenuBarAnimationSlide;
    
    //< TODO, ugly code, any better solution here ?
    
    /****************************************************************************/
    //< For Background Area
    /****************************************************************************/

    /**< Top and Bottom Padding, by Default 5.0f */
    if ([(id)self.delegate respondsToSelector:@selector(verticalPaddingInMenuBar:)])
    {
        vPadding = [self.delegate verticalPaddingInMenuBar:self];
    }
    
    /**< Left and Right Padding, by Default 5.0f */
    if ([(id)self.delegate respondsToSelector:@selector(horizontalPaddingInMenuBar:)])
    {
        hPadding = [self.delegate horizontalPaddingInMenuBar:self];
    }
    
    /**< Corner Radius of the background Area, by Default 5.0f */
    if ([(id)self.delegate respondsToSelector:@selector(cornerRadiusOfBackgroundInMenuBar:)])
    {
        backgroundRad = [self.delegate cornerRadiusOfBackgroundInMenuBar:self];
    }
    
    /**< Color of Background, by Default RGB Code 0x121212 */
    if ([(id)self.delegate respondsToSelector:@selector(colorOfBackgroundInMenuBar:)])
    {
        backgoundColor = [self.delegate colorOfBackgroundInMenuBar:self];
    }
    
    /****************************************************************************/
    //< For Button 
    /****************************************************************************/

    /**< Corner Radius of the Button highlight Area, by Default 5.0f */
    if ([(id)self.delegate respondsToSelector:@selector(cornerRadiusOfButtonInMenuBar:)])
    {
        buttonRad = [self.delegate cornerRadiusOfButtonInMenuBar:self];
    }
    
    /**< Color of Button in Highlight State, by Default RGB Code 0x212121 */
    if ([(id)self.delegate respondsToSelector:@selector(colorOfButtonHighlightInMenuBar:)])
    {
        buttonHighlightColor = [self.delegate colorOfButtonHighlightInMenuBar:self];
    }
    
    /**< Color of Button Title in Highlight State, by Default RGB Code 0x121212 */
    if ([(id)self.delegate respondsToSelector:@selector(colorOfTitleHighlightInMenuBar:)])
    {
        titleHighlightColor = [self.delegate colorOfTitleHighlightInMenuBar:self];
    }
    
    /**< Color of Button Title in Normal State, by Default RGB Code 0x212121 */
    if ([(id)self.delegate respondsToSelector:@selector(colorOfTitleNormalInMenuBar:)])
    {
        titleNormalColor = [self.delegate colorOfTitleNormalInMenuBar:self];
    }
    
    /**< Font for Button Title, by Default [UIFont systemFontOfSize:14.0f] */
    if ([(id)self.delegate respondsToSelector:@selector(fontOfTitleInMenuBar:)])
    {
        titleFont = [self.delegate fontOfTitleInMenuBar:self];
    }    
    
    /****************************************************************************/
    //< For Seperator 
    /****************************************************************************/

    /**< Width of Seperator, by Default 1.0f */
    if ([(id)self.delegate respondsToSelector:@selector(seperatorWidthInMenuBar:)])
    {
        sepWidth = [self.delegate seperatorWidthInMenuBar:self];
    }
    
    /**< Height Rate of Seperator, by Default 0.7f */
    if ([(id)self.delegate respondsToSelector:@selector(seperatorHeightRateInMenuBar:)])
    {
        sepHeightRate = [self.delegate seperatorHeightRateInMenuBar:self];
    }
    
    /**< Color of Seperator, by Default White */
    if ([(id)self.delegate respondsToSelector:@selector(seperatorColorInMenuBar:)])
    {
        sepColor = [self.delegate seperatorColorInMenuBar:self];
    }
    
    /****************************************************************************/
    //< Animation Type
    /****************************************************************************/
    
    /**< Animation Type when an item Button is tapped, by Default LightMenuBarAnimationSlide */
    if ([(id)self.delegate respondsToSelector:@selector(animationForMenuBar:)])
    {
        animation = [self.delegate animationForMenuBar:self];
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /**< Background */
    CGRect bkgrdRect = CGRectMake(hPadding, vPadding, 
                                  rect.size.width - 2*hPadding, 
                                  rect.size.height - 2*vPadding);
    
}

- (void)dealloc {
    [super dealloc];
}


@end
