//
//  ColorsTVC.m
//  DataUsage
//
//  Created by Deepak Bharati on 28/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ColorsTVC.h"

@interface ColorsTVC ()

@property (strong,nonatomic) NSArray *colorTypesImages;
@property (nonatomic) NSUInteger themeTypeRow;



@end

@implementation ColorsTVC

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
    
    _colorTypesImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"defaultTheme.png"],[UIImage imageNamed:@"pastelsTheme.png"],[UIImage imageNamed:@"coffeeTheme.png"], nil];
    
    defaults = [NSUserDefaults standardUserDefaults];
    self.themeTypeRow = [defaults integerForKey:@"Theme Type"];
    
   
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [_colorTypesImages count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Color_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSUInteger row = [indexPath section];
    
    
    if (row == self.themeTypeRow)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UIImage *myImage = [_colorTypesImages objectAtIndex:indexPath.section];
 
    UIImageView *myBgImgView = [[UIImageView alloc]initWithFrame:cell.frame];
    [myBgImgView setContentMode:UIViewContentModeScaleToFill];
    
    
      
    //Enable maskstobound so that corner radius would work.
    [myBgImgView.layer setMasksToBounds:YES];
    //Set the corner radius
    [myBgImgView.layer setCornerRadius:10.0];
    //Set the border color
    [myBgImgView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    //Set the image border width
    [myBgImgView.layer setBorderWidth:5.0];
   
    [myBgImgView setImage:myImage];
        
    [cell setBackgroundView:myBgImgView];
    //cell.imageView.image = myImage;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Default";
            break;
        case 1:
            sectionName = @"Pastels";
            break;
        case 2:
            sectionName = @"Coffee";
            break;

            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger row = [indexPath section];
    
    self.themeTypeRow = row;
   
    [defaults setInteger:row forKey:@"Theme Type"];

    [defaults setObject:[self tableView:tableView titleForHeaderInSection:row] forKey:@"Theme Type String"];
    [self.tableView reloadData];
   

}



@end
