//
//  NotificationsViewController.m
//  DataUsage
//
//  Created by Deepak Bharati on 24/09/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "NotificationsViewController.h"
#import "MyLocalNotifications.h"

@interface NotificationsViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *notificationToggleSwitch;

@end

@implementation NotificationsViewController

@synthesize defaults;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 500);
    
	// Do any additional setup after loading the view.
    defaults = [NSUserDefaults standardUserDefaults];
    
    [self.notificationToggleSwitch setOn:[defaults boolForKey:@"NotificationToBeScheduled"]];
    
}



- (IBAction)switchNotificationToOnOrOff:(id)sender
{
    
    //NSLog(@"ON_OFF Switch");
    if (self.notificationToggleSwitch.on)
    {
        NSLog(@"On");
        [defaults setBool:YES forKey:@"NotificationToBeScheduled"];
        //[[UIApplication sharedApplication]cancelAllLocalNotifications];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"scheduleLocalNotification" object:nil];
         [MyLocalNotifications createAndScheduleLocalNotifications];
    }
    else
    {
        NSLog(@"Off");
        [defaults setBool:NO forKey:@"NotificationToBeScheduled"];
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        
    }
    
    
    
}

@end
