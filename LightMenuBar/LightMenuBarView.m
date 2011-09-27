//
//  LightMenuBarView.m
//  LightMenuBar
//
//  Created by Haoxiang on 6/10/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import "LightMenuBarView.h"
#import "LightMenuBar.h"
#import "LightMenuBarDelegate.h"

#import <QuartzCore/QuartzCore.h>

@implementation LightMenuBarView
@synthesize menuBar = _menuBar;
@synthesize selectedItemIndex = _selectedItemIndex;
@synthesize delegate = _delegate;

- (void)setDelegate:(id <LightMenuBarDelegate>)theDelegate {
    _delegate = theDelegate;
    //< Trigger the parameter fetch here
    [self fillParams];
}

- (void)setup {
    _selectedItemIndex = NSNotFound;
    
    UITapGestureRecognizer *tapGesReco = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesRecoDetected:)];
    tapGesReco.numberOfTapsRequired = 1;
    tapGesReco.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGesReco];
    [tapGesReco release];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

/**< hex Code in RGB */
- (UIColor *)colorFromCode:(int)hexCode inAlpha:(float)alpha {
    float red   = ((hexCode >> 16) & 0x000000FF)/255.0f;
    float green = ((hexCode >> 8) & 0x000000FF)/255.0f;
    float blue  = ((hexCode) & 0x000000FF)/255.0f;
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
    
    CGContextMoveToPoint(context, minX, midY);
    CGContextAddArcToPoint(context, minX, minY, midX, minY, cornerRadius);
    CGContextAddArcToPoint(context, maxX, minY, maxX, midY, cornerRadius);
    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, cornerRadius);
    CGContextAddArcToPoint(context, minX, maxY, minX, midY, cornerRadius);
}

- (UIColor *)colorFromCode:(int)hexCode {
    return [self colorFromCode:hexCode inAlpha:1.0f];
}

