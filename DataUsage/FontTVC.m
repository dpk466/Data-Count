//
//  FontTVC.m
//  DataUsage
//
//  Created by Deepak Bharati on 28/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "FontTVC.h"
//#import "Fonts.h"



@interface FontTVC ()

@property (strong,nonatomic)NSMutableArray *fontStyleNames;
@property (nonatomic) NSUInteger fontStyleRow;

@end

@implementation FontTVC

@synthesize defaults;

#pragma mark - xcode life cycle method

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 500);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    _fontStyleNames = (NSMutableArray *)@[@"Helvetica",@"Helvetica-Light",@"HelveticaNeue",@"HelveticaNeue-Thin",@"Cochin",@"Gill Sans",@"Georgia"];

    // Uncomment the following line to have entire set of font-style in app
    //_fontStyleNames = [[Fonts alloc]init].fontNamesArray;
    
   for(NSString * myfontName in _fontStyleNames)
   {
       NSLog(@"....%@",myfontName);
   }
    
    defaults = [NSUserDefaults standardUserDefaults];
    self.fontStyleRow = [defaults integerForKey:@"Font Style"];
    
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
    return  [_fontStyleNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Font_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [_fontStyleNames objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:[_fontStyleNames objectAtIndex:indexPath.row] size:cell.textLabel.font.pointSize];
    
    NSUInteger row = [indexPath row];
    
    if (row == self.fontStyleRow)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    
    self.fontStyleRow = row;
    
    [defaults setInteger:row forKey:@"Font Style"];
    [defaults setObject:[_fontStyleNames objectAtIndex:indexPath.row] forKey:@"FontName"];
    
    [self.tableView reloadData];
}

@end
