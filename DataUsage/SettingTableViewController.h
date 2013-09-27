//
//  SettingTableViewController.h
//  DataUsage
//
//  Created by Deepak Bharati on 16/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol settingMenuDelegate <NSObject>//protocol for implementing popover in iPad
@required
-(void)dismissSettingPopOverView;
@end

@interface SettingTableViewController : UITableViewController

@property (nonatomic, weak) id<settingMenuDelegate> delegate;//delegate for calling methods

@end

