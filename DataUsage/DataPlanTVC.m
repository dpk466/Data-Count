//
//  DataPlanTVC.m
//  DataUsage
//
//  Created by Deepak Bharati on 08/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "DataPlanTVC.h"

#import "StartDateVC.h"
#import "PlanTypeTVC.h"
#import "DataCapVC.h"
#import "AddUsageVC.h"

@interface DataPlanTVC ()

@property (nonatomic) NSArray *suffixes;

@end

@implementation DataPlanTVC

@synthesize defaults;

#pragma  mark-Xcode generated methods



- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    self.preferredContentSize = CGSizeMake(320, 500);
    
    defaults =[NSUserDefaults standardUserDefaults];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _keyArray = [[NSArray alloc]initWithObjects:@"Plan type",@"Start date",@"Data cap",@"Add usage", nil];
    
    
    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
    _suffixes = [suffix_string componentsSeparatedByString: @"|"];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if(section == 0)
        return 3;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Data_Plan_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(indexPath.section == 0)
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[_keyArray objectAtIndex:indexPath.row]];
    if(indexPath.section == 1)
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[_keyArray objectAtIndex:indexPath.row+3]];
    
    
    //for 1st section...
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"Plan Type String"]];
        
        if(indexPath.row == 1)
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%i%@",[defaults integerForKey:@"Start Date"],[_suffixes objectAtIndex:[defaults integerForKey:@"Start Date"]]];
            if([defaults integerForKey:@"Plan Type"] == 2)
            {
                // for weekdays.....
                cell.detailTextLabel.text = [defaults objectForKey:@"Week Day"];
            }
        
        }
        
        if(indexPath.row == 2)
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%i %@",[defaults integerForKey:@"Data Cap"],[defaults objectForKey:@"Data Cap Unit"]];
    
    }
        
    //for second section...
    if(indexPath.section == 1 && indexPath.row == 0)
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%i %@",[defaults integerForKey:@"Data Used"],[defaults objectForKey:@"Data Used Unit"]];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    PlanTypeTVC *pttvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Plan_Type"];
    StartDateVC *sdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Start_Date"];
    DataCapVC *dcvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Data_Cap"];
    AddUsageVC *auvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Add_Usage"];
    
    if(indexPath.section == 0)
    switch (indexPath.row)
    {
        case 0:
            pttvc.title = @"Plan type";
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:pttvc animated:YES];

            break;
            
        case 1:
            sdvc.title = @"Start date";
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:sdvc animated:YES];
            break;
            
        case 2:
            dcvc.title = @"Data cap";
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:dcvc animated:YES];
            break;
            
        default:
            break;
     }
    
     if(indexPath.section == 1 &&  indexPath.row == 0)
     {
            auvc.title = @"Add usage";
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:auvc animated:YES];
         
         /*
         UIAlertView *alert = [[UIAlertView alloc]
                               initWithTitle:@"Add usage"
                               message:@"This data will be added to download in Cellular"
                               delegate:self
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
         [alert show];*/
     }

}


@end