- (void)fillParams {

    LightMenuBar *menuBar = self.menuBar;

    /****************************************************************************/
    //< Parameters
    /****************************************************************************/
        
    itemCount = [self.delegate itemCountInMenuBar:menuBar];
    
    vPadding = 5.0f;
    hPadding = 5.0f;
    backgroundRad = 5.0f;
    buttonRad = 5.0f;
    sepWidth = 1.0f;
    sepHeightRate = 0.7f;
    
    backgoundColor = [self colorFromCode:0xe9f4e9];
    buttonHighlightColor = [self colorFromCode:0x4d9c5d];
    titleHighlightColor = [self colorFromCode:0xe9f4e9];
    titleNormalColor = [self colorFromCode:0x4d9c5d];
    sepColor = [UIColor whiteColor];
    
    titleFont = [UIFont systemFontOfSize:12.0f];
    
    //< TODO, ugly code, any better solution here ?
    
    /****************************************************************************/
    //< For Background Area
    /****************************************************************************/
    
    /**< Top and Bottom Padding, by Default 5.0f */
    if ([(id)self.delegate respondsToSelector:@selector(verticalPaddingInMenuBar:)])
    {
        vPadding = [self.delegate verticalPaddingInMenuBar:menuBar];
    }
    
    /**< Left and Right Padding, by Default 5.0f */
    if ([(id)self.delegate respondsToSelector:@selector(horizontalPaddingInMenuBar:)])
    {
        hPadding = [self.delegate horizontalPaddingInMenuBar:menuBar];
    }
    
    /**< Corner Radius of the background Area, by Default 5.0f */
    if ([(id)self.delegate respondsToSelector:@selector(cornerRadiusOfBackgroundInMenuBar:)])
    {
        backgroundRad = [self.delegate cornerRadiusOfBackgroundInMenuBar:menuBar];
    }
    
    if ([(id)self.delegate respondsToSelector:@selector(colorOfBackgroundInMenuBar:)])
    {
        backgoundColor = [self.delegate colorOfBackgroundInMenuBar:menuBar];
    }
    
    /****************************************************************************/
    //< For Button 
    /****************************************************************************/
    
    /**< Corner Radius of the Button highlight Area, by Default 5.0f */
    if ([(id)self.delegate respondsToSelector:@selector(cornerRadiusOfButtonInMenuBar:)])
    {
        buttonRad = [self.delegate cornerRadiusOfButtonInMenuBar:menuBar];
    }
    
    if ([(id)self.delegate respondsToSelector:@selector(colorOfButtonHighlightInMenuBar:)])
    {
        buttonHighlightColor = [self.delegate colorOfButtonHighlightInMenuBar:menuBar];
    }
    
    if ([(id)self.delegate respondsToSelector:@selector(colorOfTitleHighlightInMenuBar:)])
    {
        titleHighlightColor = [self.delegate colorOfTitleHighlightInMenuBar:menuBar];
    }
    
    if ([(id)self.delegate respondsToSelector:@selector(colorOfTitleNormalInMenuBar:)])
    {
        titleNormalColor = [self.delegate colorOfTitleNormalInMenuBar:menuBar];
    }
    
    if ([(id)self.delegate respondsToSelector:@selector(fontOfTitleInMenuBar:)])
    {
        titleFont = [self.delegate fontOfTitleInMenuBar:menuBar];
    }    
    
    /****************************************************************************/
    //< For Seperator 
    /****************************************************************************/
    
    /**< Width of Seperator, by Default 1.0f */
    if ([(id)self.delegate respondsToSelector:@selector(seperatorWidthInMenuBar:)])
    {
        sepWidth = [self.delegate seperatorWidthInMenuBar:menuBar];
    }
    
    /**< Height Rate of Seperator, by Default 0.7f */
    if ([(id)self.delegate respondsToSelector:@selector(seperatorHeightRateInMenuBar:)])
    {
        sepHeightRate = [self.delegate seperatorHeightRateInMenuBar:menuBar];
    }
    
    /**< Color of Seperator, by Default White */
    if ([(id)self.delegate respondsToSelector:@selector(seperatorColorInMenuBar:)])
    {
        sepColor = [self.delegate seperatorColorInMenuBar:menuBar];
    }
    
//    barAnimation = LightMenuBarAnimationSlide;
//    
//    /**< Animation Type when an item Button is tapped, by Default LightMenuBarAnimationSlide */
//    if ([(id)self.delegate respondsToSelector:@selector(animationForMenuBar:)])
//    {
//        barAnimation = [self.delegate animationForMenuBar:menuBar];
//    }
    
    autoWidth = ![(id)self.delegate respondsToSelector:@selector(itemWidthAtIndex:inMenuBar:)];
    bkgrdRect = CGRectMake(hPadding, vPadding, 
                           self.frame.size.width - 2*hPadding, 
                           self.frame.size.height - 2*vPadding);    
    averWidth = (bkgrdRect.size.width - 2*backgroundRad)/itemCount;
}

