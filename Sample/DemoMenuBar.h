//
//  DemoMenBar.h
//  LightMenuBar
//
//  Created by Haoxiang on 6/16/11.
//  Copyright 2011 DEV. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LightMenuBarDelegate.h"

@interface DemoMenuBar : UIViewController <LightMenuBarDelegate> {
    IBOutlet UILabel *dispLabel;
}

@end
