//
//  ViewController.h
//  DataUsage
//
//  Created by Deepak Bharati on 06/09/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SettingTableViewController.h"

@interface ViewController : UIViewController < UIPopoverControllerDelegate, settingMenuDelegate >

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property(nonatomic,strong) UINavigationController *navigationControllerForSetting;
@property (nonatomic, strong) UIPopoverController *settingTVCPopover;

@property BOOL pageControlBeingUsed;


@end