- (void)drawRect:(CGRect)rect {
    
    LightMenuBar *menuBar = self.menuBar;

    [self fillParams];
    
        
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.superview.superview.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    /**< Background */
    [self addRoundCornerRect:bkgrdRect withCornerRadius:backgroundRad inContext:context];
    CGContextSetFillColorWithColor(context, backgoundColor.CGColor);
    CGContextFillPath(context);
    
    
    /**< Seperator */
    {
        float currentX = backgroundRad + CGRectGetMinX(bkgrdRect);
        float sepHeight = bkgrdRect.size.height*sepHeightRate;
        for (int i = 0; i < (itemCount - 1); i++)
        {
            float itemWidth = (autoWidth ? averWidth : [self.delegate itemWidthAtIndex:i inMenuBar:menuBar]);
            currentX += itemWidth;
            CGPoint points[2];
            points[0] = CGPointMake(currentX - sepWidth/2.0f, vPadding + (bkgrdRect.size.height - sepHeight)/2.0f);
            points[1] = CGPointMake(currentX - sepWidth/2.0f, vPadding + (bkgrdRect.size.height + sepHeight)/2.0f);
            CGContextSetStrokeColorWithColor(context, sepColor.CGColor);
            CGContextSetLineWidth(context, sepWidth);
            CGContextStrokeLineSegments(context, points, 2);
        }
    }

    /**< Highlight Background */
    {
        if (self.selectedItemIndex != NSNotFound)
        {
            float currentX = backgroundRad + CGRectGetMinX(bkgrdRect);
            float itemWidth = 0.0f;
            for (int i = 0; i < self.selectedItemIndex; i++)
            {
                itemWidth = (autoWidth ? averWidth : [self.delegate itemWidthAtIndex:i inMenuBar:menuBar]);
                currentX += itemWidth;
            }            
            itemWidth = (autoWidth ? averWidth : [self.delegate itemWidthAtIndex:self.selectedItemIndex inMenuBar:menuBar]);            
            float highlightVpadding = buttonRad/2.0f;
            float highlightHpadding = buttonRad/2.0f;
            CGRect highlightRect = CGRectMake(currentX + highlightHpadding, CGRectGetMinY(bkgrdRect) + highlightVpadding, 
                                              itemWidth - 2*highlightHpadding, bkgrdRect.size.height - 2*highlightHpadding);            
            [self addRoundCornerRect:highlightRect 
                    withCornerRadius:buttonRad
                           inContext:context];
            CGContextSetFillColorWithColor(context, buttonHighlightColor.CGColor);
            CGContextFillPath(context);
        }
    }
    
    /**< Titles */
    {
        float currentX = backgroundRad + CGRectGetMinX(bkgrdRect);
        for (int i = 0; i < itemCount; i++)
        {
            float itemWidth = (autoWidth ? averWidth : [self.delegate itemWidthAtIndex:i inMenuBar:menuBar]);

            CGRect titleRect = CGRectMake(currentX, CGRectGetMinY(bkgrdRect), 
                                          itemWidth, bkgrdRect.size.height);
            
            NSString *title =  [self.delegate itemTitleAtIndex:i inMenuBar:menuBar];
            CGSize titleSize = [title sizeWithFont:titleFont constrainedToSize:titleRect.size lineBreakMode:UILineBreakModeTailTruncation];
            
            CGContextSetStrokeColorWithColor(context, titleNormalColor.CGColor);
            CGContextSetFillColorWithColor(context, titleNormalColor.CGColor);
            if (i == self.selectedItemIndex)
            {
                CGContextSetStrokeColorWithColor(context, titleHighlightColor.CGColor);
                CGContextSetFillColorWithColor(context, titleHighlightColor.CGColor);                
            }
            [title drawInRect:CGRectMake(CGRectGetMinX(titleRect) + (titleRect.size.width - titleSize.width)/2.0f, 
                                         CGRectGetMinY(titleRect) + (titleRect.size.height - titleSize.height)/2.0f, 
                                         titleSize.width, titleSize.height) 
                     withFont:titleFont
                lineBreakMode:UILineBreakModeTailTruncation
                    alignment:UITextAlignmentCenter];            
            
            currentX += itemWidth;
        }            
    }
}

- (CGFloat)barLength {
    CGFloat width = self.menuBar.frame.size.width;
    if (!autoWidth)
    {
        width = 0.0f;
        for (int i = 0; i < itemCount; i++)
        {
            width += [self.delegate itemWidthAtIndex:i inMenuBar:self.menuBar];
        }
        width += 2*(hPadding + backgroundRad);
    }
    return width;
}

- (NSUInteger)selectedIndexFromTouchPoint:(CGPoint)pos {
    CGFloat currentX = CGRectGetMinX(bkgrdRect) + backgroundRad;
    for (int i = 0; i < itemCount; i++)
    {
        float itemWidth = (autoWidth ? averWidth : [self.delegate itemWidthAtIndex:i inMenuBar:self.menuBar]);
        if (pos.x >= currentX && pos.x <= (currentX + itemWidth))
        {
            return i;
        }
        currentX += itemWidth;
    }
    return NSNotFound;
}

