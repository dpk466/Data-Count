//
//  ThemeTVC.m
//  DataUsage
//
//  Created by Deepak Bharati on 28/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "ThemeTVC.h"

//#import "DisplayTVC.h"
#import "FontTVC.h"
#import "ColorsTVC.h"

@interface ThemeTVC ()

@property (strong,nonatomic)NSArray *themeOptions;

@end

@implementation ThemeTVC

@synthesize defaults;

#pragma mark - xcode life cycle method

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 500);
    
     defaults =[NSUserDefaults standardUserDefaults];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _themeOptions = [[NSArray alloc]initWithObjects:@"Font",@"Colors", nil];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [_themeOptions count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Theme_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [_themeOptions objectAtIndex:indexPath.section];
    if(indexPath.section == 0)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"FontName"]];
    }
    if(indexPath.section == 1)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"Theme Type String"]];
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    FontTVC *fontTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Font"];
    ColorsTVC *colorsTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Colors"];
    switch (indexPath.section)
    {
        case 0:
            fontTVC.title = @"Font";
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:fontTVC animated:YES];
            break;
            
        case 1://Reset
            colorsTVC.title = @"Colors";
            // Pass the selected object to the new view controller.
            [self.navigationController pushViewController:colorsTVC animated:YES];
            break;
            
            
        default:
            break;
    }

}

@end
