//
//  PlanTypeVC.m
//  DataUsage
//
//  Created by Deepak Bharati on 25/09/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "PlanTypeVC.h"
#import "StartDateVC.h"

@interface PlanTypeVC ()

@property (nonatomic) NSUInteger planTypeRow;


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UINavigationBar *myNavigationBar;

@end

@implementation PlanTypeVC

@synthesize defaults;

#pragma  mark-Xcode generated methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 500);
    self.navigationController.navigationBarHidden = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _planType = [[NSArray alloc]initWithObjects:@"Monthly",@"30 Days",@"Weekly",@"Daily", nil];
    
    defaults = [NSUserDefaults standardUserDefaults];
    self.planTypeRow = [defaults integerForKey:@"Plan Type"];
    
    if([defaults boolForKey:@"installed"])
    {
        //remove nevigation title...
        [self.myNavigationBar removeFromSuperview];
    }
    
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
    if(self.planTypeRow)
    {
        [defaults setInteger:self.planTypeRow forKey:@"Plan Type"];
    }
    if(planTypeString)
    {
        [defaults setObject:planTypeString forKey:@"Plan Type String"];
    }
    
}


// only for installation time..
- (IBAction)action:(UIBarButtonItem *)sender
{
    [self save];
    StartDateVC *sdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Start_Date"];
    //[self  presentViewController:sdvc animated:YES completion:nil];
    [self.navigationController  pushViewController:sdvc animated:YES];
}


@end