- (NSUInteger)selectedIndexFromTouch:(UITouch *)touch {
    CGPoint pos = [touch locationInView:self];
    return [self selectedIndexFromTouchPoint:pos];
}

- (void)tapGesRecoDetected:(UITapGestureRecognizer *)gesReco {
    CGPoint pos = [gesReco locationInView:self];
    NSUInteger activeIndex = [self selectedIndexFromTouchPoint:pos];
    if (activeIndex != NSNotFound)
    {
        if ([(id)self.delegate respondsToSelector:@selector(itemSelectableAtIndex:inMenuBar:)])
        {
            if (![self.delegate itemSelectableAtIndex:activeIndex inMenuBar:self.menuBar])
            {
                return;
            }
        }
        
        [self.delegate itemSelectedAtIndex:activeIndex inMenuBar:self.menuBar];
        
        if (self.menuBar.barStyle == LightMenuBarStyleButton)
        {
            self.selectedItemIndex = activeIndex;
            [self blink];
        }
        else if (self.menuBar.barStyle == LightMenuBarStyleItem)
        {
            self.selectedItemIndex = activeIndex;
            [self render];
        }
    }
}

- (void)blink {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:@"render"];
    [self setNeedsDisplay];    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag)
    {
        self.selectedItemIndex = NSNotFound;
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        [self.layer addAnimation:animation forKey:@"render"];
        [self setNeedsDisplay];    
    }
}

- (void)render {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    [self.layer addAnimation:animation forKey:@"render"];
    [self setNeedsDisplay];    
}


- (CGFloat)getCenterOfItemAtIndex:(NSInteger)index {
    CGFloat currentX = CGRectGetMinX(bkgrdRect) + backgroundRad;
    for (int i = 0; i <= index; i++)
    {
        float itemWidth = (autoWidth ? averWidth : [self.delegate itemWidthAtIndex:i inMenuBar:self.menuBar]);
        currentX += itemWidth;
        
        if (i == index)
            currentX = currentX - (itemWidth / 2);
    }
    return floorf(currentX);
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSUInteger activeIndex = [self selectedIndexFromTouch:[touches anyObject]];
//    if (activeIndex != NSNotFound)
//    {
//        if ([(id)self.delegate respondsToSelector:@selector(itemSelectableAtIndex:inMenuBar:)])
//        {
//            if (![self.delegate itemSelectableAtIndex:activeIndex inMenuBar:self.menuBar])
//            {
//                return;
//            }
//        }
//        
//        self.selectedItemIndex = activeIndex;
//        [self render];
//    }
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSUInteger activeIndex = [self selectedIndexFromTouch:[touches anyObject]];
//    if (activeIndex != NSNotFound)
//    {
//        if ([(id)self.delegate respondsToSelector:@selector(itemSelectableAtIndex:inMenuBar:)])
//        {
//            if (![self.delegate itemSelectableAtIndex:activeIndex inMenuBar:self.menuBar])
//            {
//                return;
//            }
//        }
//        
//        self.selectedItemIndex = activeIndex;
//        [self render];
//    }
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSUInteger activeIndex = [self selectedIndexFromTouch:[touches anyObject]];
//    if (activeIndex != NSNotFound)
//    {
//        if ([(id)self.delegate respondsToSelector:@selector(itemSelectableAtIndex:inMenuBar:)])
//        {
//            if (![self.delegate itemSelectableAtIndex:activeIndex inMenuBar:self.menuBar])
//            {
//                return;
//            }
//        }
//        
//        [self.delegate itemSelectedAtIndex:activeIndex inMenuBar:self.menuBar];
//        
//        if (self.menuBar.barStyle == LightMenuBarStyleButton)
//        {
//            self.selectedItemIndex = NSNotFound;
//        }
//        else if (self.menuBar.barStyle == LightMenuBarStyleItem)
//        {
//            self.selectedItemIndex = activeIndex;
//        }
//        [self render];
//    }
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self render];
//}

@end
