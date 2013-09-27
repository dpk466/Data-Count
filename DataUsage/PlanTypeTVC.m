//
//  PlanTypeTVC.m
//  DataUsage
//
//  Created by Deepak Bharati on 16/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "PlanTypeTVC.h"
#import "StartDateVC.h"
#import "MyLocalNotifications.h"

@interface PlanTypeTVC ()

@property (nonatomic) NSUInteger planTypeRow;



@end

@implementation PlanTypeTVC

@synthesize defaults;

#pragma  mark-Xcode generated methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 500);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _planType = [[NSArray alloc]initWithObjects:@"Monthly",@"30 Days",@"Weekly",@"Daily", nil];
    
    defaults = [NSUserDefaults standardUserDefaults];
    self.planTypeRow = [defaults integerForKey:@"Plan Type"];
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
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
    return [_planType count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Plan_Type_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [_planType objectAtIndex:indexPath.row];
 
    NSUInteger row = [indexPath row];

 
    if (row == self.planTypeRow)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"Choose your data plan type";
    
}

#pragma mark - Table view delegate

id planTypeString;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    NSUInteger row = [indexPath row];
          
    self.planTypeRow = row;
    
    planTypeString = [_planType objectAtIndex:indexPath.row];
    
    [self.tableView reloadData];
    
    
}

- (void) save
{
    NSLog(@"saving plan type");
   
    [defaults setInteger:self.planTypeRow ? self.planTypeRow : 0 forKey:@"Plan Type"];
   
    if(planTypeString)
    {
        [defaults setObject:planTypeString forKey:@"Plan Type String"];
    }
    
    [MyLocalNotifications createAndScheduleLocalNotifications];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
