//
//  SettingTableViewController.m
//  DataUsage
//
//  Created by Deepak Bharati on 16/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "SettingTableViewController.h"

#import "DataPlanTVC.h"
//#import "UsageAlertTVC.h"
#import "PreviousUsageTVC.h"
#import "ThemeTVC.h"
#import "ResetVC.h"
#import "NotificationsViewController.h"
//#import "AboutTVC.h"
//#import "ViewController.h"
//#import "FirstViewController.h"
#import "MyLocalNotifications.h"
#import "AppOsVersion.h"

//#import <MessageUI/MFMessageComposeViewController.h>
#import "Flurry.h"


@interface SettingTableViewController ()<MFMailComposeViewControllerDelegate>

@property (strong,nonatomic) NSArray *settingArray;
@property (strong,nonatomic) NSUserDefaults *defaults;

@end



@implementation SettingTableViewController

@synthesize delegate;
@synthesize defaults;

#pragma  mark-Xcode generated methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 500);

    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scheduleLocalNotification:) name:@"scheduleLocalNotification" object:nil];
    
    
    defaults = [NSUserDefaults standardUserDefaults];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _settingArray = [NSArray arrayWithObjects:@"Data plan",@"Previous usage",@"Theme",@"Notifications",@"Reset",@"Share",@"See more app",@"Support",nil];
    
    [self setTitle:@"Settings"];

}


-(void)viewWillDisappear:(BOOL)animated
{

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if(section == 0) // Data plan, Previous usage
        return 2;
    if(section == 1) // Theme
        return 1;
    if(section == 2) // Notification, reset
        return 2;
    return 3;        // Share, About
   
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0) // Data plan, Previous usage
        return @"Data";
    
    if(section == 1) // Theme
        return @"Appearance";
    
    if(section == 2) // Notification, reset
        return @"Advanced";
    
    return @"General";         // Share, About
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Setting_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if([indexPath section] == 0)
    {
        cell.textLabel.text = [_settingArray objectAtIndex:indexPath.row];// 0 & 1
    }
    if([indexPath section] == 1)
    {
        cell.textLabel.text = [_settingArray objectAtIndex:indexPath.row+2];// 2
    }
    if([indexPath section] == 2)
    {
        cell.textLabel.text = [_settingArray objectAtIndex:indexPath.row+3];// 3 & 4
    }
    if([indexPath section] == 3)
    {
        cell.textLabel.text = [_settingArray objectAtIndex:indexPath.row+5];// 5 & 6
    }

    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    DataPlanTVC *dataPlanTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Data_Plan"];
    //UsageAlertTVC *usageAlertTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Usage_Alert"];
    PreviousUsageTVC *previousUsageTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Previous_Usage"];
    ThemeTVC *themeTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Theme"];
    NotificationsViewController *notificationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Notifications"];
    ResetVC *resetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Reset"];
    
    //for share
    //AboutTVC *aboutTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"About"];
    
    if([indexPath section] == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                dataPlanTVC.title = @"Data plan";
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:dataPlanTVC animated:YES];
                break;
                
            case 1:
                if([[[defaults objectForKey:@"History"] objectAtIndex:0] count] >= 1)
                {
                    [Flurry logEvent:@"Previous Usage"];
                    NSLog(@"History available");
                    previousUsageTVC.title = @"Previous Usage";
                    // Pass the selected object to the new view controller.
                    [self.navigationController pushViewController:previousUsageTVC animated:YES];
                }
                else
                {
                    [Flurry logEvent:@"No Previous Usage"];
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"Previous usage"
                                          message:[NSString stringWithFormat:@"You have no previous usage data."]
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
                    [alert show];
                }
                break;
                
            default:
                break;
        }
    }
    
    
    if([indexPath section] == 1)
    {
        switch (indexPath.row)
        {
            case 0://Theme
                themeTVC.title = @"Theme";
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:themeTVC animated:YES];
                break;
                
            default:
                break;
        }
    }
    
    if([indexPath section] == 2)
    {
        switch (indexPath.row)
        {
            case 0://Notification
                notificationVC.title = @"Notifications";
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:notificationVC animated:YES];
                break;
                
                
            case 1://Reset
                resetVC.title = @"Reset";
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:resetVC animated:YES];
                [Flurry logEvent:@"goToReset"];
                break;
                

                
            default:
                break;
        }
    }
    
    if([indexPath section] == 3)
    {
        switch (indexPath.row)
        {
            case 0://Share
                [self showActivityViewController];
                break;
                
            case 1:// See more app
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appstore.com/creo"]];
                /*aboutTVC.title = @"About";
                // Pass the selected object to the new view controller.
                [self.navigationController pushViewController:aboutTVC animated:YES];*/
                break;
                
            case 2://Support
                [self support];
                break;
                
            default:
                break;
        }
    }
    
}

#pragma mark- share method

