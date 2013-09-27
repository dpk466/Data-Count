//
//  ResetVC.m
//  DataUsage
//
//  Created by Deepak Bharati on 26/08/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "ResetVC.h"

@interface ResetVC ()<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *resetLabel;

@property (strong, nonatomic) IBOutlet UITableViewCell *CellForReset;
@property (strong, nonatomic) IBOutlet UITableViewCell *CellForResetAll;



@end

@implementation ResetVC 

@synthesize defaults;

NSString *alertMessage, *alertTitle;
int tag;

#pragma mark - xcode life cycle method

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(320, 500);
    
	// Do any additional setup after loading the view.
  
    defaults = [NSUserDefaults standardUserDefaults];
   //self.CellForReset.textLabel.text = @"Reset Current";
   //self.CellForResetAll.textLabel.text = @"Reset All";
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
}

#pragma mark- gesture recognisers methods

- (IBAction)gestureToRestet:(id)sender
{
    NSLog(@"Gesture Recognosed for Reset");
    tag = 0;
    alertMessage = @"Reset Current";
    alertTitle = @"Data for your current bill cycle will be erased.";
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: alertMessage
                          message: alertTitle
                          delegate: self
                          cancelButtonTitle: @"Cancel"
                          otherButtonTitles: @"Confirm", nil];
    [alert show];
}

- (IBAction)gestureToRestetAll:(id)sender
{
    NSLog(@"Gesture Recognosed for Reset All");
    tag = 1;
    alertMessage = @"Reset All";
    alertTitle = @"All previous data usage will be erased.";

    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: alertMessage
                          message: alertTitle
                          delegate: self
                          cancelButtonTitle: @"Cancel"
                          otherButtonTitles: @"Confirm", nil];
    [alert show];
}

#pragma mark - alert view confirmation

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        // Cancel was tapped
    }
    else if (buttonIndex == alertView.firstOtherButtonIndex)
    {
        // The other button "CONFIRM" was tapped
        [defaults setInteger:0 forKey:@"Data Used"];
        if(tag == 0)
        {
            [defaults setBool:YES forKey:@"Reset"];
            _resetLabel.text = @"Data for your current bill cycle erased.";
        }
        else if(tag == 1)
        {
            [defaults setObject:nil forKey:@"History"];
            _resetLabel.text = @"All previous data usage erased.";
        }
    }
}



@end
