//
//  WelcomeViewController.m
//  DataUsage
//
//  Created by Deepak Bharati on 19/09/13.
//  Copyright (c) 2013 Deepak Bharati. All rights reserved.
//

#import "WelcomeViewController.h"
#import "PlanTypeVC.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action:(UIBarButtonItem *)sender
{
 
    PlanTypeVC *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Initial_Plan_Type"];
   // UINavigationController *mynav = [[UINavigationController alloc]initWithRootViewController:pvc];
   // [self presentViewController:mynav animated:YES completion:Nil];

   // [self  presentViewController:pvc animated:YES completion:nil ];
    [self.navigationController pushViewController:pvc animated:YES];
}

@end