-(void)showActivityViewController
{
    
    
    //-- set up the data objects
    NSString *textObject = @"Keep tracking your cellular and wifi data usage";
    NSURL *url = [NSURL URLWithString:@"http://datacountapp.com"];
    UIImage *image = [UIImage imageNamed:@"iTunesArtwork.png"];
    
    NSArray *activityItems = [NSArray arrayWithObjects:textObject, url,image,
                              
                              
                              nil];
    
    
    //-- initialising the activity view controller
    UIActivityViewController *avc = [[UIActivityViewController alloc]
                                     initWithActivityItems:activityItems
                                     applicationActivities:nil];
    
    //-- define the activity view completion handler
    avc.completionHandler = ^(NSString *activityType, BOOL completed){
        NSLog(@"Activity Type selected: %@", activityType);
        if (completed) {
            NSLog(@"Selected activity was performed.");
        } else {
            if (activityType == NULL) {
                NSLog(@"User dismissed the view controller without making a selection.");
            } else {
                NSLog(@"Activity was not performed.");
            }
        }
    };
    
    //-- define activity to be excluded (if any)
    avc.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypeAssignToContact, UIActivityTypePostToWeibo,UIActivityTypePrint,UIActivityTypeSaveToCameraRoll,nil];
    
    //-- show the activity view controller
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    //    {
    //        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:activityVC];
    //
    //        CGRect rect = [[UIScreen mainScreen] bounds];
    //
    //        [self.popoverController
    //         presentPopoverFromRect:rect inView:self.view
    //         permittedArrowDirections:0
    //         animated:YES];
    //    }
    //    else
    //    {
    [self presentViewController:avc animated:YES completion:nil];
    //    }
    
}

-(void)support
{
    NSDateFormatter *detailedDateFormat = [[NSDateFormatter alloc]init];
    [detailedDateFormat setDateFormat:@"MMM dd, yyyy HH:mm:ss"];
    
    AppOsVersion *appdetail = [[AppOsVersion alloc]init];
    NSMutableArray *supportDetail = [appdetail supportDetailArray];
    NSLog(@"support array = %@",supportDetail);
    NSString *userDesclaimer=[NSString stringWithFormat:@"PLEASE DESCRIBE BELOW THE PROBLEM YOU ARE FACING SO WE CAN IMPROVE YOUR DataCount EXPERIENCE:<br><br><br><br><br>The following details relate to your application and device, helps us diagnose any technical issues which your comments might relate to.<br><br>However, you can remove them if you prefer."];
    NSString *contentEmail =[NSString stringWithFormat:@"%@<br><br>OS version: %@<br>App version: %@<br>Device: %@<br><br>Plan type: %@<br>Start date: %@<br>Data cap: %@%@<br>Earlier usage: %@%@",userDesclaimer,[supportDetail objectAtIndex:0],[supportDetail objectAtIndex:1],[supportDetail objectAtIndex:3],[defaults objectForKey:@"Plan Type String"],[detailedDateFormat stringFromDate:[defaults objectForKey:@"myStartDate"]], [defaults objectForKey:@"Data Cap"],[defaults objectForKey:@"Data Cap Unit"], [defaults objectForKey:@"Data Used"],[defaults objectForKey:@"Data Used Unit"]];
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    //NSLog(@"email called");
    // NSLog(@"Email body == %@",emailBody);
    [composer setMailComposeDelegate:self];
    if ([MFMailComposeViewController canSendMail])
    {
        // [composer setToRecipients:[NSArray arrayWithObjects:@"dpk466@gmail.com", nil]];
        [composer setToRecipients:[NSArray arrayWithObjects:@"support@datacountapp.com", nil]];
        
        // [composer setSubject:@"Testing IOS"];
        [composer setSubject:@"DataCount Feedback"];
        // [composer setMessageBody:emailBody isHTML:NO];
        [composer setMessageBody:contentEmail isHTML:YES];
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:composer animated:YES completion:nil];
        //[self presentModalViewController:composer animated:YES];
        //[self.navigationController pushViewController:composer animated:YES];
        // NSLog(@"mail sent");
    }
    
}

#pragma mark- Mail Delegate method

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if(error)
    {
        // NSLog(@"Error occured ");
        [self dismissViewControllerAnimated:YES completion:^{ }];}
    else {
        [self dismissViewControllerAnimated:YES completion:^{ }];
    }
    [self.tableView reloadData];
}




#pragma mark- Done Button (return)
- (IBAction)action:(UIBarButtonItem *)sender
{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        NSLog(@"Done pressed");
        
        
        if (delegate != nil)
        {
           [delegate dismissSettingPopOverView];//mySettingMenuDelegate Method calledwhich has the definition in (buttom) View Controller...
        }
        
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:^{ }];
    }

    //ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    //[self  presentViewController:vc animated:YES completion:nil];

}

/*
#pragma mark - NSNotification Receiver

- (void)scheduleLocalNotification:(NSNotification *)notification
{
    NSLog(@"Notification Received for scheduling localNotification");
    
    //[self createAndScheduleLocalNotifications];
    [MyLocalNotifications createAndScheduleLocalNotifications];
}
*/

@end
