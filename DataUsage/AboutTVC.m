//
//  AboutTVC.m
//  DataUsage
//
//  Created by Deepak Bharati on 16/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "AboutTVC.h"
#import "AppOsVersion.h"

@interface AboutTVC ()<MFMailComposeViewControllerDelegate>

@property (strong,nonatomic) NSArray *aboutArray;

@end

@implementation AboutTVC


@synthesize defaults;
#pragma mark - xcode life cycle method

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 500);
    
    defaults = [NSUserDefaults standardUserDefaults];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _aboutArray = [[NSArray alloc]initWithObjects:@"See more apps",@"Support", nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [_aboutArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"About_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [_aboutArray objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        switch(indexPath.row)
        {
            case 0:
                //See More Apps
                
                break;
                
            case 1:
                //Support
                [self support];
                break;
                
            default:
                break;
        }
    }
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

#pragma mark-Mail Delegate method

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


@end
